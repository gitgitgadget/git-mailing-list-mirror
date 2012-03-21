From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [GSoC] Designing a faster index format
Date: Wed, 21 Mar 2012 17:19:15 +0100
Message-ID: <871uomq64c.fsf@thomas.inf.ethz.ch>
References: <F9D452C3-B11E-4915-A0F2-B248F92CE5DE@gmail.com>
	<CACsJy8CKqv2P2Co9MKpePfOTwe4fu-wxAYiigbYt3YHTxZ6wWQ@mail.gmail.com>
	<8D287169-1AD9-4586-BDBC-F820220328FC@gmail.com>
	<CACsJy8D2RwG-Nr5btcQj0f9=JACvH6mf7LNi=Jnb_y+j4_2u0A@mail.gmail.com>
	<871uomrubl.fsf@thomas.inf.ethz.ch>
	<8901F6B5-7396-44E1-9687-20BF95114728@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, <git@vger.kernel.org>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 17:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAOFw-0000CA-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 17:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759423Ab2CUQTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 12:19:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:49192 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759325Ab2CUQTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 12:19:18 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 17:19:14 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.208.185) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 21 Mar
 2012 17:19:15 +0100
In-Reply-To: <8901F6B5-7396-44E1-9687-20BF95114728@gmail.com> (Thomas
	Gummerer's message of "Wed, 21 Mar 2012 16:43:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.208.185]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193584>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> While reworking the index into a tree (not to mention if it's in database format), 
> the backward compatibility would be broken anyway from what I understood?
> Therefore taking Shawns thoughts into account should not be a lot more work
> and should make it also easier to implement for the .git reading programs,
> since it's easier to parse for the core it should also be easier to parse for them.
>
> Then if changing the checksum algorithm can bring some advantage I think
> it should be well worth the extra work while we break compatibility in any case.

AFAICS we are in agreement.  I was saying it's not worth breaking
compatibility for *only* the checksum change.  You are coming from the
other side: "once all the rest is done, the checksum change is easy",
which is probably true.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
