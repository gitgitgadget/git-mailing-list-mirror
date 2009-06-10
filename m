From: Yann Dirson <ydirson@altern.org>
Subject: Re: git-svn: importing internal externals
Date: Wed, 10 Jun 2009 23:58:55 +0200
Message-ID: <20090610215854.GA5741@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1243443089.3192.43.camel@cp-jk-linux.corp.on2.com> <20090528112542.GA24403@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Koleszar <john.koleszar@on2.com>
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVot-0004dp-1y
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbZFJV6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbZFJV6n
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:58:43 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:54133 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbZFJV6m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:58:42 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 9C94A2C906
	for <git@vger.kernel.org>; Wed, 10 Jun 2009 23:58:40 +0200 (CEST)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 280FF8180F5;
	Wed, 10 Jun 2009 23:57:36 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3FA50818040;
	Wed, 10 Jun 2009 23:57:34 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 85FE01F095; Wed, 10 Jun 2009 23:58:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090528112542.GA24403@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121310>

On Thu, May 28, 2009 at 01:25:43PM +0200, Yann Dirson wrote:
> On Wed, May 27, 2009 at 12:51:29PM -0400, John Koleszar wrote:
> > Hi,
> > 
> > I'm working on a one-off import of an SVN repo that makes use of
> > "internal" svn:externals; i.e. all URLs refer to different spots in the
> > same repo, potentially with peg revisions. The SVN repo holds a number
> > of projects, and my plan is to import them into individual git repos,
> > incorporating the history from any svn:external linked sub-projects.
> 
> I have started to work on exactly this, at fetch time instead of as a
> post-process.  I have for now only hooked parsing of the svn:externals
> properties, and just need to find the time to resume and finish.
> 
> My plan on the user side is to provide flags to map svn urls to git urls.

Just a quick note to make it public that my WIP on this issue is
available from the t/svn-externals branch at
http://repo.or.cz/w/git/ydirson.git.  Progressing slowly (as time
permits with a 3-children family and a real-life job ;), but still
progressing.

This is targetted at incremental conversion - if one looks for
one-shot imports, John's script is today the way to go.

Best regards,
-- 
Yann
