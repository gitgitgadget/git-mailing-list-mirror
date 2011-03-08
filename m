From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Q about the date format in "git commit --date=..." and such
Date: Tue, 08 Mar 2011 19:51:32 +0100
Message-ID: <m2vcztqwcr.fsf@igel.home>
References: <4D73B158.5040409@dirk.my1.cc>
	<20110307165448.GD11934@sigill.intra.peff.net>
	<7vzkp6zclw.fsf@alter.siamese.dyndns.org>
	<20110308011646.GA21278@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px20W-0004Qh-75
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 19:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1CHSvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 13:51:38 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48529 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab1CHSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 13:51:37 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E8721186DEEA;
	Tue,  8 Mar 2011 19:51:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 255AC1C0008E;
	Tue,  8 Mar 2011 19:51:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 5bw9Fv-ExgbY; Tue,  8 Mar 2011 19:51:34 +0100 (CET)
Received: from igel.home (ppp-88-217-123-39.dynamic.mnet-online.de [88.217.123.39])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue,  8 Mar 2011 19:51:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 350E1CA2A0; Tue,  8 Mar 2011 19:51:34 +0100 (CET)
X-Yow: Uh-oh!!  I forgot to submit to COMPULSORY URINALYSIS!
In-Reply-To: <20110308011646.GA21278@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 7 Mar 2011 20:16:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168673>

Jeff King <peff@peff.net> writes:

> Why would you be resetting the date but _not_ taking ownership? Maybe
> a reasonable situation for that exists, but I couldn't think of one.

If you are already the author it's not so obvious that you have to reset
authorship in order to reset the date.  Also, if you are the author, but
under a different email you may not want to change that.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
