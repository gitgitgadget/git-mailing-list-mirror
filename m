From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Tue, 19 Apr 2011 00:11:49 +0200
Message-ID: <m2k4erb462.fsf@igel.home>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
	<20110418211102.GA13566@sigill.intra.peff.net>
	<20110418211849.GB13566@sigill.intra.peff.net>
	<7vvcyb6xww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBwfm-0007Fd-MV
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 00:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab1DRWLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 18:11:54 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42925 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab1DRWLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 18:11:53 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 738B7188B592;
	Tue, 19 Apr 2011 00:11:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A3A1C1C00087;
	Tue, 19 Apr 2011 00:11:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id SGw2FUSpiomh; Tue, 19 Apr 2011 00:11:50 +0200 (CEST)
Received: from igel.home (ppp-88-217-96-88.dynamic.mnet-online.de [88.217.96.88])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 19 Apr 2011 00:11:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 96D86CA2A0; Tue, 19 Apr 2011 00:11:49 +0200 (CEST)
X-Yow: I feel real SOPHISTICATED being in FRANCE!
In-Reply-To: <7vvcyb6xww.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 18 Apr 2011 14:40:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171765>

Junio C Hamano <gitster@pobox.com> writes:

> With ebec842 (run-command: prettify -D_FORTIFY_SOURCE workaround,
> 2011-03-16) reverted, I still don't get complaints from -D_FORTIFY_SOURCE
> for run-command.c (but I do get "ignoring return value of 'fwrite' from
> many places).  Perhaps the kinds of checks done by versions of gcc you,
> Jonathan and I use are different.

It's not about fortify warnings, but "set but not used" warnings.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
