From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Wed, 13 Jan 2016 08:17:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601130816520.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <7d73267984ab029df022477e341c536e111eafdd.1452585382.git.johannes.schindelin@gmx.de> <5695A132.1040100@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 08:17:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJFgc-0002bX-Su
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 08:17:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbcAMHRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 02:17:38 -0500
Received: from mout.gmx.net ([212.227.17.20]:56942 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723AbcAMHRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 02:17:37 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDW9x-1aOQEF3wQX-00GpJm; Wed, 13 Jan 2016 08:17:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5695A132.1040100@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LA25bi7xm52edHv9EsLET7SQgdxGNYyhfi7QM+ND4ptdcku6MOa
 j6oWHee06h6nsoVUx/GD/mLNf61Q4XEqfAu6VmCnYCz05+jG2mR+ymo5KUCL9WbF9Roijr3
 o7r/l0Zy00Rd17wYwgYvZDRwUBYavnkrwqPb596uf7ZqQXRsqGPv59MZzVxGAi0IGuEXKKG
 AfPBU2LoMF9f0Zn5MMMBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EDzOukPVmJc=:MZTrlgLDQHhzOIqhIV+txI
 EexJyC6wKVVmaUhg4J4bo726+2Ep9vBw3dDtGNTr0aO6/lTUD53nFVa5ddzeJZ2wtehjqdA1N
 FHWh/qzHOGg2QPm2AWVtDweCsqT+ZaH1rqEgK9v+FxEv3nciheztKcvV6YuT/UpUEiQ23yOis
 bhKQETfnas9kz3lq8WkIIT8thjH3p1HLv6Wl32YcCh5IOz0WsPygYGB5SYtFHvg6NG+zP/hxh
 e4q397PSy1+vfVJBFF1z5R1KCJeHX5DCu0fwlHplUBirP+o+uBRvhmgMLzBEeJtEXYBqAkMkc
 whWsOEfLeipfJFZqM4jkScjDf7ydMQSNxUmdkeM+yYMBFtUdHu/AJG/hWf+b8QG4uZk7d56rS
 2Xbv9jc4t7lDVUGCmbpa28nRIARbNUmHIqARGB+Ck2lrHJagyKOMIVDi4DGhgWx3tPKTACBC3
 oPQCjwrwgYSHOZXRq6FHtcrMkqZ/663DsjGHj0mkBD2OueMEF2+fiu9GibvpDWVCP4Xydb+r2
 VYYAGgB0EaQkhlNvnDJHF9sX0FLSaOmgxAtcIww5fQ0J5zvAjPalrFz+w4QFyLaOHahD0YyCU
 PvFmcS0zLqmxMUdxgoqU45Q2wnndYkJxI1VMUz5F4qYxgMY5+HMhXzOk0dNakUwqu5aU5eBZ1
 WMeL5ibGKe9KjOQhxy6e/G/kkExBvE1y4s0SazpkV7L8i5hS2yfhmhe//9Vypsy0ZysZV0Zc8
 +gAPHtrozv0n3J29IC0q4bO9qxHXFiBwt6HNOMEYLSld5FIWMoxpyzidkm+SOFQ0SckhAKj9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283892>

Hi Ramsay,

On Wed, 13 Jan 2016, Ramsay Jones wrote:

> Did you not have more tests to add?

No, all my testing was manual so far, and well covered by your test cases.

Thanks,
Dscho
