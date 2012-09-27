From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 4/3] completion: quote completions we find
Date: Thu, 27 Sep 2012 23:40:46 +0200
Message-ID: <20120927214046.GJ10144@goldbirke>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120926215700.GB18628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 23:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THLpM-0003lD-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 23:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747Ab2I0Vkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 17:40:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:64949 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab2I0Vku (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 17:40:50 -0400
Received: from localhost6.localdomain6 (p5B1309F9.dip0.t-ipconnect.de [91.19.9.249])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MbgoP-1Syqvy0hN7-00JXqQ; Thu, 27 Sep 2012 23:40:47 +0200
Content-Disposition: inline
In-Reply-To: <20120926215700.GB18628@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Y+Cmim1WxUCi4/HKxU67Km/Lmkk6uGQb/xB+wjIYYGa
 8cUw2flevVNYSOcVPBGTJR1vlA38wvfzs8jR0/Rn8AJg154oG9
 9fJ9Fb9O5QypWkKb/QNLAv6oXk+yjfpdNtz+Rl7p7LcIbUlE2C
 xqnMcdD47WOVIGrMGuCfdA9qvckR1JL77Jv7ElVvrNhVKfawFU
 RBk+vFjlPNg1hmi5jn4Gu3KHzvg4F8FdbSUwNwNdUNDWLXni3s
 RWnSBnjlkUt75Vy18oDhI9B3emsaCTdILzJjnrGf588V8COMEm
 gmH1xlJDfUFtMlewZAZQuhj6jZ2W7xMOtuoa2hZiZRGvLUJpaP
 7ACXH2t5+zZPZw4gesk3jwRV0+3XC0VyOPGsLPMeR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206523>

On Wed, Sep 26, 2012 at 05:57:00PM -0400, Jeff King wrote:
> +		COMPREPLY[$i]="${COMPREPLY[$i]}$stripped"

This reminded me to a mini-series collecting dust in my git repo,
which converts a few similar var=$var$something constructs to use the
+= append operator instead.

Now, Bash supports this += append operator since v3.1
(bash-3.1-alpha1, to be exact), which is around since July 2005, if I
can trust the mtime at ftp://ftp.cwru.edu/pub/bash/.  MSysgit ships
v3.1 so it already supports this, too.  So, what is the oldest Bash
version we care about for completion?
