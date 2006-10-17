From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:31:06 -0400
Message-ID: <20061017053106.GC21210@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de> <4534656B.7080105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 07:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZhXt-0000U7-6x
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 07:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423105AbWJQFbO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 01:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423114AbWJQFbO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 01:31:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:1920 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423105AbWJQFbN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 01:31:13 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GZhXf-0006pX-SD; Tue, 17 Oct 2006 01:31:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A7B320E42A; Tue, 17 Oct 2006 01:31:06 -0400 (EDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <4534656B.7080105@utoronto.ca>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29024>

Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> Johannes Schindelin wrote:
> > On Mon, 16 Oct 2006, Aaron Bentley wrote:
> >> You'll note we referred to that bevhavior on the page.  We don't think
> >> what Git does is the same as supporting renames.  AIUI, some Git users
> >> feel the same way.
> > 
> > Oh, we start another flamewar again?
> 
> I'd hope not.  It sounds as though you feel that supporting renames in
> the data representation is *wrong*, and therefore it should be an insult
> to you if we said that Git fully supported renames.

It would seem that the majority of folks on the Git list feel that
way, myself among them.  I don't know that we'd find it an insult
to say Git fully supports renames but I do think we have had better
results from *not* recording them and looking for them after the
fact with smart tools.

Junio's recent work with git-pickaxe (or whatever its name finally
settles out to be) is a perfect example of this.  Despite not having
"recorded renames" git-pickaxe is able to fairly accurately detect
blocks of code moving between files, of which renaming files is just
a special case.  This provides some fairly accurate blame reporting
pointing to exactly which commit/author/datetime put a given line
of code into the project.

No additional metadata required.  All existing repositories can
immediately benefit from the new tool.  Rather slick if you ask me.

-- 
Shawn.
