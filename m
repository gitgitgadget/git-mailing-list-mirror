From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Wed, 14 Oct 2015 18:52:07 +0200
Organization: gmx
Message-ID: <1326b047519c9398a0a06e27a26295ca@dscho.org>
References: <561E6FBB.7060302@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sven Helmberger <sven.helmberger@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 18:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmPHk-00006x-0I
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 18:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbbJNQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 12:52:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:57725 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbbJNQwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 12:52:10 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MMk99-1ZeRrL07Op-008XDJ; Wed, 14 Oct 2015 18:52:08
 +0200
In-Reply-To: <561E6FBB.7060302@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:PWdo1gev88Mb4ztBznBWbiVcm0V1d6gCGP2vym6iLwUGIB0zBcM
 4iX3ZyJjv1TFwUiXXZyyVpV2p/oOw4Qbzf9w/oh5IGGXxhqpvm0zRBxOAsK4SAMoryALAVC
 S5nyweyYfbF1XzEh3reos02vMbkEFkwooPmnCoJ1flQHJtunIeaiRUaLvRuGQnMhQVuR4nO
 wSvXeU543+p52+gBVD5UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5HX5PAfsK6M=:zaV1QBDQCuFQ74n9mZ8mmV
 5L8G8Haj12H/S86jvSAVoqTILGH9tj/evQip6HBhMDAr9xtUSIcCkA7HuCd9MgOBeZuK/9atO
 QNF1+xLqqwo+vhBsplSK6+PXft9Z34Ah1bOQtB66gd95baYWMY4LO7oE4XQTDWtCxzCBYqFb/
 2WuRvR+yERGzxd6S/G+2pHvJAnwNWx3jZTa69uLuLuajvuswzAm0N3ZNL5RZDKMgATwGAVyHo
 pYrnsO365RXvKH4qWfjmpY8I4qKX6WcMPJFxkBDWuyDRFFA16Uy5hHjkFd9AovfPDvV1sgquN
 ozCTKezK4RNOoZh/jq/jwAV7gslGLLuyGBspRHIqxQs+e/9kNcc9KK3Tg8FlECwY0y28Gtk64
 R6Ofpv6QP8GHMlHCyiXuK6oFmXPRxXof+lSXYpyULPTiQr6qQ3xWEgoj6lKwevKkuIS5un8bn
 VWhfsMUPae/jgFcy10lEkwLd6SN3x1InRU9ETVsgbUB0ePBv9NKCagxGHu/e57Y0C8gTUxHaV
 SW2ALYWwfh0fHmXc90781CuCCGApGTuU3bh/78ZUDJWBUmAaeqql4GyXlnb0He37OtvLfbYPk
 f0iQoFs+hZvgqNoEHG7l0OGaBchKxtfznWKjfyDEfQDVI36xLrM8u48hdRV1qCIugM/JBGAV8
 JRYvD3LmRoi4CEHINFULk49TDN0RRygg78IqQoHTZmSed1lXlGz7wMqQm2CwrYfkI5CRcQX62
 58SDN11wR3kb8/uZG6YPfig+UOGfWFut8UdkHE3+U8H15W5syWTcVy+UFDDIyiNljGD+Zxrz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279579>

Hi Sven,

On 2015-10-14 17:07, Sven Helmberger wrote:

> What I then often encountered was the situation where I happened to have
> inserted consecutive lines of code that conceptually belong to different
> commits. Normally I can nicely split patches, but not in this case,
> making manually editing the patch the only alternative.

How about implementing it and then discussing the implementation? That would have two advantages:

1) there would be something tangential to discuss, and
2) even if Junio rejects it, you can carry the patch in your private fork and use it forever.

Ciao,
Johannes
