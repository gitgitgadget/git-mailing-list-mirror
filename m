From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 3/4] Added test for RefUpdate branch deletion
Date: Fri, 22 Aug 2008 16:31:49 -0700
Message-ID: <20080822233149.GR3483@spearce.org>
References: <1219445147-6801-1-git-send-email-charleso@charleso.org> <1219445147-6801-3-git-send-email-charleso@charleso.org> <1219445147-6801-4-git-send-email-charleso@charleso.org> <200808230128.19035.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Charles O'Farrell <charleso@charleso.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWg7h-0004BO-O0
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYHVXbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 19:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754248AbYHVXbu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:31:50 -0400
Received: from george.spearce.org ([209.20.77.23]:46978 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYHVXbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:31:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 55A7038375; Fri, 22 Aug 2008 23:31:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808230128.19035.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93401>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> l=C3=B6rdagen den 23 augusti 2008 00.45.46 skrev Charles O'Farrell:
>=20
> Having unit tests is lovely and we appreciate that very much. We need=
 more of this.=20
> Unfortunately it breaks. Is the fix the obvious one?
>=20
> > +	public void testDeleteHead() throws IOException {
> > +		final RefUpdate ref =3D updateRef(Constants.HEAD);
> > +		delete(ref, Result.NOT_ATTEMPTED, true, false);
>=20
> junit.framework.AssertionFailedError: expected:<NOT_ATTEMPTED> but wa=
s:<REJECTED_CURRENT_BRANCH>

Yes.  See my reply.  Its already on repo.or.cz with the necessary
squashed patch.

--=20
Shawn.
