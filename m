From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-web--browse: invoke kfmclient directly
Date: Mon, 19 Sep 2011 23:46:37 +0200
Message-ID: <m2bougtdc2.fsf@igel.home>
References: <20110918032933.GA17977@sigill.intra.peff.net>
	<1316341224-4359-1-git-send-email-judge.packham@gmail.com>
	<20110918183846.GA31176@sigill.intra.peff.net>
	<7vvcso9zzi.fsf@alter.siamese.dyndns.org>
	<20110919182049.GA26115@sigill.intra.peff.net>
	<7v62ko9scw.fsf@alter.siamese.dyndns.org>
	<20110919204448.GA3562@sigill.intra.peff.net>
	<7v1uvc9qhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Chris Packham <judge.packham@gmail.com>,
	git@vger.kernel.org, chriscool@tuxfamily.org, jepler@unpythonic.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 19 23:46:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5lfv-0008Rx-KS
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 23:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab1ISVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 17:46:45 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51276 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756500Ab1ISVqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 17:46:43 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E3379186DEDF;
	Mon, 19 Sep 2011 23:46:38 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 4D5E11C00050;
	Mon, 19 Sep 2011 23:46:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id v3l3SuMobZzf; Mon, 19 Sep 2011 23:46:37 +0200 (CEST)
Received: from igel.home (ppp-93-104-154-188.dynamic.mnet-online.de [93.104.154.188])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 19 Sep 2011 23:46:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7EE51CA296; Mon, 19 Sep 2011 23:46:37 +0200 (CEST)
X-Yow: There's a little picture of ED MCMAHON doing BAD THINGS to JOAN RIVERS
 in a $200,000 MALIBU BEACH HOUSE!!
In-Reply-To: <7v1uvc9qhz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 19 Sep 2011 14:22:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181711>

Junio C Hamano <gitster@pobox.com> writes:

> Thinking about it a bit more, I suspect that we should just let the 'eval'
> grab value out of the $browser_cmd variable, i.e.
>
> 	eval '$browser_cmd "$@"'
>
> no?

That's a Useless Use of Eval and 100% equivalent to this:

$browser_cmd "$@"

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
