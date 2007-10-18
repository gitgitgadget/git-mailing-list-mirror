From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/6] more compact progress display
Date: Thu, 18 Oct 2007 00:58:07 -0400
Message-ID: <20071018045807.GC14735@spearce.org>
References: <1192586150-13743-1-git-send-email-nico@cam.org> <1192586150-13743-2-git-send-email-nico@cam.org> <20071017021137.GO13801@spearce.org> <20071017082003.GA10799@diana.vm.bytemark.co.uk> <alpine.LFD.0.9999.0710171653500.19446@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiNSk-00010u-8u
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbXJRE6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 00:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbXJRE6P
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:58:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50718 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbXJRE6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 00:58:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiNSP-0005Vn-Ui; Thu, 18 Oct 2007 00:58:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EAFE620FBAE; Thu, 18 Oct 2007 00:58:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0710171653500.19446@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61472>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 17 Oct 2007, Karl Hasselstr=C3=B6m wrote:
> > On 2007-10-16 22:11:37 -0400, Shawn O. Pearce wrote:
> > > Nicolas Pitre <nico@cam.org> wrote:
> > >
> > > > Each progress can be on a single line instead of two.
> > >
> > > Nice. Of course that screws with git-gui and now I have to match =
two
> > > regexs and not one. But whatever.
> >=20
> > Maybe an env variable could cause the code to emit machine-friendly
> > progress information instead?
>=20
> That won't help with remotely generated progress unaware of local env=
=20
> variable, and the remote server might still be generating old format.

Agreed.  I've already merged Nico's change into my next branch.
I'll update git-gui soon to understand both formats, and that's that.

--=20
Shawn.
