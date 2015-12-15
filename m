From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Announcing Git for Windows 2.6.4
Date: Tue, 15 Dec 2015 16:05:08 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512151602260.6483@virtualbox>
References: <alpine.DEB.2.20.1512151116020.6483@virtualbox> <50D8296B-182B-4A53-9329-8F7F96508400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git-for-windows@googlegroups.com, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 16:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8rAK-0001xl-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 16:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbbLOPFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 10:05:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:61108 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965195AbbLOPFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 10:05:12 -0500
Received: from virtualbox ([37.24.143.140]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MfVzj-1Zpxny3ADb-00P7uM; Tue, 15 Dec 2015 16:05:09
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <50D8296B-182B-4A53-9329-8F7F96508400@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:qPYPoKAVe2pZMzfBHuZBjBIi1518J5vZ5Jh4CEta1e3Kq7PloMO
 x9/jp1BcIct/UmQA1fO4mK6ryhslItCcapgtpQZaJlnNp6wbduSlknfBCBM5c7IfbR21JVZ
 44VmnrJZl18D2QNypBFK6ZpeG1c9LXXkNopyoYnop0d63okD4ecDf3O/yc3ztyW+6L6XzF7
 gT8KRadjeCSWb3LqR61Uw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wy2bLms2bj4=:w2byo0NTwGKHoj6qqJNZr/
 Bzxbj5BIRaHVKSx2LxemHBtrxSuvvzuFqMed7y2DCuLjX7IDl9jIk+Q2bco+27uUF98H4Lluc
 FG7sYyMPWBhKmZipcXBHhrwrtm8fv6nQC+nFnbkYHqmLbHOMHYz5q+wy+/q9bbvWA6Wcnbjgy
 l970/FbijXZT9e9Kn8QxjECwUIpbfYowHXd/O6TBz7OtyVXKmX/aj5b4cgaCE06O1d9gjJD7K
 qXWmJLrC4LZOmwM9hpudhD10xiVMxEOHMv8H3N1zG5XjY9nrhUKdDl5a9dFSTGOM3Qnl7giN2
 4Vc1RrerLNVqDH2QxcqgHho9ZT0LzoGqN7q0FmY693mzKvnXeFFAekEgZqfaDnT30D0n24RYF
 CcAtkxzQKD4bSvLFTbsmX9Cs6RQUJXsNs9kNPUzY6r6SKRWL+2l1PZZdYdl2t7DZL9V4fGjlX
 ETWdGRWvXh//yhlNyqU5zjtNmSYfayer0ePmMBuENsY0y3vuAz2fFZ097Oti9XGMJxoViwiJz
 sJ0KvUKK8hyjQWZBpCuhKdch1pCXlqQyzpiBb01VB4v2xrq+kOCSLmNiuek83/HsU8J8zAxOF
 TRbRZUqvkIf8LSId5DogqUSDDyhxjT9eH2Uo+fvozqOiZnDSolRwL82RWp77JlIuUE5taa97M
 C4bXKMRSLn6pFL+G+J1R7y24rP0N+SQ8z+U/nrzp+McUO9K7/KMUxwghD9rgcw2/uA1e4j4mw
 VH+24hXUWFf2O09htz/AUiaYo/Oo/eHq8Zy0ttyPm3soQkAJWK9VAPkRz7JU+ewL5xVvXcNv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282476>

Hi Lars,

[since I really do not like to repeat myself, I will re-Cc: the lists]

On Tue, 15 Dec 2015, Lars Schneider wrote:

> Junio always prefixes his announcements with "[ANNOUNCE] " in the
> subject. Would that be an option for you announcements, too? If not then
> I just need to update my filters :-)

I actually meant to mention that I worked really hard on a script to
automate all the steps of the Git for Windows releases:

	https://github.com/git-for-windows/build-extra/blob/master/please.sh

This includes the generation of the announcement mail, of course. So your
wish was addressed by:

	https://github.com/git-for-windows/build-extra/commit/bf79be45

Please feel free to mention your future wishes in the form of Pull
Requests ;-)

Ciao,
Dscho
