From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only
 check
Date: Tue, 15 Sep 2015 19:55:19 +0200
Organization: gmx
Message-ID: <f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152428.GD29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 19:55:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbuSA-0007eY-Qh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 19:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbbIORze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 13:55:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:52366 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbbIORzd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 13:55:33 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LsCdj-1Yc8MZ3vPL-013swq; Tue, 15 Sep 2015 19:55:20
 +0200
In-Reply-To: <20150915152428.GD29753@sigill.intra.peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:RuvTvZeDVaMfTG/fXYU0JfjMH+T2+yPwGZ+tieb7ICVm30OdGmJ
 eIsB9DWoZRdWFJRPqNGd1VRvQIX0S6qLjEr2Esf7DyruLjlVzwZsWYeS/CnkH/GvaTl3WAW
 +EdeHksW19f18m6RpimIZFblw2ODn94LfFBYeFDhD6A6egHqd9ZRoYjDHaNGPVrVA4KBaRt
 6grqHxb8gqj/u+xEfuhRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0koVOJHAwYQ=:NkHc4FGZKXOxJSvmUwACg9
 4h5OeyLi50lyyPZnGPzo44z4zBYjz6MRNGKMzJEzYfFlMVyyL0B2XRJB8kQ/XIX+YxDCwemZL
 V5YwjZJKW4U19ZHUx7y2IlfvDFfa8gurmJvi7wBBGCs9TCN6JqzcSmh4RQOl1DgmjXCNp7EyD
 QmTplmqMXnGSd5F4w2coTkEMh3Gl4uRkGIMQ4WfNBGG3X/YrziGrqiZIE0U4i23M7KpBkig5a
 TuKHhipUxBPCjY5ddsaF6SCXGLmIliQ2/+8lOe5AeYFmoc7e33CpzchZXJw7FBFhBrfNb2n6N
 3wZfC4uUv22ebTHb8nz6SaVZuXK9LjGUTY91kGvhPq+ZUc9zGy/t1ZiAgHGO3Tt84aJVxMp86
 ehW/fUaGGSMqzj3kHiibaFbMDTM0MLApjrx7FYjs+lDSxXW+oS4O2qgpeh55EkEvY422BHj6C
 KsP+bwBofUixt/s8brr0p0w6tsvyRVjBRNUymQ3YQXiiZ5msGN2ijpY3bwrfBpn8AX5dwpFrc
 2C8DgY8yB0fcwfTHvi4giRuFuqctHp8RSaEKxwPgG8TSJH06QgWMHcejxsmYvFih1JLNzslFe
 OFRUgZJafyhIiHCjI9XwVCbWg/Jj7iUkzAt+SHQ2pybcPpkoJxyabinWS5CRFbydfFLxFI8dQ
 1wSdHObI/Ghc2HVoQtqikAS37Wx0HRYfTO3VLygisH8RKBlu/sk8oA7DlYW0dH+Q5QyhHvjik
 sADt1DdS01mk9vhFgKAu50cmGm77K8gW+PwyxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277975>

Hi Peff,

On 2015-09-15 17:24, Jeff King wrote:
> Commit 02976bf (fsck: introduce `git fsck --connectivity-only`,
> 2015-06-22) recently gave fsck an option to perform only a
> subset of the checks, by skipping the fsck_object_dir()
> call. However, it does so only for the local object
> directory, and we still do expensive checks on any alternate
> repos. We should skip them in this case, too.
> 
> Signed-off-by: Jeff King <peff@peff.net>

ACK!

Sorry for missing this spot.
Dscho
