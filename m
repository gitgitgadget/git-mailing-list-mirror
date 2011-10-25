From: Eugene Sajine <euguess@gmail.com>
Subject: Re: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 12:50:48 -0400
Message-ID: <CAPZPVFZCQdOsAUMdbcZjmGxVgX5LuKKwcob=qBuNmyX7kYwA4A@mail.gmail.com>
References: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
	<vpqpqhlox45.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:50:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIkDG-0004Kh-Bv
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 18:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab1JYQut convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 12:50:49 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52665 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1JYQus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 12:50:48 -0400
Received: by iaby12 with SMTP id y12so754866iab.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VJft3E+YEIzLmFu+26GuYaSy/RIVTAzCfFkyjkeqeAg=;
        b=w8vekfq62vLBl8CY7wBWdY6XZZqsGlwwUxRggb3hs6/lrRnqMuX6kvJNr+biUCJKkx
         pyqXL/aWYI/FRfZAXcTGkXYOg4gv+3WCVV2vTPFyMXn9RMeklC3tGyzIgTxF1Cb7b4Uk
         A18KMryl95wWuhHepCtMf35+SzDgt6+8cX37A=
Received: by 10.42.151.196 with SMTP id f4mr45546634icw.17.1319561448330; Tue,
 25 Oct 2011 09:50:48 -0700 (PDT)
Received: by 10.231.199.17 with HTTP; Tue, 25 Oct 2011 09:50:48 -0700 (PDT)
In-Reply-To: <vpqpqhlox45.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184221>

On Tue, Oct 25, 2011 at 12:27 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> Hi,
>>
>>
>> We have built git 1.7.6.4 and we have a following problem with it:
>
> Which command did you use to compile it? What does
>
> =C2=A0git --exec-path
>
> say?
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
>

I was not building it myself so i cannot say what command exactly was
used, but i will check it.
OTOH git --exec-path shows:
for version 1.7.4.1 that works properly -
/usr/local/git-1.7.4.1/libexec/git-core
=46or version 1.7.6.4 libexec is located in some other folder...

Let me check what is this all about.

Thanks,
Eugene
