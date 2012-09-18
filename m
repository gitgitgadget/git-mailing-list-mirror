From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unable to clone GIT project
Date: Tue, 18 Sep 2012 11:06:18 +0200
Message-ID: <m2392fk8dx.fsf@igel.home>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
	<20120916104651.GF32381@localhost.localdomain>
	<CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
	<20120917202124.GC24888@sigill.intra.peff.net>
	<0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFE5FB@NOIX10HMNOI01.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <peff@peff.net>, <kusmabite@gmail.com>,
	<flatworm@users.sourceforge.net>, <git@vger.kernel.org>
To: <Ankush_Aggarwal@DELL.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDtlP-00069Y-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 11:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625Ab2IRJGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 05:06:30 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:44350 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932539Ab2IRJG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 05:06:27 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XLdbw2D2pz4KKB6;
	Tue, 18 Sep 2012 11:06:20 +0200 (CEST)
X-Auth-Info: bk5Zcr/2vbRVGhwN7kKONQZKvPWA1aMQS9Lmm9E2FXc=
Received: from igel.home (ppp-93-104-159-39.dynamic.mnet-online.de [93.104.159.39])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XLdbw1mwPzbbcr;
	Tue, 18 Sep 2012 11:06:20 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 820EECA2A2; Tue, 18 Sep 2012 11:06:19 +0200 (CEST)
X-Yow: CONGRATULATIONS!  Now should I make thinly veiled comments about
 DIGNITY, self-esteem and finding TRUE FUN in your RIGHT VENTRICLE??
In-Reply-To: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFE5FB@NOIX10HMNOI01.AMER.DELL.COM>
	(Ankush Aggarwal's message of "Tue, 18 Sep 2012 08:53:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205817>

<Ankush_Aggarwal@DELL.com> writes:

> On Linux machine
> 	Installed libiconv-1.14 unded /usr/local/lib path.

Why do you need that library?  iconv is part of glibc.  Moreover, git
wouldn't link against libiconv anyway unless you explicitly ask for it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
