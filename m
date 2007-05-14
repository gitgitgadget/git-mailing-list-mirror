From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: git.or.cz IPv6
Date: Mon, 14 May 2007 07:42:33 +0200
Message-ID: <20070514054232.GD17207@cip.informatik.uni-erlangen.de>
References: <20070513094054.GB18546@cip.informatik.uni-erlangen.de> <20070514005410.GG4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 14 07:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnTKT-0003qR-2r
	for gcvg-git@gmane.org; Mon, 14 May 2007 07:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757722AbXENFmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 01:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757729AbXENFmf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 01:42:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38995 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757722AbXENFme (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 01:42:34 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 100B03F376; Mon, 14 May 2007 07:42:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070514005410.GG4489@pasky.or.cz>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47220>

Hello,

> git.or.cz's IPv6 connectivity should be fine, maybe there is a routing
> problem somewhere along the way :-( - what IPv6 ISP are you using?

_From_ University:

(faui01) [~] traceroute6 git.or.cz
traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:638:a00:1e:209:3dff:fe10:85e5, 30 hops max, 16 byte packets
 1  m5.ipv6.uni-erlangen.de (2001:638:a00:1e::1)  0.434 ms  0.358 ms  0.35 ms
 2  nr-erl1.6win.dfn.de (2001:638:f:a00::a00:1)  0.332 ms  0.267 ms  0.258 ms
 3  2001:638:c:c056::2 (2001:638:c:c056::2)  0.568 ms  0.535 ms  0.389 ms
 4  2001:638:c:c049::2 (2001:638:c:c049::2)  5.911 ms  3.454 ms  3.057 ms
 5  zr-fra1-te0-7-0-4.x-win.dfn.de (2001:638:c:c002::2)  10.291 ms  7.454 ms  7.477 ms
 6  xr-fra1-te7-1.x-win.dfn.de (2001:638:c:c050::1)  5.287 ms  5.014 ms  5.04 ms
 7  nr-frankfurt1-fe0-0.x-win.dfn.de (2001:638:c:c05a::1)  4.199 ms  4.157 ms  4.167 ms
 8  dfn.rt1.fra.de.geant2.net (2001:798:14:10dd::1)  4.909 ms  4.766 ms  4.661 ms
 9  so-6-0-0.rt1.pra.cz.geant2.net (2001:798:cc:1301:1401::1)  12.713 ms  12.755 ms  12.661 ms
10  so-7-2-0.rt1.vie.at.geant2.net (2001:798:cc:1001:1301::2)  19.173 ms  19.604 ms  19.134 ms
11  2001:1900:5:2::5 (2001:1900:5:2::5)  42.501 ms  42.886 ms  42.216 ms
12  2001:1900:5:1::1 (2001:1900:5:1::1)  43.162 ms  43.222 ms  42.977 ms
13  2001:7f8:4::cb9:1 (2001:7f8:4::cb9:1)  31.844 ms  32.347 ms  31.708 ms
14  so-1-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:32)  32.051 ms  32.183 ms  32.859 ms
15  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  37.727 ms  37.319 ms  37.488 ms
16  * * *
17  * * *
18  * * *

_From_ Home:

(thinkpad) [~] traceroute6 git.or.cz
traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:a60:f027:dead:213:2ff:fe7b:d860, 30 hops max, 16 byte packets
 1  gateway.glanzmann.de (2001:a60:f027:dead::)  1.06 ms  1.124 ms  0.885 ms
 2  gw-55.muc-02.de.sixxs.net (2001:a60:f000:36::1)  9.65 ms  9.5 ms  9.417 ms
 3  rt4.muc1.m-online.net (2001:a60:0:200::1)  9.961 ms  10.232 ms  11.275 ms
 4  ge-0-1-0-302-gar1.muc.cw.net (2001:5001:100:f::1)  10.362 ms  10.068 ms  10.397 ms
 5  ge-0-1-0-302-gar1.muc.cw.net (2001:5001:100:f::1)  10.503 ms  10.331 ms  10.32 ms
 6  so-4-3-0-dcr2.fra.cw.net (2001:5000:0:cd::1)  17.473 ms  17.683 ms  17.65 ms
 7  so-4-0-0-dcr1.amd.cw.net (2001:5000:0:e::2)  31.629 ms  31.751 ms  31.321 ms
 8  gin-ad1-6bb1.teleglobe.net (2001:7f8:1::a500:6453:1)  33.194 ms  31.58 ms  31.719 ms
 9  bbcr05-fra4-5a6.six-de.net (2001:4b88:0:4:16:2::)  37.907 ms  38.499 ms  37.962 ms
10  bbcr02-fra4-decixii-a.six-de.net (2001:4b88:0:4:2:2:11:0)  37.106 ms  38.543 ms  37.857 ms
11  de-cix1v6.cr1-telhe-lon-uk.as15444.net (2001:7f8::3c54:0:1)  44.361 ms  45.622 ms *
12  ge3-0.gsr2-telhe-lon-uk.ipv6.as15444.net (2001:1a90:0:2::2)  44.894 ms  81.328 ms *
13  uk6x.ipv6.btexact.com (2001:7f8:2:1::1)  250.741 ms  51.785 ms  226.606 ms
14  2001:1900:5:2::61 (2001:1900:5:2::61)  257.189 ms  201.111 ms  214.01 ms
15  2001:7f8:4:1::cb9:1 (2001:7f8:4:1::cb9:1)  55.379 ms  55.015 ms  55.24 ms
16  so-0-1-0.lon11.ip6.tiscali.net (2001:668:0:2::640)  55.016 ms  54.419 ms  53.717 ms
17  so-7-0-0.lon11.ip6.tiscali.net (2001:668:0:2::1:332)  54.29 ms  54.24 ms  53.907 ms
18  so-1-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:32)  54.4 ms  54.082 ms  53.682 ms
19  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  58.853 ms  60.317 ms  59.325 ms
20  * *

