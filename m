From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Thu, 7 Apr 2016 17:23:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604071720160.2967@virtualbox>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 17:23:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBmL-00054B-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbcDGPXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:23:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:61055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756508AbcDGPXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:23:18 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LxPAo-1btqDs49KU-0170Z0; Thu, 07 Apr 2016 17:23:11
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1460041965-31526-1-git-send-email-mst@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:iqTyapbXtRJgTASOFQJL5GDnik1jqpG0BDjyvc6yUb8gdL6yLQr
 yAA0hVVxFLVnGgRNqMViEKFV8Oe8Ny4TY44EzV7ptKPMiGg1jfLtswPm1gfnKcE9g5+yq7y
 QU99F30w4mThGSauFfPqS42CL4Q2noWWs7CTS17T9bsIj9g1yU3v7vvEMNQroqk9whC5VWo
 cd4/S8Yw+TCxG1LF3dNnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9v4qreQ9Plc=:o3OR+vb+ZZl2c5c4ht+NWq
 0l8toNwhaUS0SbZObRnpfb8U9D5g1vzAGzV+iCW9IdefZPrsJ0T0x/Oq+AgDIEqDl4boxUh2t
 ToE0oxf3duHLqcRkpnUyalE/f4FoY4OSfTck711uCHRevTkQIalr60BIS5jGhhg7uhQ3iKi1Q
 Jvl1vHw7saZ+x4+VO+COIa0ogDabNUEYZWNrXEpMdLVg/TWOVFCjMz2R3VWa5jWbLpLtSxkKn
 sDNhE4dv12QqXRw/wtmsVTBFflL23/pN6L8z3lkL7j89nS/yfEIqZkc+R/GNjVm+nTmFIURH2
 WSFInAaXNf2eEprdxbsta0Z3BfXOMwu3KnFwdMwdOWA1H+1SZLgj7Y/9+kWrJS4+1R4WVZEjK
 ufIlHmraq02QKEtX1YZ+K18powRfvAWNwhFZl70HIMPsPavpw6q6VWOaEb0DuuvZyoZ+Eeizu
 +5vTRdULmKTlRKhTkvWVOKwNGTGCiJow9lDE7eWaeVwVJE52T43lp/G6tz1VU8fcKvAOKXoi9
 vkYr2h7KXbMM9oYICe1iKHKqQvsdUbhYWZjFuEjJ8GJ+3LST6ZIFcaPXMvJ9+RYrcA7heL2I2
 /6SZNVPawymQzrz9mFYMVbP6ZlZPIitBUwiHt9aSh9taAoX40LzEsBbej7Bcbq6bPAE9Zjrxq
 LhWMhIl8A4SRYh3uZtUgJZyUGIKeU5NQuLOb9d4JBUqQBAdLP5qqXzOMIHEDQ0qb0yox3E1cn
 wRwzhDuV8hdypwAbgdwUNpssLTPpSWObIf1vtTlqC8vTMKOjra2oTseSs8bNo2P3xO53OURX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290921>

Hi,

On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:

> Reverts can typically be treated like squash.  Eliminating both the
> original commit and the revert would be even nicer, but this seems a bit
> harder to implement.

Whoa. This rings a lot of alarm bells, very loudly. It seems you intend to
introduce a *major* change in behavior, and all we get to convince us that
this is a good change is this puny paragraph (which, by the way, does not
do half a good job of explaining to me what you think this patch is
supposed to do, let alone of convincing me that what you want is a good
change).

So. What is it again that you want to achieve? Please use plain English,
e.g. explaining how exactly reverts are typically to be treated like
squashes. And please make it convincing, because so far, I am far from
convinced.

Ciao,
Johannes
