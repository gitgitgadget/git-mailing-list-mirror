From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] git-am: add am.threeWay config variable
Date: Fri, 07 Aug 2015 11:18:27 +0200
Organization: gmx
Message-ID: <ee65e46e4a342e4646ae78baf12fbe3b@www.dscho.org>
References: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 11:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNdnY-0004Ml-M4
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 11:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbbHGJSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 05:18:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:63738 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbbHGJSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 05:18:33 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbPza-1Z06LH0rik-00l1GZ; Fri, 07 Aug 2015 11:18:29
 +0200
In-Reply-To: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:gT2a+HrGYQjvjxn/u6F9QUsM3PnteEihH/KjEEig9sYNUVHr3bm
 KlDP81Y7AWTyzGfbANv7sBs87t2uueVDm/2/AFtPsGwHdxG1aGd2NrxRkd+q+n1c5NyHK7c
 IgBEL/1mP+NUk/Rj0u7UxruiicYEuUdVxe+8IEoIbBNXbeJZhMbLd0mUOiNfMFF9SS8rcQY
 mMLWcQYD8WFUDQuqxWwnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K36Eyobrm4M=:4TCXFHH6csQLjIqecx2JaT
 jECQE0LzTWiJyRZDETeC+hCNGSaMxOAzbu6+aUnjYDSCB7F/uj3FHFUGGHu57vzQSEULBK6GJ
 tHWaZqrqvVRLKoaFaBmyph1nRGkitutROcu/6aZsz//hmyV7Wzjvmpn2VOy0Rwu41pzyPVon/
 ZwQPALy7ZLEzJ9jTLDDKDRrcY/rUhn7OOeTua7nrZDekg8QvozHF+9gIsxnHB6nVN0OfF4RzU
 AwQEXDMokGym4+vDQxE7uLeAzV37niBrfBwCqgF1d/3eKVpMI+k8ASxCKMhkx019zp09b2Cb0
 SKbXq3hWU1bgPLTdkIwp2ussebfyFgM/gMqZpDlaonLfG27ju3XJPdsTKbbu4mCAB8kQL/ih6
 bN+CvpQy4TVZnCKTwzN/LsTyWD8KkPSEyGFkXAji8fNHwIojYaZxSAqscMBQwYHvACYDo4YOY
 sSlPVXVUrdJzWtKOeuS59etdIxYKBEkeJgYrbIz7Jb014Yzs+bDKCTntH3QXlg3up47ZIQThc
 xf+zFH2b5OQrT8wE18/XEk6HiWMapp/qH1mJWp0GtqjfJhRTEUvBvT5B1NK4RkIOldji7pPV3
 ZDRtpOBy168RyH/wuGJwb4TfzdTA+BqV1ne1MNUQcyHSa29i8mWhIGYnAuVIEam2IWe1L8qxC
 8363Qlro/ugjTJMP8eqP7oL8nb7TfUIyAvmJr8NRHRJWPcUjC0fqv3KCZpWbmv+9woxI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275463>

Hi,

On 2015-08-04 16:19, Paul Tan wrote:
> From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> 
> Add the am.threeWay configuration variable to use the -3 or --3way
> option of git am by default. When am.threeway is set and not desired
> for a specific git am command, the --no-3way option can be used to
> override it.
> 
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> I tweaked Remi's patch so it is implemented on top of builtin/am.c. Hopefully
> there will be no regressions this time ;)

The diff looks obviously correct to me (and yes, I also looked at the context... :-)).

Ciao,
Dscho
