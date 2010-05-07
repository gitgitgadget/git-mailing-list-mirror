From: Eugene Sajine <euguess@gmail.com>
Subject: Re: git log -M -- filename is not working?
Date: Fri, 7 May 2010 14:31:23 -0400
Message-ID: <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
References: <z2w76c5b8581005071107w79d30963g725269febe746f0@mail.gmail.com>
	 <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 20:31:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OASKf-0004Ou-T5
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839Ab0EGSbZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 14:31:25 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51449 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0EGSbY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 14:31:24 -0400
Received: by vws17 with SMTP id 17so327691vws.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UggmEpZnWBUQFKpzS15pYxWDqodW7tJHde29Wr8rh84=;
        b=NSlyswRRuAjyXucsWA4YUqiCmDs205RhUD+mof0AvwJy2zAzXW7C3HGNylj3iE0nZR
         CIyZrYYBk3LXX25E4oLEx4/vZJvEtiuYkUMHR5OBxAisHlhPtkYeUOuO5gbWZDTzeHSb
         7jPtDzbQdk8PVVDa4jJcLRVrrsgBtbQ0cEjN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fIo802/V2UgeVKDHs6GVUbpkyj4pm0NGy0CT4o1E5ekdvVkRR/x0vylG9nm4VdmsSd
         qHJa0ouMOOQ6bzyONnrovr8kOwYdIpvmIESvGkdCGQzg7nVZzZb0ZZi3n72xfK8k+mb5
         s/tJs/nQD6L+Lhwv+8CBcheMbNiCcwzMKEHmk=
Received: by 10.229.227.16 with SMTP id iy16mr336543qcb.27.1273257083150; Fri, 
	07 May 2010 11:31:23 -0700 (PDT)
Received: by 10.229.229.6 with HTTP; Fri, 7 May 2010 11:31:23 -0700 (PDT)
In-Reply-To: <h2m8c9a061005071110nf7e63220ked03598bfa66fbc9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146550>

On Fri, May 7, 2010 at 2:10 PM, Jacob Helwig <jacob.helwig@gmail.com> w=
rote:
> On Fri, May 7, 2010 at 11:07, Eugene Sajine <euguess@gmail.com> wrote=
:
>> Hi!
>>
>> I tried it in both git 1.6.5.6 and git 1.7.0.5
>>
>> The file has been moved:
>>
>> From
>> Src/folder1/folder2/File.java
>>
>> To src/main/java/folder1/folder2/File.java
>>
>> I don=E2=80=99t think it is relevant but just in case: The author ha=
s
>> committed the new file first, then the commit was amended with the
>> deletion of the source file.
>> So we ended up with the rename correctly detected.
>>
>> Now
>> $ git log =E2=80=93M -- src/main/java/folder1/folder2/File.java
>>
>> Shows only one last commit and doesn=E2=80=99t show the history when=
 the file
>> was in source folder. Same thing happens with
>>
>> $ git log =E2=80=93C =C2=A0-- src/main/java/folder1/folder2/File.jav=
a
>>
>> What gives?
>>
>> Thanks,
>> Eugene
>>
>
> You want the --follow flag, too.
>

Thanks! I missed this guy. By the way it seems that --follow flag
works without -M or -C.

Are those deprecated or I'm missing the difference between three of the=
m??

Thanks,
Eugene
