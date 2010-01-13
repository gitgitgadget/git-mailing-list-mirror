From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 22:06:29 +0200
Message-ID: <20100113200629.GA8383@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
 <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
 <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
 <20100113191802.GA8110@Knoppix>
 <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:06:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9UI-0003Nb-9q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755462Ab0AMUGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087Ab0AMUGg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:06:36 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:56263 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab0AMUGf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:06:35 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 5904A8C114;
	Wed, 13 Jan 2010 22:06:34 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A030CB3EE54; Wed, 13 Jan 2010 22:06:34 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 19F2D4061;
	Wed, 13 Jan 2010 22:06:29 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001131130i6afae1a1xd3a70e5de5daa5cf@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136871>

On Wed, Jan 13, 2010 at 02:30:20PM -0500, Avery Pennarun wrote:
> On Wed, Jan 13, 2010 at 2:18 PM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> 
> I think you're overstating the situation a bit here.  You can use
> X.509 certificates without setting up a full PKI.  Basically, an X.509
> cert is just a public key with some extra crud thrown into the data
> file.  You could validate it using a PKI, but you could also validate
> it by checking the verbatim public key just like ssh does.  It's not
> elegant, but it works, and it's a worldwide standard.

Grossly overcomplicated standard... ASN.1? And there are other usable
standards that can be used with TLS.

> (I don't know if stunnel does this type of validation... but *I've*
> done this with the openssl libraries, so I know it can be done.)

AFAIK, it doesn't.
 
> > And how many (relative) use client ceritificates with SSL? Keypairs with SSH?
> > Why you think this is?
> 
> At least hundreds of thousands of people, including non-technical
> people, use X.509 client certificates and SSL in various big
> industries with high security requirements. 

That is: Epsilon.

> That's why every major web browser supports them.

Supports != is actually usable.

> In contrast, ssh is only ever used by
> techies, and there are fewer of those.  Of course, as techies our
> informal observations might lead us to believe otherwise.

Most of those that use git are techies anyway.

> Furthermore, how many people who really want ssh-style keypairs (and
> thus refuse to use X.509 and PKI) can't just use ssh as their git
> transport?  I don't actually understand what the goal is here.

As said, I got fed up with failure modes of SSH.

-Ilari
