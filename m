From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 08:14:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603180752540.4690@virtualbox>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com> <1457548582-28302-19-git-send-email-dturner@twopensource.com> <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com> <alpine.DEB.2.20.1603151517590.4690@virtualbox>
 <1458151880.9385.1.camel@twopensource.com> <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com> <alpine.DEB.2.20.1603171536420.4690@virtualbox>
 <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agocf-0007mG-1t
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcCRHO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 03:14:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:62160 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcCRHO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 03:14:56 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lrek1-1Zfjle3gxJ-013Phi; Fri, 18 Mar 2016 08:14:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fN2aUq1HUxVoz2sEJlc1j/TWX24+J609v59pT+8/Dmh2GMOohkL
 v63Mw4SvT0KM9EtE6PG/irVLDUhOt+UrpNrTclHaN4bUNLmKNVukNrzJPCGAlFBLSmyFcmw
 Yv3n7KOlgzfLRT0Ik+NGXz6iY6drBHNLvtukipZDLeMV+o4KQiLM96Pw7V4kUS8D7GjYCkw
 XDSV4cBJ5lCT3PEv9RxQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MCZUvjwvj5I=:wW0TYk/9Kp3exXigoWK8oU
 5DaciG9M2Ue3hTtzO/a5BzDma5//2N+Z7ofvvpohbqaZKB/oShFEuyCYYBPMzyTQZo8Yq1pOW
 rdmY/aHoV1mX7GXgi35PkuD94HNW7yH3lnMgKqis8YLAK+PHMfizWuN5oIdYGvG0Dlouz0ng5
 qlSUJdah7jW2/QDTGZP+aEG2z3Z7bIcZqk24ZZeGQkDurV4M6CwodC+OrS56p7oVBRUqlIupm
 Qz0FJf6X5GZiCnpcP+FDUIlS5znduiG6Rx75FJzlEqPPuhAPJIRCstdiqCxff0rZr+SxnMBVO
 bh+iG43gO7aLrjBf0N3b6Rs00rU+SaYEYOCL/9MZyLBj0MofzRrpew5fo19ez870LRbftZIh/
 P0/zEKWqBh6MD3JgS7BXdE+9lAvFl5pmibBjEkWsVCgD2EbYEI/17UjicGmCUpPc0i+FnEUmJ
 +t6z/vWIAnLPt/skEAHOHZ9lkSuF6cKHvY+bJXCPn5iiJnVD/qv8dX051HGFjD62i0i27Tu0o
 CN8SUxKMkVQtFpk6goR50OJXfciR4r7Neyw1fEbriv96ZRmUH5jodRyWQhHyi9/6LNg35XKZ/
 JjbtnfOrDFFnlbkuaV7nH9FhbO7Kin/4mxxpPrsmPSzhi6BdxEucOz71maMoFOWmHkzLDwbwN
 wHWXa3nIC19Eaq1COX4kiKfeEa/ZxhUev6CrGAXx3tDzwj7VA2CiJ2vImst2/R7bai9eM+X3n
 8Z1aSkuqCh83hzYkwlNWlGoMo0JVMo2b4oIxHS4ToXXTTmcvmhZxDQw+zNtfupbkCi3JCyOt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289206>

Hi Duy,

On Fri, 18 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 17, 2016 at 9:43 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > I know of use cases where the index weighs 300MB, and falling back to
> > reading it directly *really* hurts.
> 
> For crying out loud, what do you store in that repo? What I have in
> mind for all these works are indexes in 10MB range, or maybe 50MB max.

Welcome to the real world.

> Very unscientifically, git.git index is about 274kb and contains ~3000
> entries, so 94 bytes per entry on average.

In terms of software projects' size, git.git is but a toy. Most developers
deal with vastly larger (and often messier) repositories. This is
especially true outside Open Source. Even the Linux kernel's repository is
*tiny* compared to real-world repositories.

I am sure that David could tell many a tale about repository/working
directory size, too.

So yeah, this is the challenge: to make Git work at real-world scale
(didn't we hear a lot about this at the latest Git Merge?)

Ciao,
Dscho
