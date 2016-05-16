From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Work on t3404 in preparation for rebase--helper
Date: Mon, 16 May 2016 08:33:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605160830340.3303@virtualbox>
References: <cover.1462888768.git.johannes.schindelin@gmx.de> <cover.1463067811.git.johannes.schindelin@gmx.de> <xmqq8tzfgsbd.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605130835070.4092@virtualbox> <xmqqa8jtaliw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 08:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2C76-0005Fg-93
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 08:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbcEPGeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 02:34:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:57814 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753AbcEPGef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 02:34:35 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MEnjW-1anJzk2tQY-00FzWZ; Mon, 16 May 2016 08:34:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqa8jtaliw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ILPcJyXmKNrZrTh2mpJ8YXiGG8st7RpCOEL7ELZVW3/ajXUbjI5
 zL2OYlZteeSvb91vXs+4mW/CLlxektF8JGvjIFFr0NvsU82cOchpt0J8B3muUYY96gbXC2Q
 3gfET5/ws9hK9NVjeV6SZgEv5xtnqWcMH0Gfp/oWT5L13qyISwTQ8z2N8zTmymVtJ4kkCGH
 y/XhYR6fszo99EIcE/lJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rjrU8uAtTQE=:Tou3qjEffvoZYOB17PMmg4
 GhOdXL71bke5o0sSmAFP9dPRr5VF6pO+Zuxd7C2x5cl/Tlx+UzihBEdNQA3w7yHCdVTMmYADI
 qyZLSAu56E1+F8NHXemSLm7HYG/z6aCjdDTepcVoaonaftOp3P3fk52bqPbkaivgAyacRc7oQ
 /HghTPuQ9DWdotjt57kXIxL6ACi1m/MheH0+zkUznIgpAVBffU7qAajLESHDOzpzmOv/12U18
 u9FMEA+FqMFznqzgKr0zTDg8KLFhImEUY4dDRx8a3+lLDtzZLSbRKjrcs+GVXEIRbVLITH2LI
 0zRIwb76d/vfvwg6OQZwfmZD0ow6JrifJz1AFTIZhsTmH9EHpGaOIaKpknRQOOU0d+Yzg/5Dr
 FVKYHx4416olDFzpRQyYTMuDLXY9wO+ZWBCGK4wipP71PUo0GoITzHRoeatftvnoUHfBykL8y
 8OLGOdDpZEcs6R4Z+XNvuweGSeq51Cm0gLx+NuNq7gtv1HCZB/ky5IQukTOi7oL+wrq22AZ8r
 MmthOgD8e2ksvsVUQ40wl9dTAl8RRdji1vCPVDtcuxp6M6dB3E36muRRUUGVvA1G+GbJghx9q
 y/yOmmaNWNGhLOLYBYra7FnfYIR81lUMxe2lof2Z3hilTCrzhvSfYq/jCOroQ2ZcQ/xiWH/Wd
 4tIxoMXZmnhoq8NAjs6heqc5/mGdtyhWpktjwrvlj4us5ZW10MpZqLOzW9hxDMxsPPHcACbmK
 IyskHs0q/cCjSviQr8v+UpAWKJINJAXHUTn2FT6vEoUzhzJQcwe/haVZS6uYKs8UC6S/iPdJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294724>

Hi Junio,

On Fri, 13 May 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 12 May 2016, Junio C Hamano wrote:
> >
> >> I took these separately already, and plan to fast-track them as they
> >> are both "trivially correct"; I double checked that what I have match
> >> these two, too.
> >
> > Oh, okay. I just wanted to make things easier for you, and now that I
> > have a script to prepare patch series, it's really almost as trivial
> > for me to send out a new iteration as it would be to update a Pull
> > Request on GitHub.
> >
> > Do you want me to hold off with new iterations in the future until you
> > clarified your preferred course of action?
> 
> No.  You've been doing great.  I just wanted to clarify what I did
> to your patch before I merge them separately to 'next' ahead of the
> remainder that you'd be sending out, expecting a possible course
> correction, e.g. "that would make it harder to queue the other patches
> yet to come, all of which would depend on both of them--it would be
> better to queue them on a single topic to be extended with these
> other patches, after all these two are not that urgent".

Thanks.

I planned to work on the remainder as a "topic thicket" using my Git
garden shears [*1*] anyway, picking up the changes you picked up,
replacing my original patches.

Ciao,
Dscho

Footnote *1*: The garden shears are kind of a `git rebase -i -p` as I wish
I had designed it originally. Thet live here:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
