From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] mingw: skip some tests in t9115 due to file name
 issues
Date: Wed, 23 Mar 2016 20:08:38 +0100
Message-ID: <56F2E9B6.9070904@web.de>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <7b4eca83305ec05af6434ff80269ba563f2d581d.1458668543.git.johannes.schindelin@gmx.de>
 <56F18F5E.9090301@web.de> <xmqqbn66gs4k.fsf@gitster.mtv.corp.google.com>
 <56F1CACA.5040709@web.de> <xmqqtwjydsub.fsf@gitster.mtv.corp.google.com>
 <56F22F85.3010507@web.de> <alpine.DEB.2.20.1603231148510.4690@virtualbox>
 <xmqq37rhdw77.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 20:09:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aio9c-0000g7-DC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 20:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbcCWTJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 15:09:11 -0400
Received: from mout.web.de ([212.227.15.14]:58585 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbcCWTJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 15:09:10 -0400
Received: from macce.local ([87.146.133.242]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0M24vT-1ZtipI12aJ-00u3Rd; Wed, 23 Mar 2016 20:08:47
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <xmqq37rhdw77.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:IA/8moIn5kLcMiJAUN1cG8O7ENuJUWw9Dc079eLND+dxilDbT0c
 8mr62Un+aMhm3eYb2e3L5he6erJqB7KyMSnc/rUJcCSwosG6hr1NeSIQXL4qn0KkH1GbIJ2
 hdDpsen35qhir3qbKmF00MOpLHVVqm9TeKiUqQ9ox3GQk+dnUzziSKcAhZu5yPV9XJAaAOi
 YP3+2lTPPd76D5vEXUEEA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cPfK0ONzsSg=:oNxI3uyJsowxHDcyknkBA5
 SOS8ZpdfPFA6XA/eCmlC8ddzfDf0e/AS6ND6fW5CUR+af0As2jn6Fy8M8wjFojfWlLqWXHpuW
 R1+qLXptXEiLxB3QaVL2d3z2ODPouo6gVhjJvI4nb165xxDriGm5HZx9I3kLZ3ITSBjlyPmvw
 dmNSntmVzAVSuSN2yw+DssCYsAbZYzyTUR2cePSNdWaBNgokYIp+jrb5ZUH0A6zAD9D+cptQ+
 1YVyZ2j7i2HOjx3/gpERjgV01ikm/otXuxuk1Gu4W3AtMbztPqdypzrApsuMp2RhIOMhwphWW
 HYs9u2tXns2Av0Wqw7bMaQp2z4kWs//7DQGaukgsCDoPj+VkLC5tmLeANJMQgJzV7t991GDjD
 RDkExfmaHa7V6fskFokHxm0Ol3LTJNowkBRWrB1Khact0fGmRR2UbwsQuDHQpjz7gXGrNMdp/
 iW5Sjs8OseVNZRdg2NT5IvbJ5s6uGA8C+TQC4t1yMXWYT8Dmj1a0AlsrZxHv7mb/8jjAmr0Cs
 uHl6Ayu7YVSiLvgH/OYrgg6GavSqU64Y4EbM44TY+hn5kRhFdtsbXfPWipKJ0ff0w9PPGoovr
 P2/9dpndHHLDNcDFRkecOF93FwGlaTzRE3pHVzEQY/VPaJFKeb42NPCrgfwnHj2J7L2EzEdQP
 tjGXKhi/wOnjjtNps4vCFZ8u8Ugqi6mJMt1ORf1OEF/QECf0lXslXC0PUyMdnqREFqCa0sxU5
 2FN/SFbrFPllNiMssnlayLpte147XU70yGBpbEIwsASi97gGceAD3qSVPvibTUHBPdH9dL46 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289676>

On 2016-03-23 16.56, Junio C Hamano wrote:

>> Thanks, I used a slightly different version, as I had crafted it before
>> reading this mail already.
> 
> Thanks; Torsten, sorry but could you do another round of check, please?
Sure :-)
