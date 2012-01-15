From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] Document limited recursion pathspec matching with wildcards
Date: Sun, 15 Jan 2012 16:48:51 +0700
Message-ID: <CACsJy8BsautpfSARoGgRzCXANAoXP9e_786iBh0wWy=iyNXmew@mail.gmail.com>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com> <7vfwfhwuzd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 10:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmMiO-0007AO-Nx
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 10:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab2AOJtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 04:49:24 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63121 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab2AOJtX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jan 2012 04:49:23 -0500
Received: by bkuw12 with SMTP id w12so919270bku.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 01:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=14+ktuSggR3DUu3jeOgL7Btlu9i/mwzrRyrefH1RDRk=;
        b=OB+PP8DfjBZR2UhKCBpEcDvUpOYI24sQav3EdOxer/ABAq5IZN8y6bRWMAEYikNAPS
         dXJEhxznOvtmy1j62dIhe35/XZWHgZle0hT1mpfaoe1iGLFk1ZeDIx1nMh05JGQtOUbp
         cD/Gw+9T407vmqzXkGp7J5GUqq8t7uspU6PrI=
Received: by 10.205.132.14 with SMTP id hs14mr3095322bkc.130.1326620962121;
 Sun, 15 Jan 2012 01:49:22 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Sun, 15 Jan 2012 01:48:51 -0800 (PST)
In-Reply-To: <7vfwfhwuzd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188595>

2012/1/15 Junio C Hamano <gitster@pobox.com>:
>> @@ -79,6 +79,9 @@ OPTIONS
>> =C2=A0--max-depth <depth>::
>> =C2=A0 =C2=A0 =C2=A0 For each <pathspec> given on command line, desc=
end at most <depth>
>> =C2=A0 =C2=A0 =C2=A0 levels of directories. A negative value means n=
o limit.
>> + =C2=A0 =C2=A0 This option is ignored if <pathspec> contains active=
 wildcards.
>> + =C2=A0 =C2=A0 In other words if "a*" matches a directory named "a*=
",
>> + =C2=A0 =C2=A0 "*" is matched literally so --max-depth is still eff=
ective.
>
> Do we have a definition of "active wildcard"?

Probably not. I did not know how to phrase it and ended up with
"active wildcard" and an example for clarification.
--=20
Duy
