From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 09:01:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606100852550.3039@virtualbox>
References: <20160511131745.2914-1-chriscool@tuxfamily.org> <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com> <5759DB31.2000106@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 10 09:02:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBGST-0004if-LT
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 09:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbcFJHCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 03:02:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:55027 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbcFJHCL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 03:02:11 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LlVZv-1blQ9G2Oc3-00bKca; Fri, 10 Jun 2016 09:01:45
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5759DB31.2000106@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:yEmOqg07qx2Gv4PsHZQX7FNGKvccYIzhthmUfAwELq/vtAK26hc
 eupDuwY0blSNiP8YYRl1SU5VmPdwloo56b7bJxzuh9Kzozw/3tJyP2bGMFbDUIEW/ZHqxiP
 4Apfuvf6vh7Y17WT4jjbLVEvN6xsxjPRWdPAv/uW3xIhHc/gxYub9ZBquCu76VlezghMi0z
 7AnGkH3QidaM/ZyjLWu0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p56/l4R7Ngo=:1K5m6maLVeMTzcT/hei7VE
 k0Ewd2/qNNBIR4JDzJFXwlayRE3mrYBFfaYvs9s/anW3AyC/jv8HqMW3cevuUr5GGVQs1AHYl
 sgtjwUorxZS01G3rEoiJYmIrDZwQcX/8Jn+WlAP6cK7X/mmZiTl9uzs6XRMtiLJijg3EX6bwz
 PYrh2sn5GROZIkl0sQ14C2npUeGZZBNMTguQk4vq8ZMniLbcktSC7cVGxGe2AZGIwMK/4ImmI
 ul0gwhWyXTSkNynvLg9HYLgs2+PEC11L8j5VYE4cv+3gJzSG0uDG+pmem5Unbv9Hcht48EiyV
 7KorL+rilk+o4JN5zussOvfq2h3zY3k8L2co4nf/E27CAcVXVA5E9VoAOWKFZSHzZ2hpvaNj5
 nuR70vchFgDmvGrnOtZNECTW9A85K2jFCZ91e0R0ZufB8wGAO07152aThZwEHUH0sEI3u8wcy
 +3A9czzZCrkoU9+l2rxoYTmAwWgvSDueCOjQatHhXWVH5lgou/nzg0/Lj/yXD1VGYBHJfge5s
 CgMzo2Q5ToQvQ9IOeQanwtf6g3lZiz4Fc2BHCjy4DxDQ0LHg88nY+uuVwoCloGAPUyKMFCUFj
 f4rx2939t2CeOwjXWty3Oa6mLTuV4C0kQuHpkDTtxtrrCDUBwd4730sDurSOjUrqu6cTmmdqU
 Wtgnw5/OfWkCD+aZaQ9TSytNLv0NxV5xpQdmPllwg0+8/xuy3y8AUNcBVwKRHUyA5or8ycxn2
 wehud0dgfYnU2bA75s7GlVuPySUxL/SzoO23ix67eYQ5PGe7nudKo9331J1i+CmHOF4+hK44 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296946>

Hi Hannes,

On Thu, 9 Jun 2016, Johannes Sixt wrote:

> Meanwhile, I have retrained my muscle memory to stop before typing "-i" after
> "rebase" for an opportunity to consider whether bare rebase can be used.
> 
> What should I say? I am impressed. It's like 100 times faster than rebase -i
> (on Windows). I'm now using it whenever I can, and more often than not I plan
> my rebase workflow so that I can go ahead without -i.

That only means that I have to finalize my rebase--helper work (which I am
busy doing, I am at the valgrind stage).

I wonder whether that "100x" is a reliable number? ;-) FWIW I can measure
something like a 4x speedup of the interactive rebase on Windows when
running with the rebase--helper, and it is still noticably faster in my
Linux VM, too.

> Can't wait to test a re-roll on top of cc/apply-introduce-state!

I lost track in the meantime: were those issues with unclosed file handles
and unreleased memory in the error code paths addressed systematically? My
mail about that seems to have been left unanswered, almost as if my
concerns had been hand-waved away...

If those issues have indeed been addressed properly, and a public
repository reliably has the newest iteration of that patch series in a
branch without a versioned name, I will be happy to test it in Git for
Windows' SDK again.

Ciao,
Johannes
