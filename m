From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via
 'sh -x'
Date: Wed, 23 Mar 2016 08:21:29 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603230820140.4690@virtualbox>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de> <20160322175948.GG28749@google.com> <xmqqfuvigsl6.fsf@gitster.mtv.corp.google.com>
 <20160322234524.GJ28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 08:21:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aid74-0008Iv-UW
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 08:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcCWHVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 03:21:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:61013 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbcCWHVs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 03:21:48 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MgXCF-1aNPBr4Ax5-00O19g; Wed, 23 Mar 2016 08:21:33
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160322234524.GJ28749@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XM8S+sBsMudypJq+tY+1sqhUXaF23yRiylZzv5lZWqzEvfQN0hi
 dwS2pApcwa939akXuIhlZ3RVBAWdFO7Hq9EZBTi3hFgOy+dJP+5WZlR2Vv2D2IsZl+NcooP
 ZxPqHGhFDMs45jpNi3OzR4N5przOqcNdW118K+KgFU/iu02FRxgeMyaaTzh2ck7czXWt7WB
 xVIbtOP3fK+obnv60u/SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zgOjNGUdz2E=:9RuqJhqoKVRumTG4qznE2Y
 TtVc02d5y1PyDtX6HCEt/b8M3x4STZZbZSUIm2w1crgLTs57tvU5V85Ld8EUTtyaNcMFqIE5b
 ctp8jIraXsP5R0RaKPJn2QV4g0/ZEN2Ox+wMdwRIoWneQOqiCwFNwKy3AqT5thlRxkE6pKAz/
 SSgpIkSi8UDwz7qWI3mY8meje8r8S930tq3M8FWQJlhhBto9glJrsGeBrFQq4F7OT5vErUCjP
 kVDxl1a8Hzo0O8bUotoWITuJyHawsanTZs+yzn9dx3GEFSpShCTqQT/3YpuoVASIlyOQu1okv
 /IPeVYy+JY/KCP7g7lTqoxr34CSvyRt7uMk4Y/uxoRmejF5NNAjcqUoDm/O8qDpzfl/XF5dJE
 kGlx0KVZFwdB5wWehFxlRmjngrl5yXPSUHSHE7n/to16NFl8FO5RYZ8Von7FARtli9ehetc9/
 oZ5wjP+Hz4FbvThv1G/ysSKA3SV7qjBJ9daofci+Oy5ZkkA9Feqmcl3K8JG+QbtgrH7DhFWYk
 3yvbX/sAj2i77fQVQOKl1zZjAJaPPfHxx5IUUcw5QJFEsPF68SEctUgRwm/j/bej9UXZvrauP
 83sZ6vosiTBV/pp9aTobFfjmVZWK67oEHs9z0poqmbci8evhZm3qfsCJlAbu/c+/6a39JTpJe
 To+Ox6CzrUoHDKTVPgAEuk1jl+PbdrkNE/mnBT6oUhRpQCUQe+55iBFF1WZWFdJq8wDSFedhO
 Yo+ZpasneDFzda+C81gijEIxDLC8K8t+u50tVzAoIzE+HFw7TZXF2pvshPnzD9dFdn7Tflq/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289597>

Hi,

On Tue, 22 Mar 2016, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> > Both sounds sensible.  Should we squash this in, then?
> >
> >  t/t1300-repo-config.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Sure, makes sense. That late in the 2.8.0 game I tried to err on the more
faithful side, hence I kept testing for "fatal:" but if you two are fine
with dropping it...

Ciao,
Dscho
