From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 5 Feb 2009 08:06:25 -0800
Message-ID: <20090205160625.GI26880@spearce.org>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?Q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV6m6-0000Iw-Br
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758919AbZBEQG2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758899AbZBEQG1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:06:27 -0500
Received: from george.spearce.org ([209.20.77.23]:54257 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758892AbZBEQG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:06:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CDCFC38210; Thu,  5 Feb 2009 16:06:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108574>

Tor Arne Vestb=F8 <torarnv@gmail.com> wrote:
> This series adds support for customizable label decorations, which
> is usefull for hiding selected decorations, or tweaking the format
> of the decoration text.

Aside from my two remarks about the synchronized collections,
I like it.  There's no display for "added and dirty", aka doing:

  echo a >a; # create a
  git add a
  echo b >>a; # append a and dirty it

This still shows as just "added".  It should be "added and dirty",
as its partially staged.
=20
> Known issues are:
>=20
>   - If a project has a repository more than one level above the
>     project directory decorations will fail.

I'd like to see this fixed in the near-ish future, but I don't
think its blocking to merging your patches.
=20
>   - When a Java resource is dirty, each parent package in the
>     package hierarcy will appear dirty, even when the layout is
>     set to 'flat'.

Bah.  I've seen the Java compiler error marks also report like this.
I don't think its our issue.  But maybe I'm wrong.

--=20
Shawn.
