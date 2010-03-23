From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rev-list formatting
Date: Tue, 23 Mar 2010 11:52:56 +0100
Message-ID: <4BA89D88.7080803@drmicha.warpmail.net>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>	<4BA7A75A.6060909@lsrfire.ath.cx> <m31vfbpzol.fsf@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 23 11:55:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu1lz-0000RM-3G
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 11:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0CWKzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 06:55:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50369 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab0CWKzo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 06:55:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 77A73E9B09;
	Tue, 23 Mar 2010 06:55:43 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 23 Mar 2010 06:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bbqCaiHxK+I6S+2R7sa893hCh2s=; b=Okurc8ilTDabTl+zACiH/NN3Wnr2J1472D8H8C3dkJRtv5x/g97QSsjSUp/B2ZJx2PB2JbyJEQqY4yvT1FBANHtkDawXYeWDGe5hSMn8vAyJkS17vlfwsqJp+Km3XY7SZKWCi10XJej1LXd4eV9i3zaQq8YdgJG3dynO5aeBS+8=
X-Sasl-enc: Motn9u4cbKkit663AgGBEjvjHRtQoP4TiViOTIoeHJRz 1269341743
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E2B9911E60;
	Tue, 23 Mar 2010 06:55:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <m31vfbpzol.fsf@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143004>

Eli Barzilay venit, vidit, dixit 23.03.2010 02:57:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Am 22.03.2010 12:30, schrieb Eli Barzilay:
>>> Possible bug -- IIUC, this:
>>>
>>>   git rev-list --pretty=3D"%w(40,2,2)%b" $rev
>>>
>>> should show all bodies wrapped as specified, but with 1.7.0.3 I see
>>> only the first one wrapped, and the rest don't show up.  In one of =
my
>>> attempts to sort this, I saw all bodies, but all bodies after the
>>> first were not wrapped as specified.
>>
>> I can't reproduce this when running this command against git's own
>> repo.  Or perhaps I just fail to see it.  Is the one you're trying
>> this on public?  Does it work as expected with some other version of
>> git?
>=20
> Sorry, I've lost track of all the different things I tried, but here'=
s
> something that I can reproduce reliably now, which seems to be a
> similar problem (or at least nothing in the man page explain why it
> would do what it does).  If this is helpful, I'll tar up the
> repository and put it up somewhere.  This is all running in the repo
> -- and it case it matters, it's a bare repo, created with 1.7.0.

I'd say that certainly matters (can't reproduce this one on non-bare
either).

When you say "in the repo", do you mean that you're current directory i=
s
within yourbarerepo.git? Do you have GIT_DIR set explicitly?

>   $ git rev-list --pretty=3D"%b" foo
>=20
> shows one "commit <sha1>" line, then the body, and then the rest of
> the commits (13 of them) with no body at all (just the "commit <sha1>=
"
> lines).
[snip]

Michael
