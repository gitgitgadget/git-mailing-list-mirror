From: Mark Burton <markb@ordern.com>
Subject: Re: Git describe question
Date: Mon, 14 Jul 2008 09:20:40 +0100
Organization: Order N Ltd.
Message-ID: <20080714092040.4090046b@crow>
References: <20080714085557.246f52b9@crow>
	<7vvdz8hp3d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:23:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJL3-0003UU-18
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876AbYGNIWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYGNIWT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:22:19 -0400
Received: from c2beaomr06.btconnect.com ([213.123.26.184]:26200 "EHLO
	c2beaomr06.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755687AbYGNIWS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:22:18 -0400
Received: from crow.ordern.com (host86-128-141-55.range86-128.btcentralplus.com [86.128.141.55])
	by c2beaomr06.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id AHF68838;
	Mon, 14 Jul 2008 09:20:41 +0100 (BST)
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 4C911190EC1;
	Mon, 14 Jul 2008 09:20:40 +0100 (BST)
In-Reply-To: <7vvdz8hp3d.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr06.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0206.487B0C63.0160,ss=1,fgs=0,
	ip=86.128.141.55,
	so=2007-10-30 19:00:17,
	dmn=5.4.3/2008-02-01
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88399>


Thanks for the speedy response.

> A longer answer.  v1.5.6.X releases are from 'maint'.  The branch has
> forked from the mainline loooong time ago (at v1.5.6, to be exact), and
> has only fixes.  'master' is a separate branch for development that would
> eventually lead to the next major release (planned to be v1.6.0).

Ok, I understand what it's doing now - but that makes me wonder if it
would be useful/possible to be able to specify that git describe only
considers the commits on top of the tag for the current (or some
specified branch). i.e. at the moment, gitk shows 8 commits on top of
v1.5.6.3 in the master branch.

As the master branch is the checked out branch and the v1.5.6.3 tag
tags a commit in that branch (via the merge) is it not possible to only
consider the commits between the tag and the HEAD on that branch?

Sorry, I don't understand the git internals (yet) so I don't know if
this is a stupid question and I am certainly not in a position to try
and implement it myself (yet).

Cheers,

Mark
