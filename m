From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git archive should use vendor extension in pax header
Date: Thu, 28 Jan 2016 09:13:03 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601280906340.2964@virtualbox>
References: <20160124155909.GA16847@fuz.su> <56A7EDE1.1020909@web.de> <20160127114634.GA1976@fuz.su> <56A92913.3030909@web.de> <20160127234512.GA5453@fuz.su>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-863531931-1453968785=:2964"
Cc: git@vger.kernel.org
To: fuz@fuz.su
X-From: git-owner@vger.kernel.org Thu Jan 28 09:13:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOhhZ-0004b5-3X
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 09:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934855AbcA1INJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 03:13:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:63369 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934118AbcA1ING (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 03:13:06 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LguAU-1ZmfSh0RYE-00oC2W; Thu, 28 Jan 2016 09:13:05
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160127234512.GA5453@fuz.su>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zED2zkniaZv70nyX62D5CRAbQy7dASlGqJ3Hkx720SbvdYY4PXj
 aNME8mifuXRpowfH79H9HiNwXLxBzDqHFyYvTn1arZjxJF0fg8dKMLBWj5DRCpoVTPo4TYL
 rBDDEQaAwMj2BGU7yIbmHc9pqHwmhxHfsKJmJNpsaYpJYzrcCR0oPPUUXfVxlF0BJs3EGrR
 JnH0jHbo7I2i01/yQIC8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W9p5GQZyZ8o=:qhNLf2z6ojCWHWPbSZVpjn
 +bFNxWABKZDeoYbQe3jH/BCJ1tap5BKzyviVGbuCX6Kbn7Qmmvn3Yi64eV39RcP1BR2V4+MVM
 FG/uP5AVs3ZoBc6gC5k//Sn0Tu4j1u5ynKrKJLRQLwnlI0PJQxxR6WM53bUj2paWA+WHLU+ha
 55vfmOP+sIycaNUm6SOa2uR9u2pmD0qDb6XbyveKvkTvBWi3F6WglfsM2saSybzYQZUg1GDxx
 a2Z7f3yjDAv/VZCiByEX4huNps4D3HQ3/I3ShzNamoWsfRtFcpdWVYKSHwANQTbIhwYYO2wNC
 JAcPeokqoTOHDJy8HSwWCpggKzGoCQGewZoNTfHuZhrnpPS9+eHSmT7I+gYLRh8U6d8NqZQJq
 NmqhGUnqlydEpMkVpiIdLCwAYLUm5a+1fkAFyeQ+/UKLu7odsowsjD0lwC26ExRF5Ispwll/K
 OjtWSkR5QGy4pjoBd9TPi7VVu4FfzTv3phZ8wCkMwPBQzzn9WSBGoBdmQEGU8ujyb+qREHVPE
 45fjS9gORuXbetgQFPxfJCIE3hOmYaiQ1shwqNlnumvCtdnTNu7lR7s1Q3o86qoy6KwD+l1Cx
 V6Ev45AKu2Brttx929GIqWZRy1hJp20iOGKJOns40lqIF5NstHy4Kz8uMVRGwDNaDypQ/yM/B
 10gwpbAGWB9teeC0D25Ob37Vff11HXJUdbIdYKiyDDbDWW3FiZMHUA1nH++QXAUpAthaxjXAa
 kChT5TEqhEsVEziGjc56vTWFD+Wy5HSIyi0K1hUXuNFtgmcO3GlgcQEqG+DXiIMScQWxIRMo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284984>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-863531931-1453968785=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Robert,

[I am not going to re-Cc: the dropped email addresses; please note that it
is pretty much frowned upon on this mailing list if you do not
reply-to-all and might affect your conversation.]

On Thu, 28 Jan 2016, fuz@fuz.su wrote:

> On Wed, Jan 27, 2016 at 09:31:15PM +0100, Ren=C3=A9 Scharfe wrote:
>
> > Users can always go back to the original format.  At least I don't
> > expect this new format becoming the default too quickly.

This is the most crucial issue here, as far as I am concerned: there are
already tons of .zip files out there that were created by git archive, and
there will inevitably be loads of tons more *having the current pax header
format*.

So tools wanting to deal with Git archives will have to handle those as
well, i.e. do *precisely* as Ren=C3=A9 suggested and use get-tar-commit-id.=
 As
such, the value of changing the format *now* is a bit like closing the
barn's door after pretty much all of the horses left (except the old one
that has a few troubles getting up in the morning but that is too nice to
the kids to shoot).

> Sure thing.  If this is going to be implemented, I would add options
> to choose what / what style of metadata to include.

Why not put your money where your mouth is? I.e. get your head down into
the code and come up with a patch (because otherwise it is unlikely that
your idea will go anywhere)?

Ciao,
Johannes
--8323329-863531931-1453968785=:2964--
