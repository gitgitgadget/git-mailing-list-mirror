From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Wed, 02 Jan 2013 17:43:51 +0100
Message-ID: <m2fw2j3588.fsf@igel.home>
References: <20130101172645.GA5506@thyrsus.com>
	<7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
	<20130102003344.GA9651@thyrsus.com>
	<20130102080247.GA20002@elie.Belkin>
	<20130102105919.GA14391@thyrsus.com>
	<20130102153933.GA30813@elie.Belkin>
	<20130102161848.GA18447@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Wed Jan 02 17:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRQU-0007z7-0A
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab3ABQoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:44:02 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41088 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab3ABQoB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:44:01 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3Ybykz67MWz4KK3J;
	Wed,  2 Jan 2013 17:43:55 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3Ybykz5y0tzbbjK;
	Wed,  2 Jan 2013 17:43:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id cTiIQK9PKNdV; Wed,  2 Jan 2013 17:43:39 +0100 (CET)
X-Auth-Info: ilzrep9RzhZ3WDf6MP8uMjudRmBBEgs32EJ1vLsPqV0=
Received: from igel.home (ppp-88-217-103-193.dynamic.mnet-online.de [88.217.103.193])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed,  2 Jan 2013 17:43:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E95ECCA2A2; Wed,  2 Jan 2013 17:43:51 +0100 (CET)
X-Yow: I'm RELIGIOUS!!  I love a man with a HAIRPIECE!!
 Equip me with MISSILES!!
In-Reply-To: <20130102161848.GA18447@thyrsus.com> (Eric S. Raymond's message
	of "Wed, 2 Jan 2013 11:18:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212524>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Two of the three claims in this paragraph are false.  The manual page
> does not tell you what is true, which is that old cvsps will fuck up
> every branch by putting the root point at the wrong place.

That doesn't look like being a widespread problem, or more people would
have complained.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
