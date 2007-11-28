From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 15:09:57 +0100
Message-ID: <85prxua2bu.fsf@lola.goethe.zz>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:10:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNc9-0007O5-T5
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbXK1OJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbXK1OJu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:09:50 -0500
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:43507 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753560AbXK1OJt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 09:09:49 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 9321F187620;
	Wed, 28 Nov 2007 15:09:47 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 7F8F3345BF1;
	Wed, 28 Nov 2007 15:09:47 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 253CF29D4E2;
	Wed, 28 Nov 2007 15:09:42 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 27A911C4D3AA; Wed, 28 Nov 2007 15:09:57 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711281355460.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 13:57:03 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4936/Wed Nov 28 11:55:15 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66338>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It might be POSIX, but there are shells that do not like the
> expression 'export VAR=VAL'.  To be on the safe side, rewrite them
> into 'VAR=VAL' and 'export VAR'.

This seems like activism to me: if no supported shell has a problem with
that construct, why bother?

There probably should be a list of shells we try supporting, and in
particular a list of those where we don't bother.

And if a POSIX construct is supported by all shells we try supporting, I
don't see a point in patching it away.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
