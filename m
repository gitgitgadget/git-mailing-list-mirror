From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 11/20] tests: turn off git-daemon tests if FIFOs are
 not available
Date: Thu, 28 Jan 2016 09:40:43 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280939170.2964@virtualbox>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de> <35b05b7e0d01bf550b698d3c6ecc577eb80d4149.1453911367.git.johannes.schindelin@gmx.de>
 <CAPig+cRXV-nv1ZZv1MrujdF3YfZMgwusTcBHAXnyCRaYyXmRWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:41:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOi8U-0000bC-6p
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934369AbcA1Ik6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:40:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:63973 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933714AbcA1Ik4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:40:56 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MYLKn-1abaKV1K8v-00VD2I; Thu, 28 Jan 2016 09:40:46
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAPig+cRXV-nv1ZZv1MrujdF3YfZMgwusTcBHAXnyCRaYyXmRWg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:UMUjAr4v8lZ8r09JBFR2G4lW+FvCDWZbQmhOap3pb7rokZjY/9P
 Dvy44vGSqua4oSzEhnenZ6E7fLXiMWHjuYPYEBOYh+6hoXIjDAF3RV7CmC4A42EzwQsPzW0
 KoMejqEG8LpN3ppKQJ2/lOjp+fGSEiaU4qjhbfqHFwEHmIjLTQ7QtQGBSfRHgmr5o3VtoAi
 D9jFh8MW0qxw2Vd/xvkSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tf+K/FoJRRQ=:9YfmTHS5U6HYDhwcX9rvfB
 3Ozmq92p9f56wQhZk9otun0X3buo5ktOVrMgYqlJ7A2W9GsSVZ3zp/IttYYFVug+PJy1u41Y0
 5eP35CIjn5geZt0hx3ESeBzEAvran51nlYYD1wTckWMmb/ysZdOxKiw0O9ASOCuCpiD9TXwQ0
 j+jTkND2Q2zH7wrSCqXxXhOV1uRKKrnXB8UvPw6LC+8+UIRneYhNBS4TJ/u1AfntZcMmqrIgg
 DUaSCiIzaGA+HerYYc0WheDdf57BrTDZlQPoDwq/BALtsaIYtgyWxyhO/hkjdcBT3ECcNtj1I
 9E+wnOf2iiOIWpgOEDQ0kmP3sIoObgVB56P72nsRsZiQwBKQyRvxg7I9CICmY0HE+YF2lJh7l
 7bDR0Sn5bjxmGzrnN2N5LKi5jkyaStwyBpSVbIrLjPAK9PpxkgtMi361Hl26jXHuc48FwOR9Z
 mVdyQVcSVS9S+377E4MywgqDo3gRaG1BTZvWGj8RnJ7ImmX+MKueJxeWkxgT7nYSa78kCYCAS
 RnGO2+Gl91N3S3DrPRsJqT1R6dmXUEUR6WKjT7+JvvP8b2hRXA9iUGzeUKeESfJD8bRiR24fm
 yWK8aH79fIizfG+PBhWIG1G94ORL3nkTt8wVmIV3d4mS6n/3c2qUZCjBa0NPsD7BSjdg1prHA
 FPbKMVWDiJg5A+CjXlDRUH9IPAqIY9PjDB0DHoB7sDKdk4TrA7x6NAF5NfaEjCP+SZYowP01g
 Jfe8PCfs54KjdGuPgJuycxupOTyt5Icb1Y3vJDl+qfSbWbUFowG1wRa3MEcbooMMPgFHzmE1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284988>

Hi Eric,

On Thu, 28 Jan 2016, Eric Sunshine wrote:

> On Wed, Jan 27, 2016 at 11:19 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The Git daemon tests create a FIFO first thing and will hang if said
> > FIFO is not available.
> >
> > This is a problem with Git for Windows, where `mkfifo` is an MSYS2
> > program that leverages MSYS2's POSIX emulation layer, but
> > `git-daemon.exe` is a MINGW program that has not the first clue about
> > that POSIX emulation layer and therefore blinks twice when it sees
> > MSYS2's emulated FIFOs and then just stares into space.
> >
> > This lets t5570-git-daemon.sh and t5811-proto-disable-git.sh pass.
> >
> > Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> > @@ -23,6 +23,11 @@ then
> > +if ! test_have_prereq PIPE
> 
> Maybe:
> 
>     if test_have_prereq !PIPE
> 
> ?

Darn. Of course I only looked for '! .*MINGW', but I should have looked
for '! test_have_prereq' in the patches.

Junio, could you kindly fix up locally if this is the only remaining issue
of this patch series?

Thanks,
Dscho
