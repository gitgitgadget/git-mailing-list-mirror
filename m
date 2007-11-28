From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Wed, 28 Nov 2007 17:03:02 +0100
Message-ID: <85ve7m8iix.fsf@lola.goethe.zz>
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
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
	<474D7D92.2000106@viscovery.net>
	<Pine.LNX.4.64.0711281552440.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxPfM-0001uT-4w
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:21:36 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPUr-0008Eo-8P
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:10:45 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxPU4-0004lB-Vb
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbXK1QC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756655AbXK1QC4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:02:56 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:43941 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753560AbXK1QCy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 11:02:54 -0500
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 8E9F631E9B2;
	Wed, 28 Nov 2007 17:02:53 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 7126A45C049;
	Wed, 28 Nov 2007 17:02:53 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-037-196.pools.arcor-ip.net [84.61.37.196])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 3329336E869;
	Wed, 28 Nov 2007 17:02:43 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 442F91C4D3AA; Wed, 28 Nov 2007 17:03:02 +0100 (CET)
In-Reply-To: <Pine.LNX.4.64.0711281552440.27959@racer.site> (Johannes
	Schindelin's message of "Wed, 28 Nov 2007 15:56:11 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4937/Wed Nov 28 14:53:46 2007 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.5, required=5.0, autolearn=disabled, AWL=3.507,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 907456EBD51654D4E8A325E418E1ACE98440D933
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -34 maxlevel 200 minaction 2 bait 0 mail/h: 32 total 725217 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66367>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It might be POSIX, but there are shells that do not like the
> expression 'export VAR=VAL'.

As long as we have no positive report about any such shell that
_otherwise_ would be usable for git, why bother?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
