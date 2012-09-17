From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 19:55:24 +0200
Message-ID: <5057640C.80402@kdbg.org>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com> <20120917172022.GA1179@sigill.intra.peff.net> <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com> <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com> <20120917174439.GD1179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:55:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfXn-0000xZ-N1
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756930Ab2IQRz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:55:29 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:9569 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756043Ab2IQRz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:55:28 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id ABC2B2C4007;
	Mon, 17 Sep 2012 19:55:26 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B12EE19F3D7;
	Mon, 17 Sep 2012 19:55:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <20120917174439.GD1179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205724>

Am 17.09.2012 19:44, schrieb Jeff King:
> Oh, bleh. Stupid automatic --tee for valgrind. Try this:
> 
>   SHELL="/usr/bin/zsh -x" ./t0000-basic.sh --valgrind
> 
> I am also doing my tests with "dash" as my shell. You might try setting
> your SHELL to /bin/sh to see if it makes a difference.

Shouldn't -v be used as well? Or is --valgrind different?

-- Hannes
