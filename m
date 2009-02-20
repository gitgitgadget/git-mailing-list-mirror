From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Fri, 20 Feb 2009 12:32:15 -0800
Message-ID: <20090220203215.GD22848@spearce.org>
References: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com> <20090218163002.GB22848@spearce.org> <320075ff0902200127m3e516621m60a608bc891ab992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 21:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lac48-0004Wv-Tn
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 21:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbZBTUcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 15:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbZBTUcR
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 15:32:17 -0500
Received: from george.spearce.org ([209.20.77.23]:45852 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbZBTUcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 15:32:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E0488381FF; Fri, 20 Feb 2009 20:32:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <320075ff0902200127m3e516621m60a608bc891ab992@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110887>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> On Wed, Feb 18, 2009 at 4:30 PM, Shawn O. Pearce <spearce@spearce.org>wrote:
> 
> > Nigel Magnay <nigel.magnay@gmail.com> wrote:
> > > +public class ObjectId extends AnyObjectId implements Serializable {
> >
> > We should define our own serialVersionUID:
> >
> >  private static final long serialVersionUID = 1L;
> >
> > is good enough to make Java happy.
> >
> 
> I'll re-roll. Actually both that and the whitespace damage I'm partially
> blaming on eclipse. Eclipse curiously removes the warning to declare
> serialVersionUID if you declare both writeObject and readObject - that's
> wrong!

Yikes.  What a nice feature.
 
> Also the formatting came from .settings/org.eclipse.core.resources.prefs
> which has a tab policy of "Tabs only" which has overridden my environment
> setting of spaces-only.
>
> I can modify it to spaces only - but the comment in 9268ced9d38 talks about
> spaces-per-tab..?

Oh, yea, my bad.

We prefer tabs, and only tabs, and we only indent the leading part of
the line, we never try to "line up" columns of variables (for example).

I guess there was a mixture here.  Not sure why.  Sometimes I've
seen Eclipse not immediately honor the per-project settings files.
Closing or deleting and re-importing the project usually fixes it,
but not always.  :-|

-- 
Shawn.
