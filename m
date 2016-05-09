From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Mon, 9 May 2016 16:59:41 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605091657290.4092@virtualbox>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com> <1462546167-1125-2-git-send-email-pranit.bauva@gmail.com> <alpine.DEB.2.20.1605080858190.4092@virtualbox>
 <CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 17:00:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azmfT-0001DG-14
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 17:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbcEIPAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 11:00:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:51666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcEIPAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 11:00:00 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lu8Ri-1bjKC60gcA-011Uu5; Mon, 09 May 2016 16:59:44
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:dDynlgzexlqH3FTSzvEbU1e8Xqi2uMQr+2Msgz8uVE7jSwn+x6B
 4HhWbkcHp0lzmSvfuzbvPBWp7ceLzidMMh3RhbrMiUQMrFlOTXrl7Hnd80Cm/cR/DGdwuth
 VdDWLt6HGZdHSXdbHTMq5r6I77iQDRpaY6wE7zJxhVcgSJ+TAVGWhFkqSeX55KYxtgV9v8A
 T0QDw04gy5AxOwucnGhJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zfYMZ1UvKIM=:ji2qo4zTlBUK2lpCTNCC8B
 hJTTwOY3eHefNWIcSaLQIAc/egyd8hOeqhRwYJZ5iy5ZV5MoDaTQw1UzN8Rtg+a62Lank8lxR
 DQRz3G9AB2YNWMMm4EMgN0U9U6M/SaNkaKZO2OSCtJfPJYkRiWjLLy0Ic5pZYalkcnFr0zx50
 XT5s3ujTLg8u6BX+6CmNVP+u1UsEh9FbQpJnOmXO4HM1r3cziAJ73kEqWWn4G/dkXCRN8tsDa
 /Jgpn0bLZhInHf1/BQmNzWbEZlltItlbCWLzNdEU2bQucBQMg/LLC3osgJPwod0ALtMIgrcnZ
 +GnpoS++9UK22c3zCKTPSGwxvf448XRc0Hh+Sj0Pb9K+k7iGRNYwPFq81aQ/CAw3DmSqs75d/
 9cJL7/9Awm7w5uOcLr6v01KmTHL/Nmv6qScnEbMI8HEnHq5CcFrn/00vTg+mlkeR8AEajym50
 jxZpN4KouhBHEhpZvXnQnEufHF/vgKW2zGmjamV8kLwKmdWgdypRtC3TmOrUtczWdpqd2rzck
 is3sDYZpv/pvIen/WCRaXQb3wNjIIgHqYbL0lcOaGqrJ55IdrwgLsI2IqVDLCANb+SZQcvCuY
 5Bz5qJuElMIKd4uou5smniNrDtvbw8oPI+PpAOWp2WjlHa8dP778tPH4YCm5+Z3Nk1HVpYNNQ
 kXAbRF3N8OhavVtoFVe1o+YO4ArcxgnPHjOTU/uxUlndBtuEsdjyPxdeuQxjfi+N+tUZ44j4u
 5QrRLa4LBKehHpRi+1ahyX410VZMaiGhZMUX/eA+p7JwE+ydRRYvUCzDMBoGBq892i6dbOfk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293998>

Hi Pranit,

On Sun, 8 May 2016, Pranit Bauva wrote:

> On Sun, May 8, 2016 at 12:34 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 6 May 2016, Pranit Bauva wrote:
> >
> >> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> >> index 3324229..d8de651 100644
> >> --- a/builtin/bisect--helper.c
> >> +++ b/builtin/bisect--helper.c
> >> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
> >>       NULL
> >>  };
> >>
> >> +enum subcommand {
> >> +     NEXT_ALL = 1
> >> +};
> >
> > I still do not think that this enum needs to have file scope. Function
> > scope is enough.
> 
> In the very initial patch I made it in function scope. To which you
> pointed out[1] that in all other examples but for one have file scope
> so then I thought maybe that exception was a wrong example and I
> should stick to the convention of putting it in file scope.

Oh, sorry, I meant to imply that it is good as it is by saying "so this
code is fine"...

I was just surprised because I thought I remembered that some old C
standard does not allow enums to be function scoped. But I was wrong.

> But now I also realize that builtin/replace.c uses "cmdmode" instead of
> "subcommand" so I am still wondering what would be the most appropriate?

I think the replace.c code is really a good example. Function-scoped,
using the "cmdmode" name that obviously corresponds to the OPT_CMDMODE
name.

Ciao,
Dscho