_From_ a friend:

(stargate) [~] traceroute6 git.or.cz
traceroute to rover.or.cz (2a01:b0:0:2::) from 2001:4b88:103a::1, 30 hops max, 16 byte packets
 1  adslgw01-fra4-5a.six-de.net (2001:4b88:0:4:0:22:11:0)  12.366 ms  12.103 ms  11.769 ms
 2  bbcr05-fra4-5a6.six-de.net (2001:4b88:0:4:5:5:11:0)  12.054 ms  11.988 ms  11.764 ms
 3  bbcr02-fra4-decixii-a.six-de.net (2001:4b88:0:4:2:2:11:0)  33.735 ms  21.547 ms  18.459 ms
 4  de-cix1v6.cr1-telhe-lon-uk.as15444.net (2001:7f8::3c54:0:1)  27.813 ms *  29.321 ms
 5  ge3-0.gsr2-telhe-lon-uk.ipv6.as15444.net (2001:1a90:0:2::2)  29.273 ms  30.316 ms *
 6  uk6x.ipv6.btexact.com (2001:7f8:2:1::1)  31.474 ms  29.765 ms  29.037 ms
 7  2001:1900:5:2::61 (2001:1900:5:2::61)  57.898 ms  87.899 ms  79.933 ms
 8  2001:7f8:4:1::cb9:1 (2001:7f8:4:1::cb9:1)  52.775 ms  32.296 ms  31.522 ms
 9  so-1-1-0.lon12.ip6.tiscali.net (2001:668:0:2::1:311)  31.504 ms  93.717 ms  32.477 ms
10  so-0-1-0.lon11.ip6.tiscali.net (2001:668:0:2::1:322)  32.502 ms  32.706 ms  32.73 ms
11  so-1-0-0.dus11.ip6.tiscali.net (2001:668:0:2::1:32)  36.458 ms  37.065 ms  35.934 ms
12  so-0-0-0.ham10.ip6.tiscali.net (2001:668:0:2::101)  41.131 ms  42.767 ms  42.101 ms

> I'd prefer to have AAAA records for IPv6-capable sites but if it
> causes problems for more people, I will remove it - new technology
> stuff is nice but the priority #1 is for the site to be reachable.

We have native ipv6 since 5 years at university. And actually our IPv6
connections still stands when our IPv4 is down. But the git.or.cz
connection is down for some time now. At least from my point of views.

        Thomas
