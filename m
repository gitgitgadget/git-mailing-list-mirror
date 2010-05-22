From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Sat, 22 May 2010 14:15:39 +0000
Message-ID: <AANLkTilmv7Kp0LxXXB7bCOs6F55ymnedRCeF4SKkdlJK@mail.gmail.com>
References: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com>
	 <201005221244.32213.trast@student.ethz.ch>
	 <AANLkTimQzAM7qA32FRFvQC1cx7UEEKtBxjU89whrSqF5@mail.gmail.com>
	 <201005221534.18529.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 22 16:15:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFpUX-0001fJ-FE
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 16:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab0EVOPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 10:15:41 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36059 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0EVOPk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 10:15:40 -0400
Received: by iwn6 with SMTP id 6so2268123iwn.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L3iyANIh+NuDah5w57kLpxKG5KXM6mY1jx/laLR8SkU=;
        b=RwOIXXw/d0ry3c/BVTXoTwXQZvlsSaWyZwRnkOXYnCjmBAJEPXdGxuNhiicerw+ivi
         8AixmC6ZB/OakQr06GzVrrwS5GvM7nc4/0oMNkk3VHCDJWJRF4wh/jWrXh3UZqEqJ8Zv
         N1koDTouTF1lC2n7gul+xCwAcCi9RmL6bFmsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LvXpj9RQEQIllp+NgkTF/x2C1BUQz3BenUXRB9L9VL18xM+Mu58+5RIpoPsi54kt4N
         n2vyCvSK2cLirxIf25bfiZO1QYVX73JkVyaHJwmKz+Sl5ghx0XvG9wKQHf86mLizwJh3
         TkhDCDkVOY1HxwoS7i+6WMB5PXNs4sOE9BW0c=
Received: by 10.231.120.159 with SMTP id d31mr2093787ibr.89.1274537739103; 
	Sat, 22 May 2010 07:15:39 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 22 May 2010 07:15:39 -0700 (PDT)
In-Reply-To: <201005221534.18529.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147527>

On Sat, May 22, 2010 at 13:34, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, May 22, 2010 at 10:44, Thomas Rast <trast@student.ethz.ch> w=
rote:
>> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> > That would completely ruin the scriptability of almost all command=
s.
>> > Imagine the user added the following options as default:
>> > =C2=A0add --edit
> [...]
>> > I'm sure you can find one option that changes the command in somet=
hing
>> > completely different *for every command*.
>>
>> Sure. But so would adding this as git-add to your $PATH:
>>
>> =C2=A0 =C2=A0 #!/bin/sh
>> =C2=A0 =C2=A0 /usr/lib/git-core/git-add --edit $@
>
> Two points:
>
> * This way is not documented in git-config(1), as the proposed
> =C2=A0interface would have to be; hence, it is not "official".
>
> * More importantly, it doesn't work; for builtins such as git-add, no=
t
> =C2=A0even if you put it under the `git --exec-path` (yes, I've teste=
d
> =C2=A0this).

I actually tested it too and found that it didn't work. Then thought
"meh, it's pseudocode" and pressed "Send".

Aside from the specific implementation it's easy to make that work the
right way. You can alias the git command itself and munge its
arguments before passing them on to Git itself.

Anyway, this feature isn't something I actually care about. I only
wanted to suggest that if we're going to get lots of proposals to add
a specific config flag for some specific option in some specific
tool. That maybe it would be easier for everyone if there was some
general facility to do so. It would cut down on special-case code in
individual tools.

>> Git already has plenty of ways to shoot yourself in the foot.
>
> Can't argue with that.

And perhaps a general facility might actually improve scriptability. A
determined user is going to override Git anyway, even if that means
some gross hack involving munging $PATH and overriding of Git
itself. At least if such users were pointed to a general facility
script writers could set GIT_IGNORE_CRAZY_USER_DIRECTIVES=3D1 or
something like that.
