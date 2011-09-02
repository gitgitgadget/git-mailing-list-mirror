From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] test-lib: save test counts across invocations
Date: Fri, 2 Sep 2011 14:39:39 +0200
Message-ID: <201109021439.39916.trast@student.ethz.ch>
References: <8fe5381a6b69079b8c20452fd4d99a128764dd52.1314882443.git.trast@student.ethz.ch> <20110901163846.GD15018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 14:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzT2B-0004qe-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 14:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab1IBMjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 08:39:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:11521 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286Ab1IBMjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 08:39:42 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 2 Sep
 2011 14:39:40 +0200
Received: from thomas.inf.ethz.ch (129.132.153.219) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 2 Sep
 2011 14:39:39 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110901163846.GD15018@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180609>

Jeff King wrote:
> Anyway, this whole thing is a cute idea, and I do love eye candy, but I
> wonder if it's worth the complexity. All this is telling us is how far
> into each of the scripts it is. But we have literally hundreds of test
> scripts, all with varying numbers of tests of varying speeds, and you're
> probably running 16 or more at one time. So it doesn't tell you what you
> really want to know, which is: how soon will the test suite probably be
> done running.

I guess you're right.  Let's drop this, then.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
