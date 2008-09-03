From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Move pathOf to RepositoryTestCase and use it
	for locating test files
Date: Wed, 3 Sep 2008 10:09:04 -0700
Message-ID: <20080903170904.GB28315@spearce.org>
References: <20080903091022.GC23406@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>,
	Imran M Yousuf <imyousuf@smartitengineering.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 19:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kavrw-0003hu-W3
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYICRJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 13:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYICRJG
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 13:09:06 -0400
Received: from george.spearce.org ([209.20.77.23]:41404 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbYICRJF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 13:09:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 54D9038375; Wed,  3 Sep 2008 17:09:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080903091022.GC23406@diku.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94817>

Jonas Fonseca <fonseca@diku.dk> wrote:
>  This is a workaround patch disguised as a cleanup patch. For NetBeans I
>  am not yet sure how to setup JGit as a project where everythng works.
>  For now I need to be able to override the path to files used by the
>  tests and this patch reduces that change to one single place.

I wonder if we shouldn't just prod Imran to finish the Maven stuff.
He has some patches in there that are specifically for this same
issue under Maven.

  http://repo.or.cz/w/egit/imyousuf.git?a=shortlog;h=refs/heads/mavenize-jgit
 
-- 
Shawn.
