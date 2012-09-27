From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: bash completion with colour hints
Date: Thu, 27 Sep 2012 12:05:51 +0200
Message-ID: <m2fw63g4qo.fsf@igel.home>
References: <50631885.8090604@nieuwland.nl>
	<CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com>
	<506356AA.3050005@nieuwland.nl>
	<7vfw64rm6s.fsf@alter.siamese.dyndns.org>
	<5064140E.50007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Oosthoek <soosthoek@nieuwland.nl>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 12:06:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THAyz-0004Aq-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 12:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab2I0KGC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 06:06:02 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40111 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534Ab2I0KGB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 06:06:01 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XSBVT6Fn2z3hhxr;
	Thu, 27 Sep 2012 12:05:53 +0200 (CEST)
X-Auth-Info: MN+M/ErLvkqMYMCE+BP+wnBHPD53v2tbpAS8OWhpWRM=
Received: from igel.home (ppp-93-104-145-253.dynamic.mnet-online.de [93.104.145.253])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XSBVT2vx8zbgp2;
	Thu, 27 Sep 2012 12:05:53 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 5F800CA2A4; Thu, 27 Sep 2012 12:05:52 +0200 (CEST)
X-Yow: ..  I feel..  JUGULAR..
In-Reply-To: <5064140E.50007@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 27 Sep 2012 10:53:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206473>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> - Bash interpretes '\' only when PS1 is assigned, not when an expansion
> in PS1 produces it.

What you probably mean is that bash does not rescan expansions for
backslash escapes, thus only literal occurences in PS1 are processed
(which is consistent with ordinary expansion).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
