From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Thu, 16 Dec 2010 13:42:35 +0100
Message-ID: <20101216124235.GA32636@neumann>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<20101215130046.GB25647@sigill.intra.peff.net>
	<alpine.DEB.1.10.1012151931030.25560@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 16 13:42:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTDAU-0007os-Tq
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 13:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab0LPMmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 07:42:39 -0500
Received: from judith.fzi.de ([141.21.4.44]:56695 "EHLO judith.fzi.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab0LPMmj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 07:42:39 -0500
Received: from exchange.fzi.de ([141.21.7.5]) by judith.fzi.de with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 16 Dec 2010 13:42:36 +0100
Received: from localhost6.localdomain6 ([141.21.7.126]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 16 Dec 2010 13:42:35 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1012151931030.25560@debian>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 16 Dec 2010 12:42:35.0897 (UTC) FILETIME=[B73C8E90:01CB9D1E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163806>

Hi,


On Wed, Dec 15, 2010 at 08:44:45PM +0100, Martin von Zweigbergk wrote:
> On Wed, 15 Dec 2010, Jeff King wrote:
> > As an aside, I would think "--unset" should actually choose from th=
e set
> > of configured variables for completion (i.e., "git config --list | =
cut
> > -d=3D -f1"). But that would obviously be a separate patch.
>=20
> Good point. I'll put it on my todo.

It already works that way since 0065236 (bash completion: complete
variable names for "git config" with options, 2009-05-08).


Best,
G=E1bor
