From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 08 Apr 2012 11:07:51 +0200
Message-ID: <m27gxqk2vs.fsf@igel.home>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
	<7vpqbiyhmu.fsf@alter.siamese.dyndns.org>
	<20120408044825.GA4296@sigill.intra.peff.net>
	<7v62daye43.fsf@alter.siamese.dyndns.org>
	<20120408054251.GA8100@sigill.intra.peff.net>
	<20120408081245.GA18407@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 11:08:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGo6w-0007tB-UJ
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 11:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab2DHJIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 05:08:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37627 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2DHJH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 05:07:59 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VQTLx32dTz4Kn8b;
	Sun,  8 Apr 2012 11:07:53 +0200 (CEST)
Received: from igel.home (ppp-88-217-106-51.dynamic.mnet-online.de [88.217.106.51])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VQTLx2KlJz4KK3N;
	Sun,  8 Apr 2012 11:07:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id A2BF9CA2AA; Sun,  8 Apr 2012 11:07:52 +0200 (CEST)
X-Yow: Not SENSUOUS...  only ``FROLICSOME''...
 and in need of DENTAL WORK...  in PAIN!!!
In-Reply-To: <20120408081245.GA18407@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 8 Apr 2012 04:12:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194986>

Jeff King <peff@peff.net> writes:

>    Bash will continue after a failed exec.

Only when interactive.  A non-interactive shell respects the execfail
shopt (off by default).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
