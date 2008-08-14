From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 10/11] Add a TreeWalk iterator implementation for
	IContainer
Date: Wed, 13 Aug 2008 21:19:41 -0700
Message-ID: <20080814041941.GA11232@spearce.org>
References: <1218357986-19671-1-git-send-email-spearce@spearce.org> <1218357986-19671-10-git-send-email-spearce@spearce.org> <1218357986-19671-11-git-send-email-spearce@spearce.org> <200808132241.45402.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 06:20:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTUKM-0003jx-OS
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 06:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYHNETm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 00:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbYHNETm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 00:19:42 -0400
Received: from george.spearce.org ([209.20.77.23]:56497 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYHNETm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 00:19:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A0E3438375; Thu, 14 Aug 2008 04:19:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808132241.45402.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92311>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> s=C3=B6ndagen den 10 augusti 2008 10.46.25 skrev Shawn O. Pearce:
> > diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/Contai=
nerTreeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/=
ContainerTreeIterator.java
> > new file mode 100644
> > index 0000000..17b8414
> > --- /dev/null
> > +++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTree=
Iterator.java
> ...
> > +	@Override
> > +	protected Entry[] getEntries() throws IOException {
> > +		final IResource[] all;
> > +		try {
> > +			all =3D node.members(IContainer.INCLUDE_HIDDEN);
>=20
> INCLUDE_HIDDEN is a 3.4 flag.

Oh.  Can you amend that to be 0?

I'd rather not rebuild my entire branch space just for this one minor
change so I can resend the patch.  I've got far too many large open
branches as it is, with everything depending on everything else.  :-|

--=20
Shawn.
