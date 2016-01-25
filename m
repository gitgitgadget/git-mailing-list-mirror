From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/19] Let Git's tests pass on Windows
Date: Mon, 25 Jan 2016 16:45:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601251643320.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <xmqqmvrubfxr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 16:45:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNjKp-0008HH-4l
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 16:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756420AbcAYPph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 10:45:37 -0500
Received: from mout.gmx.net ([212.227.15.19]:62756 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830AbcAYPpd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 10:45:33 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9Jss-1aFWfd0lA6-00CiGV; Mon, 25 Jan 2016 16:45:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqmvrubfxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7aX9se4pSYX1LxBI5xXKterSCdv2hN1nQ41anEhH9bPyFlBeRl1
 RCRMKdb3FX4jihRXJOfC/9tRAtGmDsy9uHVCd34MDpB4Gh/9qKoXJzZdUBWLfIO6BTUsDlQ
 mAkGS1BJrVfZYE0NnI9rqdfQpprN9F98PuQsyeWHMBRxHyEWmX8RWXqqFMte27lPeBfSGmw
 0yNQqAUGijaprEMJwWBtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MfaiTtm6byY=:MO+v976GS7MLs09aVrdNT2
 HBcApZPWqYc/1ycdPh7cWz/0UlEkqusZE4yRwOuRYnw+4CYUcPlxux4i9nV0dxmI2uRnCSMpE
 diXEPTrPRIpnYnZn9ZMky6Ssb5aLJpT7I0Vh5UBJzlXMzfJS/oQ4hBxf5l9QC6+PHvw2UMIZ2
 S+a0Mu5dql4VPakJaKFP3z/wdHBv7mfukBI2R5cfD0hniHOSAa9Efynhl85bwN9lGHc5IGc5G
 URRH8V4QYYcjEvpX1foBl60CJJ+oi7n8baILhazhuG+8+9Mej6fccS9rpqBqoGBkKxYywLx3o
 +gEQISfNn3/m6f3ce9oEscTnLiRZ29tJCHPprAIj9/xtYuQ/0j2QNDk03ttgxRRjirzYg00jt
 iNTQLal2lO6ZSoCoRc/Wczm6ih13PT0a9Jx5nik4KFSB/AicJejOB7UFYBAzdnTX7D87o6VpW
 HiEQvMr2v+0mfiXZq22v0Zp5ASQw8jQXe4MHLGHAOf6jY8KjX5GBHh4TimygSZhgoPHbUSR4I
 er8LNosnCU6YAGJWj840a592NgArqqyBCYTAgnuVYvSNGAEMjkjoTncc9GatmBqFBwm7ESLgm
 xVGM+NHWI+s2K4n2zlba6NBDox+LrZBSv/NN2ZYASK5J6MdhKfEj2CBT/cNMNiC1/0Q4dUBmi
 NLOpOx0cOvfujJGp/Ge4dkR1QdtRk6Bb7sjVgzXKFKIwucwEQHpzR/hSzKhHpjIra/nhZVBtu
 tXmouBIxBD+N7I7dl7CJqV77kHMHtsbwQTdu3j9Ejv7UOdV20EEVRSfrB1c4K3hvnofnz9do 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284736>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > This is a big milestone. With these modifications, Git's source code
> > does not only build without warnings in Git for Windows' SDK, but
> > passes the entire regression test suite.
> 
> ;-)
> 
> It is somewhat surprising that with only these changes my tree is no
> longer behind the Git for Windows effort--all tests pass so everything
> should be working perfectly, right ;-)

Oh, don't you worry, there are plenty more patches in Git for Windows'
fork. Some of them will become irrelevant, others probably already did so.
The majority, though, I think will be of interest and I will submit them
over the next weeks/months (it will take a while not only because I do not
want to overload the list, but also because I have to do quite a bit of
spring cleaning).

> There were a few changes in the series that raised my eyebrows,
> which I'll respond separately, but overall it's a great
> achievement.

Thanks!
Dscho
