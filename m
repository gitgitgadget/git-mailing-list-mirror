From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git log -M -- filename is not working?
Date: Fri, 7 May 2010 11:10:44 -0700
Message-ID: <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 20:11:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAS12-0003K8-My
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757098Ab0EGSLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 14:11:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55871 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab0EGSLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 14:11:06 -0400
Received: by vws17 with SMTP id 17so306080vws.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 11:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fPSjPdmrM/i9XiJ1P+BQdjX7ld32reYQ/+ysLyfrtCQ=;
        b=f8wVdNNVxEqXLx3JQVuk13CahhWKlvb9E04C0PQnLi4kTwaTb4U/lZo4xCUmHQlfSN
         +y0rqnnK0RC2mGBXiqaO/6O4W8efb7vcqepJOdq3pPFrzRNAwe3iQYu6soeWOqh3+RV7
         qQFfwPoFD9lm/oAiZVLyOSYIt8L1t7qF1x/Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jY7m+ZUaeuTJv1JLoTUzDkypUuEBMY07mjZE/BwSjbUyww4ohd8bZOBrkr82CylMEL
         otTaHzzo1WvDJ4XYvTRfuOlXUvmv5DQ3Qucc9wcZSfveFLKNPue5EGE2hhNRuMbh72Gy
         t3UyUns6SQrsNqQGIsX5/GbH9h7QbAfMRuwAc=
Received: by 10.229.232.144 with SMTP id ju16mr227393qcb.107.1273255865053; 
	Fri, 07 May 2010 11:11:05 -0700 (PDT)
Received: by 10.229.215.131 with HTTP; Fri, 7 May 2010 11:10:44 -0700 (PDT)
In-Reply-To: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146548>

On Fri, May 7, 2010 at 11:07, Eugene Sajine <euguess@gmail.com> wrote:
> Hi!
>
> I tried it in both git 1.6.5.6 and git 1.7.0.5
>
> The file has been moved:
>
> From
> Src/folder1/folder2/File.java
>
> To src/main/java/folder1/folder2/File.java
>
> I don=E2=80=99t think it is relevant but just in case: The author has
> committed the new file first, then the commit was amended with the
> deletion of the source file.
> So we ended up with the rename correctly detected.
>
> Now
> $ git log =E2=80=93M -- src/main/java/folder1/folder2/File.java
>
> Shows only one last commit and doesn=E2=80=99t show the history when =
the file
> was in source folder. Same thing happens with
>
> $ git log =E2=80=93C =C2=A0-- src/main/java/folder1/folder2/File.java
>
> What gives?
>
> Thanks,
> Eugene
>

You want the --follow flag, too.
