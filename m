From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward
 slashes
Date: Mon, 28 Mar 2016 17:14:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1603281712470.4690@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de> <56F8E435.3020304@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 17:14:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akYsO-0004nU-4x
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 17:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbcC1POi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 11:14:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:62002 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbcC1POf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 11:14:35 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M9aX9-1aaxxk2X79-00CzL3; Mon, 28 Mar 2016 17:14:19
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56F8E435.3020304@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0hMJzCq4URIjxDXO/lZNaP5GRz2R1LROe+qz3ySbhgx5MKZ4lya
 ucVMAtX25upRiFhlV8TFtlgICunbzu+KTU+ag7BcU54r7MWqS7QGYS8s1ngwD5VreXvyjDV
 u2HmBuJFptjyAVdgSD+2pU9yuQyxJ6sBQbXTHiG2flM8wyCU2ubel2nk4RblmG66rpwt/4P
 4T2jPGyIpNMtVYjEOCzAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zv5OVY4hzxg=:9nNexvv3vLvnMnZ8XDQ1v2
 GfpWaTHOBWkPgtGLDctymrx1yg54Ahg1LCzm5j4PoiixGtoRWlVTPdTyCi9LTllVUaK07l+H4
 8vDD1sV9ugzZigDFF85l6U993X7zYalKIf+C1AoFfbE+7ybXnAflbQfVR/3KFRt9VQ/kgLCyE
 sGZavL3WAfZ0ObMCltO5eAGKYKIIT+f1wlLymjQoa3qC/RtmIYf53lCgvMxZFl0iBCMDarudo
 VoErnh9vEyOjJ156+zeqvh79cuJIwFhwPH/NOTCsIRQYv1RlZ7TNJ3T2uMaLpGu6/ZPp3D2lN
 3Yl/cHvye/ZMURaTG3hCaEj5buhOAhCrvvtwuwEqW8sacLL9bFRMARsv3X55V9XCQawQflZmr
 Ri/5AZvq++tfUXmnGvzlxdokERJkHJ5wblN2l4qNeQHX5GOq50Or3dgjxs+B1TYUbmapgYK/M
 FZYCpGUCZ6ZiUwYNIgz7cVtiUPIFrrpriO38G9+LIVmd0UBKkCMFRuoIDUC/FK8abHqh6MOPm
 NV3nvEiAsN/EwZWAgmBNGjUEYTckAKAnlEiGNJPCVMMed0DjP297T1g0OdjaUoMIQLlTJkfaU
 8755JwtTgsq93xapq5f0itor9obfNMR5vdnb+Cct75QjwGDyBILZT9+M/4pgLVkBpwUjNdyK7
 QLpU4gNJ1rWDy0W836SOH9hJtic/oZEUpAXIL6tF7XbIlPKGRiunJ3MFVMv2dGyrvs4xis5eH
 3mbiQRff98TYhnK6hSYiwJ+3gUxKolkSYNXf223wS0/KgiP+oyu0HGTo+ArfEUPNKjFtSbaY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290040>

Hi Hannes,

On Mon, 28 Mar 2016, Johannes Sixt wrote:

> A change like this whould have been preferable:
> [...]

The problem with your patch is that it does not account for backslashes in
paths resulting in quoting. I am afraid that your patch will most likely
*not* let the tests pass in Git for Windows SDK, while my patch does.

Ciao,
Dscho
