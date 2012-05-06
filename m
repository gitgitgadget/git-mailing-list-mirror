From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git-scm.com refresh
Date: Sun, 6 May 2012 04:31:35 +0200
Message-ID: <CAMP44s28Xy4PB-k33RYU=W2Wa+SLs7GDkhr=DohUP_hqr5ur9Q@mail.gmail.com>
References: <CAP2yMaJy=1c3b4F72h6jL_454+0ydEQNXYiC6E-ZeQQgE0PcVA@mail.gmail.com>
	<7vd36j8lc3.fsf@alter.siamese.dyndns.org>
	<CAP2yMaJsDysqwwUga+fyWhUV-r78FoK7psY7howNBOCnsKLhvA@mail.gmail.com>
	<7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 06 04:32:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQrGe-0004AH-9q
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 04:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2EFCbh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 22:31:37 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40084 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab2EFCbg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 22:31:36 -0400
Received: by eaaq12 with SMTP id q12so1117407eaa.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 19:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=K10LKp5DKlIRBFk2HqHKm1Zp98JKtFWzpWgkS9ASs4A=;
        b=azdOgdPwgj4gDVrtgmNhyrniDr/aJlLCicZno4y+/5Yp9v6YMcs5T9fRelC66IICZW
         yXkzO79DznkkEJpq9VzMavYUGMD2HNlae6HioHYUBkor8vLvuf2vdQ71LuupwSopdGZY
         iTzvlZd2BV0TAscKBl8Eotp+Cy1MQCMHZw0YQSaiJRwvR1M09qAdjffAWDEkCKxOrcrt
         KyyZk3d133hdpo0zglkj+nLJPrk6H6qRHF3BE97+dNg2yr5HIQzKcmxRJEW7PslId4Wy
         lEFeayqQ9B4wOf6HdYaRY/405FwGL1jHfopWKrulypdgh0Qifjq8RZxIDc3zIeq6O0Ft
         m/jA==
Received: by 10.213.20.72 with SMTP id e8mr552609ebb.85.1336271495356; Sat, 05
 May 2012 19:31:35 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 19:31:35 -0700 (PDT)
In-Reply-To: <7vwr4q6qbh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197144>

On Sun, May 6, 2012 at 3:39 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Scott Chacon <schacon@gmail.com> writes:
>
>>> As "diff" is listed in "Basic Snapshotting", and it will not
>>> be able to achieve that without being able to apply its output back=
 to the
>>> working tree or to the index, I would suggest moving "apply" to the
>>> section as well.
>>
>> I have to disagree. =C2=A0You are thinking of 'apply' from an intern=
als
>> perspective I have to assume, because I use 'diff' every single day
>> for all sorts of stuff ("what is modified and unstaged?", "what is
>> modified and staged?", "what is different between these two branches=
?"
>> etc) ...
>
> The other day when I was surfing the 'net, I found a blog that was
> complaining about Git UI. =C2=A0Some of the things were worth listeni=
ng to, but
> there was one item I really had to scratch my head where the misconce=
ption
> behind the complaint came from. =C2=A0I am typing from memory without=
 bothering
> to go back to the site to quote, but the complaint essentially was:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Getting a patch is easy with "git diff", b=
ut to apply it you need
> =C2=A0 =C2=A0 =C2=A0 =C2=A0to make it an email and feed it to "git am=
"??? =C2=A0That's crazy.
>
> Of course it *is* crazy, if that were the case. I was wondering why t=
he
> obvious "patch" (or "git apply") did not get into the mind of the aut=
hor,
> and I think I now know why.
>
> If the owner of the site that people call "git's home page" does not =
care
> about those who take diffs and apply them as patches, and thinks "git
> apply" as a mere implementation detail of "git am", it is understanda=
ble
> that such a misconception is spread widely to harm users without gett=
ing
> corrected. Who knows other Git fanboys are spreading misinformation i=
n a
> similar way. Sigh...

So you think moving "git apply" to another section there is going to
fix the problem? And what is the problem? That some random guy in a
blog post thinks it's crazy to use 'git format-patch' and 'git am'? I
don't think that's a problem worth worrying about, and I don't think
it's crazy.

Who cares if people don't know about "git apply"? I too have used it
very rarely, and almost every time I gave up. It's not really useful
because if there are conflicts (and there usually are), the thing just
fails, and 'git apply --reject' (horrible name BTW; apply and reject a
patch?) is too cumbersome. It's much easier to just avoid it.

>> ... where I can't think of a single time I've ever used 'apply'. =C2=
=A0In
>> fact, even the times when I have needed to apply a patch generated
>> from 'diff' I used 'patch -p1' because I know it better.
>
> As you are supposed to be one of the top-level Git Teachers, I wish y=
ou
> knew better. =C2=A0Here is a free Git lesson. =C2=A0Consider "git app=
ly" as
>
> =C2=A0 =C2=A0a better version of "patch" that knows how to work bette=
r with Git by
> =C2=A0 =C2=A0understanding rename and binary patches, and allows them=
 to be applied
> =C2=A0 =C2=A0to the working tree and the index (the latter is most us=
eful when the
> =C2=A0 =C2=A0patch contains new files)
>
> and teach it as such.

It's still basically useless.

> "diff" pairs with "apply", and "format-patch" pairs with "am".

A contributor uses 'format-patch' often, a maintainer uses 'am' often,
but who uses 'apply'? Nobody. Who uses 'diff'? Everybody.

'git diff' is *essential* to see what's going on with the staging
area, and the working directory.

When do you actually *need* 'git apply'? Never; you can always achieve
the same in different ways probably much easier.

> I wouldn't mind adding "git patch" as a built-in synonym/alias for "g=
it
> apply", if you think that would make the above pairing more obvious. =
=C2=A0Many
> computer users know what "patch" does already even they have never us=
ed
> any SCM.

'git patch' would certainly make more sense, but even more would be to
make it actually usable so mergetool could be used in case of
conflicts, or even just having the typical conflict markers.

But even with all that, it still wouldn't be as essential as 'git diff'=
=2E

Cheers.

--=20
=46elipe Contreras
