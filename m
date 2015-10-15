From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Thu, 15 Oct 2015 17:06:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1510151702420.31610@s15462909.onlinehome-server.info>
References: <561E6FBB.7060302@gmx.de> <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com> <561EE700.3020002@gmx.de> <alpine.DEB.1.00.1510151152470.31610@s15462909.onlinehome-server.info> <561FAC12.5020007@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sven Helmberger <sven.helmberger@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmk6h-0003KK-7a
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 17:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320AbbJOPGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 11:06:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:64452 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbbJOPGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 11:06:08 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0Lx4dh-1afJnY2105-016inv;
 Thu, 15 Oct 2015 17:06:05 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <561FAC12.5020007@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:GZwqG+3Lh26mPkJVg7YfXFANjTLbjjWMNYh9ar2cMbjTRFuROep
 bKDHgJ3KgdIuAXl0QtKogxgTzpw3isNyRiW+yLslzTsD2noomOLJFky0lL5ARsIWRdDajwX
 2Lv033QFwoV24DQ02BMFmDze0HYpFJ78ESDJ18QclFnkU2O3Ee83e2o64W6lHMWomaRNFc6
 S0EbSBLaUJWSyJ6AiEyKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:scvom6lkm+E=:j8I5tZhSWAsE8PVj/3nUmU
 UOT4QNlQEQg9LTtai2UGrc3qYUrh3ftzUVDgJdX7g5UHwrrJ1xpu3gI65udNVHKsK9A1X4Apf
 AFyFFp37N8HeXZ64xbNzVjgNxEgmexvT9xMh7ysRPmpmPM85xNRvWL+U61eL5f0Hw7B8piMWW
 l07LzYunSJvqrUY9Hn5Sw2ynCK6uYbXoNn1njldJseYquaU/M4sZMbQc8yllHnQkEHjqjFEXD
 1/uBBVF5ElgERo9ysuWwPy1k4tN7O9A5B9PO0EwaZNTJ/WjXgczawyKwvoTxHIzoigxMyPniB
 PJBwR3Z7Syp4VReZTXaA8UGFy2peaz4/hUOUhjVXwIFdKGFEwu3F7pFYmFedz5Kcgyvil12V3
 HPBQIRva7iyhuQLtfSFKBh6YqavEjE7XS5EaV+hWPFvmP5K3QNj6PN48XEON6aCROhS3VmGbE
 H2/l1S+jRFB4n/e1PImYzP5m4Udvq+sNrS4AdkTs3FHCMdGBkIke4QahTtIuJxnXamDEJ45KB
 2vB9Gz2Qof3Mv8Ah2rHVEZ+Fi2/eJ9cGlDTev7Ej01Rxq5BNbe/U+TgePKvCFYVBxOAcZv+xL
 ZE0tTIPMluQqswI3ZFVOvrhTDPblA4outO49BW3Fm7CTD6zb8jd4/n1c18uoCmMKvdUKC1cfw
 NUmp3tpQ4SW5uACbkA8aXk9XBarbrSXKKJnMkWml1lMc+/f2J/qO+20w9gwhsOgY++yS33Ylw
 nSCnO8//oOLHDQNM/pe6GPCQVLicv+9z9V/q2nafS1AR2A2moN1TZ5LDMSmin94erbUa9l2B 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279669>

Hi Sven,

On Thu, 15 Oct 2015, Sven Helmberger wrote:

> Am 15.10.2015 um 12:11 schrieb Johannes Schindelin:
> > 
> > This is all technically sound. From a usability perspective I would wish
> > more for a way to exclude or filter the lines by a pattern. 
> 
> Why not do both?

Because sometimes more is less. If users are overwhelmed with many, many
options, they are *less* likely to benefit from the few that are easy to
use because they won't find out about them.

Ciao,
Johannes
