From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 9 Jun 2016 23:40:08 +0100
Message-ID: <5759F048.7040302@ramsayjones.plus.com>
References: <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
 <20160608194216.GA3731@sigill.intra.peff.net> <vpqwplypnpr.fsf@anie.imag.fr>
 <57597E93.9040808@ramsayjones.plus.com>
 <20160609171246.GA9016@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 00:40:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB8cg-0005B4-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 00:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbcFIWkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 18:40:16 -0400
Received: from avasout01.plus.net ([84.93.230.227]:41866 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcFIWkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 18:40:14 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 4mg91t0065VX2mk01mgAYJ; Thu, 09 Jun 2016 23:40:12 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=rDzLybChu7nBL-VEH24A:9 a=QEXdDO2ut3YA:10 a=gzujYqFzc2UA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160609171246.GA9016@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296936>



On 09/06/16 18:12, Jeff King wrote:
> On Thu, Jun 09, 2016 at 03:34:59PM +0100, Ramsay Jones wrote:
> 
>> Just FYI, this patch removes the last use of write_or_whine() - should it
>> be removed?
> 
> That sounds reasonable. Want to do a patch on top?

OK, will do.

ATB,
Ramsay Jones
