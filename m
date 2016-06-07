From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t7300-clean.sh fails "not ok 32 - should avoid cleaning possible
 submodules" on debian jessie
Date: Tue, 7 Jun 2016 12:30:56 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606071229500.28610@virtualbox>
References: <5756856A.4020406@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pirate Praveen <praveen@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 12:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAEHz-0003Qp-UV
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 12:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcFGKbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 06:31:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:51017 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbcFGKbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 06:31:09 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MX19U-1avzBV2DDg-00Vxwr; Tue, 07 Jun 2016 12:30:57
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5756856A.4020406@debian.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:I8QH8SNDBeRxwsc1Z+Sp+jEXqRbTGhlPBl/fL+yi5F0FD3UpLlK
 /3jztvroDAZnVE/ADrYmF2bvPWgUIZpTzQFytE9LwibZwro9yPHKx17wvvGxZQvNKRg7zY9
 TzEY7tMr4RSxH65/VCoNeIg35rUkrm+sbdplZzEc1540n4y+p1oP7iTweyLfflawFIi1p3W
 s/LaYV4Bs5JYtgXE1zuqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AarKBGlZbQo=:t5IpPxS0lX1eflmkt4F1VY
 zwCyFVPQKtaKcWe4XaYtNJJNTryWNX6BXJ/OqVK9pu9f0MwQVFkHYS+IVW56A8fd6UssUPES6
 0HmWKskL5q21jgDmUOBYkbxag3hr58D+IpNK2vzN5mx2TCrwIFEI6v43xE5TJNtlhvC9kKL9w
 k1FuOnfmYiScjBQn13smRyxJmdIA08lSzo7viHcFVnjkVROqAzTMXMh9WeEl9jUn6EVy1J30v
 ktSQv2vLRgXknFuLh40k4mm4OnHeSIBVJ+C4595GXlzDfSskkOwxC5i0OfsgpDJVtfAMgLyuS
 A1/yxZ5rJxVpyaBqWm3pUMoD15XPxar6vm1LeJMVUt5VUvI4yiNkJb3NgmozD51/am0U5gyhf
 swM1kEHa8UKpcQaNvnsZo127xoWG8kn554chcr1KFqbou+UyyjOND1Wp/ZPKuYdDwa45i9GJz
 2nWhqqF1S8bLr0APPaz83F2VRVZdW17AOsAs1o/MNERbWy4L7uoPAnLm2EAuPjbntqaLa4dMI
 HdviQ4kSGLr6OCulqvegjZgm7wvSvUUbX6g6x7x9J0tzQfRf2UQ4TFKbVvM4XEAdoR4HUjbZP
 ZvqnVzfkeizAX2CcPWTxNX/yvIff+l6PUjsoulGCz2bpk0t3ShDx2RP4+CF/E5Tc6vNR21yro
 EmE5KMQxeAevgGo/F0Uhitdhsdvo3FuUWnMizmgCbuNhf8d+AY1meAfHpt1wFQ7ovweaefzu8
 VE6WbeNMNEL/2Nk44yK97Uermjp7D6HTshZKgTKSYLEM/ctfZOBoS9iVaKqAvXSIJ6wvN7uY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296624>

Hi Pirate Praveen,

On Tue, 7 Jun 2016, Pirate Praveen wrote:

> I'm trying to rebuild git 2.8.1 on debian jessie/stable and I get this
> error (tests upto this succeeds).
> 
> not ok 32 - should avoid cleaning possible submodules

How about re-running the script with -i -v -x? If the output is still
not shining enough light on it, maybe you want to paste the (relevant part
of the) output into a reply?

Ciao,
Johannes
