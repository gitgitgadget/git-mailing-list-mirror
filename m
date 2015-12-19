From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git leaves behind .git/COMMIT_EDITMSG non-shared in --shared
 non-bare repo
Date: Sat, 19 Dec 2015 11:40:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512191137450.6483@virtualbox>
References: <20151218195503.GA4554@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yaroslav Halchenko <yoh@onerussian.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 11:41:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAEwf-000655-AQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 11:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbbLSKk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 05:40:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:54087 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932665AbbLSKk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 05:40:56 -0500
Received: from virtualbox ([37.24.143.167]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LdpZX-1ab1It3zut-00izBN; Sat, 19 Dec 2015 11:40:45
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20151218195503.GA4554@onerussian.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UE7vKBWtsfAalZ9dJiZeWmfhlhJGoRB7FKm2QQJ/2eHd3fMZUIa
 uqCYNdhHLJFN9uAlWYjSpOZ4v/IZBDJ64Is9iCD1ERgnBzpJ6J07sTCwtd7eS+S9MFAZfRM
 9yDNL8uJrRh2nRZp9w/I0syGIpWN90k1QSHYJuhdwx2ZSDfDUG/J0F1xNSXFrDGRd1XZL0R
 7x1JKm/m2C91TQ9a7od5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H8HPnUuumtQ=:MisILptxuB6ISUYc2J3rqg
 lqgXmRgfSCCPg4zfHc9sIy3fXMz7e1uBHbmvcHV3ptFP3qULjbQxKZjHZ7GkgpzOYFm58tC6h
 r7BWMaRJ/RWVml9A22At/vNxGVP936vccOfrUvLPf45AHDBeKZ8yDKd/AV1akicB9xQrQMAjM
 5NjOUBK4lT2sz/i+MpxGiBq/yD7WHbbXl7xvHFPgn2A5pxC8+2pFw9XoX48OVEm8iDHrskrJV
 poEBem1dj1tH8TrLVGyfAf+eD0IA73a0hCK/Ccnevjbnevc4VdgoKuA5ZBhY8G03BBw8vk0Zi
 RG0nooLzOLJZUwNEOoSVgfVn3p7yaeWcjGEzKAo8Dj+LgrOeHjfJBodcAeSJWR3cD7cA1Lr3f
 ixTAPeFEV1WaIBODBaxOUPscd1fH9C65gIq4U4IK1qbjyblxKxmBaEma0GGRKx/cs/X4+UxFG
 MXuXbEu/wFOWyg7Af2iD6ill7nwgehVoXQeU0Vc5RKsViV7GXzOF851PJ3xGRDQhk66Uk2vG2
 OFY85QSsSdglP7cllrfM3WrQu1IePh1081IrlVFLUtZgdw79x8juNuvIhsZ+m/zTi4cZNrIIf
 gZO1zA0IEdaQ2VKbSIiuSHahTQ3qBLE3c+nAXXXYPNL97pPe2Z3q5Rpply/186w9EauJNjAPn
 mFWvEEtLHXxojXXk6DS6lkBKM9HMqBIn1dDs2cQh3Ayd1Yzo2uzY8XpYriodOaha9VVr94tM+
 shIo7KmskNwzhrzkhx3tBXl2wk2V5xGr5AAyxUUv+WjeWk2FbhfCpF2zadqB6D8dwZzMbm8u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282742>

Hi Yaroslav,

On Fri, 18 Dec 2015, Yaroslav Halchenko wrote:

> Not sure for what batch operations that file is actually useful,

None. This file is written when you commit interactively. It is deleted
afterwards, unless aborted in a fatal manner.

So I would try to find out who the heck is working interactively without
finishing their commit message in that shared directory.

Ciao,
Johannes
