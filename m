From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 23:04:14 +0200
Message-ID: <20100113210414.GA8535@Knoppix>
References: <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
 <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
 <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
 <20100113191802.GA8110@Knoppix>
 <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
 <20100113200629.GA8383@Knoppix>
 <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 22:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVAO9-0000N8-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 22:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0AMVEV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126Ab0AMVEV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 16:04:21 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57325 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab0AMVEU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 16:04:20 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 48A4B8C731;
	Wed, 13 Jan 2010 23:04:19 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0651635472; Wed, 13 Jan 2010 23:04:19 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 12FF9158A72;
	Wed, 13 Jan 2010 23:04:15 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001131213m75b4baefsc70a4cbf3c8431c8@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136886>

On Wed, Jan 13, 2010 at 03:13:40PM -0500, Avery Pennarun wrote:
> On Wed, Jan 13, 2010 at 3:06 PM, Ilari Liusvaara
>=20
> Lots of people use it.  That was my point.  If it weren't important,
> web browser makers wouldn't bother putting it in; God knows they leav=
e
> out a lot of other stuff that I'd like.

There are two kinds of "important". Actually important for users and
important for managers.
=20
The latter tends to be implemented with much less real world need. And
one can usually tell which of those it was from usability of feature.

> >> Furthermore, how many people who really want ssh-style keypairs (a=
nd
> >> thus refuse to use X.509 and PKI) can't just use ssh as their git
> >> transport? =C2=A0I don't actually understand what the goal is here=
=2E
> >
> > As said, I got fed up with failure modes of SSH.
>=20
> I think this is the answer that needs clarification.  What failure
> modes are these?  ssh doesn't seem to fail for me.  And github.com
> seems to be working rather well with a huge number of users and ssh
> authentication.

Those failure modes tend to be show up at setup phase. But when they
show up, at worst I have seen ones that took hours to debug because
of multitude of possible causes and no good information on what's
wrong.

And don't get me started about multi-key setups.

SSH uses fixed sets of keys, which has inherent failure modes. And ssh
server tends to be worse than the client (Github can avoid the server
failure modes since they control the SSH server).

But not even github can avoid all the failure modes.

> If you're upset at the failure modes of ssh, is it possible to fix ss=
h
> instead of introducing Yet Another Tunneling Protocol?

No, those failure modes can't be solved in SSH.

-Ilari
