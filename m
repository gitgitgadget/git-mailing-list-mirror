From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 07:35:34 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601150734460.2964@virtualbox>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de> <CAPig+cRa9mk0U4iPim5GRWzFN-vHEA=rx8bb40oQyCJVZL7t3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Blume <blume.mike@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:35:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJxzD-0002sU-LO
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 07:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbcAOGfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 01:35:47 -0500
Received: from mout.gmx.net ([212.227.15.18]:64021 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750772AbcAOGfq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 01:35:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LiDrv-1Zps0w3OpH-00nPXV; Fri, 15 Jan 2016 07:35:37
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cRa9mk0U4iPim5GRWzFN-vHEA=rx8bb40oQyCJVZL7t3A@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:STRYRZ/aUV7QbzHZPVeBfEdiNtHCMZtJbjXlUZ878T3j/1iIpZ1
 9NNAA/qniAHvH+R915wyHtKYhAdNAfAEXl8uDY2dSAeQltbqT/rx1+bcGY6xNweTmMXS912
 2fCJZ/C3ofTS728WGb8treUsiJCKoFCQTKTnKrGJ+nysf5Z8MvCI+J3ppS0p8aoTMXpRORy
 V8+72/qnUlkeRO8NcvweQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ssrVhEABhMM=:uRuLkNchA0GqMMbRDz+s09
 aHaX+3cPaAhyokKDHrL4LEuIGrTYJ0LmGw8lD7qU6WvpZbkVF+rOAn4ZFotIjYg/3hYMPquw8
 5125bYM/cRDkNG2eLfnbJS27mohLIIEQMsTqBPhitsoPQceqDQu0tKGkNHxiByBU+Wa4HFXYo
 xSnwDIOnYy5RyyVF9rEAUM8sVhzj1PLlPIO0eeEtr73ZfjPKaxbb3mdHe0tbKvzj4Vld1ppmy
 zz2E0sDR+37K51DlqNHJ6RrnaxntYEDUJj8gV7DYeuQhgsQh0CvGFBlyhql5i7PjaXzd+Z80E
 Zg3tFFAWmsOhN9LMC+LIIp+7kkOk8/rhB0rlljKiUxKbJSnSvfpMlJiu8j2NeylQru+ZWUW07
 JLGKbCX8muDrys6q9J2iuBy+3N6zGzl5CCAKFz5uH59wa0WS8lOtstQgufgi9pu6evgksiPJz
 7iNd7PAacCIpIHoFMhODm7xCt7cXgy6FJ8tFnXC9clGg4hKCJRqM59zN1AxwIh5OO0FD7Gus5
 +rYkAw6ixsho9wONSNHJ5gfDMgYrac1Nvx8UZI75kUdDVqoVhUq8VJhCluLfGphu14M980dJ+
 WxM8TnQ8e66WTRdnM2OIdgA77sohXkJ+P+6rmKkbcaQC469/+zX8cluuDHrJZgDlUpxyWOFXq
 ahJ649LtX/t2rD14XMcqs8oJBp+y5dJozQC1DTp1bGZpkZP2U11kuzkuv/ekN/lSkIosueZvE
 N/cdYcL4m9kaXI66M/Z48VLDzmtSuoca9chb8y3F4OPAPCqgL/Oe/v6vr0HYZcmvkgU8X6wf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284136>

Hi Eric,

On Thu, 14 Jan 2016, Eric Sunshine wrote:

> On Thu, Jan 14, 2016 at 1:48 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>
> > [...]
> >
> > This is not limited to the "//" vs "/" case, of course, other inputs are
> > also allowed to produce multiple outpus by the POSIX specs.
> 
> s/outpus/outputs/

Whoops.

Junio, would you terribly mind adjusting the commit message on your end?

Ciao,
Dscho
