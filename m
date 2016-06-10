From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 10 Jun 2016 13:11:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606101307080.3039@virtualbox>
References: <20160511131745.2914-1-chriscool@tuxfamily.org> <5734B805.8020504@kdbg.org> <CAP8UFD1ukOMi_VDKzZErwSu1OBU5h1hVOxd7mPu1ytzFr11VGA@mail.gmail.com> <5759DB31.2000106@kdbg.org> <alpine.DEB.2.20.1606100852550.3039@virtualbox>
 <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 13:12:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBKMC-00008T-2R
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 13:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcFJLME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 07:12:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:56156 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbcFJLMD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 07:12:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M6vSj-1bPr6E3SEP-00wmgo; Fri, 10 Jun 2016 13:11:40
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD1zSAxyHfZgBbfoF=th0waZWEhvHP+4jUxxVO+rU9N9RA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:htV9R7a3Pip1Q56FVZaTt/Ch4Nxari/fKYeuqyuGQ6xvetCMpcD
 zEP2GKC1PfhTYJgAn0nsPLDWuiwREYzDyvIhkRsS3jH00GmrCS1oN+cbo1yrdqDaQdFnF/2
 SPw04+jazvJw/JmFOiYh+j7nM3hMXRVsWDaa6OXnBGH6Tr6OlmuQ8RvYJS059P+zB7tGkYB
 Wsvqs6F1i5/jWmQDuAzuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9DcGXSwvLxQ=:4L1jAFj258/L4hT7gQnGIQ
 ee6MDzLp1/rv2o8Vl92W7m1Ex0WynrDPrnQxh6unsHBgOJGhhCeOpljYfpcZtYB5m3jet4CoO
 goaZwqoKlcaFaqE7MK924R7wOeuNC2bbJpaMdqjTjjoymjQZ15DcYtAx5PXEKjyfw1ifgT5l4
 JI5DotaQSA6x0Au34SFz9CqSh9N6HLN2tQOIP9AK7FRVuHBgxRcv7IEZcggvoZJgzlsdLYu7Y
 A2PFgjRxle/ktW/soy5xZ5Bp1cDWe9DF7apt1d4chVJkVFzM518ThSpRfbZhPFGZf6M5hpCdv
 r/CrVbVsOhysCh5cRPIiRmBjs0b2+9CCfDWcQlJhnPld2UqrzXCEAkHce9DmVJm+J5fyKL79N
 MsZw9/YfXCuwvBx/cZRIB+WtvkKiQ++OASApd5zy69HI6RVveC+nKWd8pJVuWlrZjMuywroOR
 YtZhKafFAfLK/RpsiackS9kWRgMpVMmGsaqDQyjf92zi+DBhDLK8Z4h08JjKY6JdXsUe56SeJ
 k/HHI5wfvazjeJ9txJh9aGrstCrlktQMUG7sWqY2E0PiadE4tqKwStvzFgQJVKM2Bf215h+uZ
 CClCPJnbfffqTUzVuhusjLrej7dVJ6d1IgP++nqaruUoZIZCXz9EO35itgs5YNddW/ca+luSw
 9NlQkDnxo1TVUBmgRmOV7VkwivwB9+XFUwUQATR2e7oKmRP/HwUFyyXnbDu2062F6V0aqGHpF
 o/DY6XaDsJpxxXLq/rjhrDUGDr6c11BOahUOtm4YACfJivYZDKpfWLVFFkHnoB099zZj8b7O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296969>

Hi Christian,

On Fri, 10 Jun 2016, Christian Couder wrote:

> On Fri, Jun 10, 2016 at 9:01 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 9 Jun 2016, Johannes Sixt wrote:
> >
> >> Meanwhile, I have retrained my muscle memory to stop before typing "-i" after
> >> "rebase" for an opportunity to consider whether bare rebase can be used.
> >>
> >> What should I say? I am impressed. It's like 100 times faster than rebase -i
> >> (on Windows). I'm now using it whenever I can, and more often than not I plan
> >> my rebase workflow so that I can go ahead without -i.
> >
> > That only means that I have to finalize my rebase--helper work (which I am
> > busy doing, I am at the valgrind stage).
> >
> > I wonder whether that "100x" is a reliable number? ;-) FWIW I can measure
> > something like a 4x speedup of the interactive rebase on Windows when
> > running with the rebase--helper, and it is still noticably faster in my
> > Linux VM, too.
> >
> >> Can't wait to test a re-roll on top of cc/apply-introduce-state!
> >
> > I lost track in the meantime: were those issues with unclosed file handles
> > and unreleased memory in the error code paths addressed systematically? My
> > mail about that seems to have been left unanswered, almost as if my
> > concerns had been hand-waved away...
> 
> Haven't I answered to your email in this thread:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/292403/
> 
> ?

Not really. The reply (which I had not quite connected with my mail
because they were over a week apart) says this:

> I fixed this by moving the "close(fd)" call just after the
> "apply_patch()" call.

and this:

> I will have another look at the 2 other places where there are
> open()/close() or fopen()/fclose() calls.

but nothing about a careful, systematic investigation of all error code
paths. As a consequence, I fully expect to encounter test failures as soon
as I test your patch series again, simply because resources are still in
use when they should no longer be used. In other words, my expectations
are now lower than they have been before, my concerns are not at all
addressed.

> > If those issues have indeed been addressed properly, and a public
> > repository reliably has the newest iteration of that patch series in a
> > branch without a versioned name, I will be happy to test it in Git for
> > Windows' SDK again.
> 
> This is the newest iteration:
> 
> https://github.com/chriscool/git/commits/libify-apply-use-in-am65

And that cute 65 in the name is the revision.

Ciao,
Johannes
