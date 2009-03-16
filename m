From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 02/10] Rename the objectsUrl in the nested
	HttpObjectDB to
Date: Mon, 16 Mar 2009 14:28:31 -0700
Message-ID: <20090316212831.GU22920@spearce.org>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com> <20090316202513.GS22920@spearce.org> <200903162225.00347.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@sparce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjKOG-0001WP-9i
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760977AbZCPV2e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZCPV2d
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:28:33 -0400
Received: from george.spearce.org ([209.20.77.23]:35480 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbZCPV2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 17:28:33 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 75F903821F; Mon, 16 Mar 2009 21:28:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903162225.00347.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113386>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> m=E5ndag 16 mars 2009 21:25:13 skrev "Shawn O. Pearce" <spearce@spear=
ce.org>:
> > Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > > It is used for looking at alternate objects, so name it such
> >=20
> > No SOB?
> >=20
> > But I disagree with this name change.  Its pointing at the
> > objects directory of a repository.  It may also be used to
> > point at an alternate when opening an alternate, in which
> > case it points at the alternate's objects directory.
> >=20
> > IMHO, objectsUrl is the right name for this.
>=20
> Ok, I missed the real reason in the comment. It is name hiding. objec=
tsUrl
> is the name of another variable in the outer scope.

OK.

I still disagree with the name change.  Can we hide the outer name by
making it private?  Or come up with a better name for the inner one?

--=20
Shawn.
