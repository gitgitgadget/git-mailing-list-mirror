From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 13:37:39 +0100
Message-ID: <4D67A293.2050306@drmicha.warpmail.net>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com> <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 13:41:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pswyr-0004ib-Gx
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 13:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab1BYMlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 07:41:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53959 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932091Ab1BYMk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 07:40:59 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A625420C72;
	Fri, 25 Feb 2011 07:40:58 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 25 Feb 2011 07:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=gMRAJeZHKh9RpQfNTpmWZ7aLS+M=; b=ehImlXpsW26WueP5v556PCfo5uvsRZJYMuLnGUj313O0NTFz0UQd08QOdg9r0RbAS0bbVjUtRIyPRtgxb9XShXIgJP86+1u3x0O6Y+4Id7Fn3Ywr+k9Y+ei4qziWPOR/vdpCioRMGurvzZ+ZEqWEDNBw6gO45hN3/913ksyMJPA=
X-Sasl-enc: Rv68hHV6T+EjD/S9XWtd6u1a+LF1WmaiSh0HaRqrxnN/ 1298637658
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CB43B404D48;
	Fri, 25 Feb 2011 07:40:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimLRc4LybUvmD2ZCKfQqEP+vr+2aBnb4n3B+Mb2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167902>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 25.02.2011 1=
2:17:
> On Fri, Feb 25, 2011 at 11:34, Thomas Ferris Nicolaisen
> <tfnico@gmail.com> wrote:
>> I tried asking the same question on the "newbie" list some time ago:
>>
>> http://groups.google.com/group/git-users/browse_thread/thread/d562b4=
eeac016711
>>
>> Basically, when I go
>>> git revert <commit> <path>
>>
>> .. my expectation was that a new commit would be made reverting the
>> changes from the old commit, but only for specified path/file.
>>
>> Maybe it's a bit of a corner-case, but still would be nice to have
>> once in a while. What do you think?
>=20
> It would. What you can do in the meantime is:
>=20
>     git revert <commit>

=C3=86var meant to write "git revert --no-commit <commit>" here. (Or th=
ere
wouldn't be anything to reset and add.)

>     git reset
>     git add <path>
>     git commit ...
>     git reset --hard # making sure you didn't have uncommited changes=
 earlier

If you want to revert changes to all files but a few, you can do it the
other way round (revert, checkout HEAD^ -- <path>, commit --amend).

Cheers,
Michael
