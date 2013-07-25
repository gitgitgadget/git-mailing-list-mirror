From: =?koi8-r?B?y9PP18nSwc4=?= <xowirun@yandex.ru>
Subject: Re: git and cyrillic branches
Date: Thu, 25 Jul 2013 18:51:57 +0400
Message-ID: <322491374763917@web5g.yandex.ru>
References: <922031374754788@web29h.yandex.ru>
	<20130725164522.f8841abf18742cc5f6e0fdbe@domain007.com>
	<992731374757601@web29h.yandex.ru> <20130725182851.c17d3ed662434d1d91838949@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Thu Jul 25 17:00:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2N1V-0004Ef-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 17:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471Ab3GYO7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jul 2013 10:59:55 -0400
Received: from forward20.mail.yandex.net ([95.108.253.145]:60468 "EHLO
	forward20.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab3GYO7r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 10:59:47 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2013 10:59:47 EDT
Received: from web5g.yandex.ru (web5g.yandex.ru [95.108.252.105])
	by forward20.mail.yandex.net (Yandex) with ESMTP id CA27310406BC;
	Thu, 25 Jul 2013 18:51:58 +0400 (MSK)
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by web5g.yandex.ru (Yandex) with ESMTP id 5C6921D0002;
	Thu, 25 Jul 2013 18:51:58 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1374763918; bh=dCProR782gjKLXRaVI61ixw39bxzXc3Luo67PEbA58k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ODl0V3wy3NHv4RdIL0MTi41JPKHr5exrvzC/6VaoPYwRL6YsgmgR7bsG0fEJ7zjYg
	 MLjxaFGYkgF+/vTwwmBDMQqzjD59loywkhNgtD90LfHrGLaf3KdqYIeEPk+RUC/2Mj
	 WTdNSXeWziL2xR/0dQoPfg9DrMee5D5HV8kG+JGk=
Received: from client.yota.ru (client.yota.ru [188.162.36.106]) by web5g.yandex.ru with HTTP;
	Thu, 25 Jul 2013 18:51:57 +0400
In-Reply-To: <20130725182851.c17d3ed662434d1d91838949@domain007.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231138>

25.07.2013, 18:28, "Konstantin Khomoutov" <kostix+git@007spb.ru>:
> On Thu, 25 Jul 2013 17:06:41 +0400
> =CB=D3=CF=D7=C9=D2=C1=CE <xowirun@yandex.ru> wrote:
>
>>>> =9A=9Ahello! there is problem vith git and cyrillic (utf-8) names =
of
>>>> =9A=9Abranches. branch creates perfectly, but when i clone this re=
mote
>>>> =9A=9Abranch to local host, there are 2 bugs:
>>>> =9A=9A1) "git branch" doesnt show checked branch with asterisk (wh=
ile on
>>>> =9A=9Aremote server it does)
>>>> =9A=9A2) "git push" gives 2 errors: "fatal: BRANCH_NAME cannot be
>>>> =9Aresolved to branch." and "fatal: The remote end hung up
>>>> =9Aunexpectedly" thanks.
>>> =9AWorks for me across two Debian systems: both have Git 1.7.10.4; =
user
>>> =9Aaccounts on both systems have LANG=3Den_US.UTF-8 configured in t=
heir
>>> =9Aenvironment.
>>>
>>> =9ADo both of your systems (local and remote) have an UTF-8-enabled=
 (or
>>> =9Aencoding-agnostic, like "C") locale active?
>> =9Aoh, yes indeed. i was pushing from mac to ubuntu, but ubuntu to
>> =9Aubuntu works fine. although #locale gives almost identical output=
, so
>> =9Ait is something to work out. =D3=D0=C1=D3=C9=C2=CF =DA=C1 =D0=CF=CD=
=CF=DD=D8! 25.07.2013, 16:45,
>
> I'm afraid, this might be not that simple: Git received certain tweak=
s
> to work around certain problems Mac OS X has (as I understand it) wit=
h
> handling UTF-8 on various filesystems it supports; in particular, see
> commits 76759c7dff53e8c84e975b88cb8245587c14c7ba [1]
> and b856ad623e4f686815986c0b9341dd1bfd791e71 [2] which were released =
as
> part of v1.7.12.
>
> So... I'm not sure, but I beleive these fixes might have been related=
 to
> handling filenames in the work tree and the index only, not branches,=
 as
> having branches with non-ASCII names is a weird idea to most
> developers, I think. =9ASo the question is: do you have Git >=3D 1.7.=
12 on
> your Mac OS X machine? =9AIf so, do you still experience this problem=
 (I
> think that Macs do not have non-UTF-8 locales anyway, so this is
> unlikely the root cause).
>
> P.S.
> Please don't top-post as this breaks discussion flow and hence sucks.
>
> 1. https://github.com/git/git/commit/76759c7
> 2. https://github.com/git/git/commit/b856ad6
there is nothing wrong with having branches with non-ASCII names as eng=
lish is not the only language in the world.
problem is still here, i've got ubuntu on VM and same shared git-folder=
 causes this problem on Mac Os and no problems on Ubuntu.
git version on Mac is 1.8.0.1 (on Ubuntu is 1.7.10.4)
