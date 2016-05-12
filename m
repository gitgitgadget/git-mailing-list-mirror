From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] test-lib: set BASH_XTRACEFD automatically
Date: Thu, 12 May 2016 17:39:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605121738260.4092@virtualbox>
References: <cover.1462888768.git.johannes.schindelin@gmx.de> <alpine.DEB.2.20.1605101607180.4092@virtualbox> <xmqqshxpofqh.fsf@gitster.mtv.corp.google.com> <20160510205800.GC19958@sigill.intra.peff.net> <xmqqpostmxah.fsf@gitster.mtv.corp.google.com>
 <20160510213218.GA27028@sigill.intra.peff.net> <xmqqd1otmut8.fsf@gitster.mtv.corp.google.com> <20160511134404.GB19356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 17:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0sxR-0000cQ-Ez
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbcELPzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:55:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:52284 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbcELPzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:55:20 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lv9lm-1bjKN73Zh4-010LHF; Thu, 12 May 2016 17:54:59
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160511134404.GB19356@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4zOQDuHhXqNfjO6TTMAAUCfvZIva/jT085m2j9jqpnRG7JrHWBx
 95/vJ3T+AJPiiVTUa07R2X7Z2E/iC3YgP96aACr0+dfUOkSeMTckeVRi1mVV9Cg5MKWd1G8
 yDRsGPG02c8aIGFoMuAuPPicNIbklgel7Vcc3E5p80TLSHd0AiMziO+6tKqT+4IBF5ds/8P
 ZJb3Nh5AFcMfWBH0Rk7Bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2Lkbmo5Swo=:IGL7Ai/oOG0sCoYpsq3TuC
 mMb+wsMoy3TUPok6VI9IC1PMwQDky35QVSFcqBgz1WKFiWJ81BcxjWFNLo8etP4QDAZG8jpyb
 SIuZziX2KXCN0X/8cUkguoM2SrvqUdE7m8oAvZ/gGQAbHZXAFNSyDXfiDeKnOsP5cKlDfbkja
 uH8Evz4kNxeAfnoHNDiZ0Rbd/OvOhz1mNIuelFaQ/VWBmivCxfD5cuE6LZtXXO2XXaBTbsH26
 QqQJke0JRlvsBpaZzhbfVvqtnvCS3z2Drjs14wO/3u73hyzxDkpWtL2x5BMxiIuqV0CMfE+pQ
 573avCU1R7X3mOtYKXFOnGnoHrfDkB6TZw26hsEFpVsaHc3K0toB26N9NBrzD17z5vuAsPU+T
 L599dpV48Nn59XExNrKYdp57vh022C1YHQ9N/3YMuqOSTVbTpvJ/RiPN3cLgvW8ZzO7DK3IT6
 P3UgDcJLwl6AhxB77j4iZg7o35TWScDT68+74XQL8JVFt+QB/KyA8MiIGbGyb8Ck/idIWUy+6
 fYAK14qti0XgeYVvuBlSQrCEcW4LkIk3pQLnYQwpACDnoO6vOVWcjixTLBdqDZzriDO6E+pDG
 xH5wE9qGVdcEEZd2A2YjrMtfzGVRRcxXint4guvsJ8n7RKmVBevrBa2blCW7qxGqWSyXPQLuo
 4Nr8fpPTSGvkowCf///UZC+YDSNi/1NoMorWoYlSlJdOsE57BiYVaBdkVCUORfQyxXC8V38nw
 NBaiWdrQBVFApNf2eRQJK1w5cHQHgj2dhFwwPF+8aHfw3CrqWXuCa4OZC/4IgiqtnBCMm40J 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294409>

Hi Peff,

On Wed, 11 May 2016, Jeff King wrote:

> Subject: test-lib: set BASH_XTRACEFD automatically

I confirm that this simple weird trick obsoletes my painstakingly
developed patch ;-)

To make it easy for everybody involved, I'll just go ahead and send out
the next iteration with your patch.

Thanks,
Dscho
