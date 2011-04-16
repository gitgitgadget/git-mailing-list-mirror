From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCHv2] doc: Clarify that "cherry-pick -x" does not use "git notes"
Date: Sat, 16 Apr 2011 09:19:57 +0200
Message-ID: <BANLkTi=jr0hkmBUGj7tHURSj5XiJkyyQqg@mail.gmail.com>
References: <4DA7F73B.9050007@gmail.com>
	<7v7have8wo.fsf@alter.siamese.dyndns.org>
	<4DA8862F.5070102@gmail.com>
	<BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 09:20:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAznq-0004s9-Tn
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 09:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab1DPHT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 03:19:58 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44997 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1DPHT6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 03:19:58 -0400
Received: by qyk7 with SMTP id 7so133719qyk.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x9gJ1k9BNN1cu12Qo61LJYQZiDSl3Kr3ISSG83KTVpg=;
        b=udwxbMi/E3WteaTl3rzZA3r/0waf/vxOLwYVe32J48cKtINPfbwbfu4rJWsxoxhcK8
         ysc/Cnqxir4zllOsKZJIOT7QuKXgnMg6Qqjbr9JEm5FuPjlA/esLLu4VdondrG2FRrWV
         uPWFA8KtU3o8QtYpN7koGNM46hdY5zG8wXWus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HJnb7Vcxy0r2E0sQXSzjikW71oTOqLFpxPQZ5Iu1Wu1k5vBv+RHYAgCVwXPzwaohgS
         0LKAyqL363eIvdqM7prnnzmzrMFocagPIscwpbjtYTRTLUAlZqWAJTHlVVHeNmKVW2EB
         mQMq9YqkGJSUYKaBCIfwj71wWkFDy15fOE8O4=
Received: by 10.224.214.136 with SMTP id ha8mr2064715qab.220.1302938397210;
 Sat, 16 Apr 2011 00:19:57 -0700 (PDT)
Received: by 10.229.241.17 with HTTP; Sat, 16 Apr 2011 00:19:57 -0700 (PDT)
In-Reply-To: <BANLkTi=HecmdGbEX5inqUi4FZ5Ty+L1Ybg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171666>

On Sat, Apr 16, 2011 at 00:22, Jay Soffian <jaysoffian@gmail.com> wrote=
:

>> =C2=A0-x::
>> - =C2=A0 =C2=A0 =C2=A0 When recording the commit, append to the orig=
inal commit
>> - =C2=A0 =C2=A0 =C2=A0 message a note that indicates which commit th=
is change
>> - =C2=A0 =C2=A0 =C2=A0 was cherry-picked from. =C2=A0Append the note=
 only for cherry
>> + =C2=A0 =C2=A0 =C2=A0 When recording the commit, append a line that=
 says
>> + =C2=A0 =C2=A0 =C2=A0 "(cherry picked from commit ...)" to the orig=
inal commit
>> + =C2=A0 =C2=A0 =C2=A0 message in order to indicate which commit thi=
s change was
>> + =C2=A0 =C2=A0 =C2=A0 cherry-picked from. =C2=A0This is done only f=
or cherry
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0picks without conflicts. =C2=A0Do not use=
 this option if
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0you are cherry-picking from your private =
branch because
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0the information is useless to the recipie=
nt. =C2=A0If on the
>
> As long as you're nearby, "This is done only for cherry=C2=A0picks wi=
thout
> conflicts." can be dropped. It's no longer true.

How can this be not true anymore? If you get a conflict while picking,
you're asked to resolve the conflict and then commit via "git commit
-c <picked_sha1>". Doing so will *not* give you the mentioned "(cherry
picked from commit ...)" line.

--=20
Sebastian Schuberth
