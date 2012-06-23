From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 14:29:09 +0200
Message-ID: <m2boka5i0a.fsf@igel.home>
References: <m2vcil4n0w.fsf@igel.home>
	<7v4nq5twwg.fsf@alter.siamese.dyndns.org>
	<7v62ainbub.fsf@alter.siamese.dyndns.org>
	<m2y5neqwwj.fsf@linux-m68k.org>
	<7vbokala5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 14:29:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiPTS-0003vo-1V
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 14:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516Ab2FWM3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 08:29:18 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36195 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2FWM3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 08:29:18 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WKGD102T3z3hhdD;
	Sat, 23 Jun 2012 14:29:02 +0200 (CEST)
Received: from igel.home (ppp-88-217-109-173.dynamic.mnet-online.de [88.217.109.173])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WKGD71cTWz4KK9T;
	Sat, 23 Jun 2012 14:29:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 9872ECA2A5; Sat, 23 Jun 2012 14:29:10 +0200 (CEST)
X-Yow: LIFE is a never-ending INFORMERCIAL!
In-Reply-To: <7vbokala5e.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 23 Jun 2012 01:12:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200498>

I've now found out that this is a bug in the docbook-xsl stylesheets,
updating to 1.77.1 fixed the formatting.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
