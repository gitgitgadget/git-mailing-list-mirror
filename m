From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: properly bound "invalid tag name" error message
Date: Mon, 8 Dec 2014 12:01:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412081200460.13845@s15462909.onlinehome-server.info>
References: <20141208054812.GA30154@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 12:01:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxw4A-0001B3-4m
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 12:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbaLHLBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 06:01:18 -0500
Received: from mout.gmx.net ([212.227.15.15]:52252 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754764AbaLHLBR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 06:01:17 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lhwgc-1XcP0a13i6-00nA6K;
 Mon, 08 Dec 2014 12:01:14 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20141208054812.GA30154@peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:g5daKF2ZcVxzKYXL3/bHE9AaKrvtVckIj0k1TH1oHjcuqzm9IOA
 76vkE+hd8pWH0dVQ8EZzTuNj0GGhAWbLND05ft5zC0j6F/CZnFBaGBVQvRH8PuwArz8GS59
 QGk0jKBOiDvFWuY1EmOTB0gpu22Pecur4Z6GPYI3f3kj5Uznu0xyPTwPHMxFVtxqC/ZZBW2
 ubV15CMcn2/xXnj3mesTQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261007>

Hi Peff,

On Mon, 8 Dec 2014, Jeff King wrote:

> When we detect an invalid tag-name header in a tag object,
> like, "tag foo bar\n", we feed the pointer starting at "foo
> bar" to a printf "%s" formatter. This shows the name, as we
> want, but then it keeps printing the rest of the tag buffer,
> rather than stopping at the end of the line.
> 
> Our tests did not notice because they look only for the
> matching line, but the bug is that we print much more than
> we wanted to. So we also adjust the test to be more exact.

Good catch, thank you!

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
