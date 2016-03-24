From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/5] Expanding tabs in "git log" output
Date: Thu, 24 Mar 2016 08:05:09 +0100
Message-ID: <56F391A4.6090603@web.de>
References: <xmqq7fh0s5l7.fsf@gitster.mtv.corp.google.com>
 <1458775426-2215-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 08:05:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizKz-0004Nh-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbcCXHFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:05:40 -0400
Received: from mout.web.de ([212.227.15.4]:62892 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109AbcCXHFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 03:05:40 -0400
Received: from macce.local ([93.222.33.14]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0LbZlL-1a2Gua0g8J-00lE5u; Thu, 24 Mar 2016 08:05:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <1458775426-2215-1-git-send-email-gitster@pobox.com>
X-Provags-ID: V03:K0:zH5tRSKyX46kDLddQWTW/81XFZiWZM2NBwe8jzd6gQb3eNEvfvR
 9jYX7AluvF8bFwgJAMvJ8lbNkhK+eazvTaoQ6Qj93pxFinofCrIOVM1erl4FgZ36Ylsd2yR
 st2odD+9IqYMmnDGPtPF3fiOI/TincxEAqCw1SIDWooBUOdDUQYzZN+8Dri3acWMrwpVuMg
 UnDg1qxjAkHi/2KhWvejQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DYM8vLUxODc=:6zWO+FMFWkHsWAr1z6WFn6
 UrdQDkLXsIBfKSetfzpeyqlFSBzWcBZO9KHpOWtvbEWxQ/lJpbZZk/wB2ycgLM04fiI2ux1FH
 YOJ+qJIxAzixERxYzAn7+VGisXuszwYZ+0yyo2APW9IlhbK6KniKe/JnmTBWazIWp5CUjQXjg
 8TzZBNiZ594mJAZ9WzV4O9WZz19U89E9vFsv1la7Nb0dW8LBdE5YSczfSG8MaZ65bWm9gdyKG
 M+I/X0DNSjpZ68q0LFkkojgK2chBLO0btZkqTsWCD0SG9bcxbvhN6V8qx6KfMI+rcryMSm7BL
 kOt85ZkmjAF3iBwvYKP/xXOy88yuiz5FLdNhmF/K/dh3vxMdyeN28yENOs6lZ9LCSI2STGnJF
 73IEHfdH4n0D7IlMAgwgmfLWegRsI3/+58+rVGCsYrPl8dgNeAgR8syVtG4AXE+4NbX/Dy5BC
 nGbwagLbh2zFH7TCKiLD8kmwEoysQjAkpOWBHffOSRDBTkI0cTRwspnfxV1/+kBNyjrlFKLWQ
 K3dMecBQMtnFPK/yQV72n7KtBcDhBbieJFMiquYunE7DVdIhdpIu2S06ttGZXkpKzA7QS5Cwd
 K8tLNOWTKOUYZ3oPzuoVU3v+4O6YgT2pSjeo9O7uNfSc0sfEu83/v1no4La6nDBMbYIb8GFVv
 okSdfrjeDL80y8stiNADpaUH0tgNSU8sM2fKBgkobkO2j+HdHwQPhfxfMriUrZh+stGgGjvgM
 uOVorN9225WRj/Texp09x2N+RiaqkZIaOvEaEJRpS+5cU8rGBMCe5w8vTxflnClajzCkQtXh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289715>

>  [5/5] adds a new option --no-expand-tabs that controls the bit 4/5
>        introduces, so that "git log [--pretty] --no-expand-tabs"
>        would show the log message indented by 4 spaces, without tab
>        expansion.

Does this introduce an unnecessary regression out of the sudden ?

Would it make sense to have
git log --tab-size=8
(or similar)

and add a config variable like
git config ui.logtabsize
which is 0 by default to get the old handling and 8 for the new one ?
