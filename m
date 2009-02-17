From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Gerrit Code Review 2.0.3
Date: Tue, 17 Feb 2009 07:18:38 -0800
Message-ID: <20090217151838.GI18525@spearce.org>
References: <20090217011256.GA23314@spearce.org> <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 16:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRjz-0001ee-QF
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 16:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbZBQPSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 10:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbZBQPSj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 10:18:39 -0500
Received: from george.spearce.org ([209.20.77.23]:54449 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbZBQPSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 10:18:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 83934381FF; Tue, 17 Feb 2009 15:18:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1976ea660902162311q12e11ec5g7a43ab637186985e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110398>

Frank Li <lznuaa@gmail.com> wrote:
> when I click http://review.source.android.com/open , A Gerrit file
> download by IE

Likely it is this open bug:

  http://jira.source.android.com/jira/browse/GERRIT-62

Gerrit is known to not work in Internet Explorer.  As an open source
developer, my primary desktop system runs Linux.  My portable laptops
all run Mac OS X, because its shiny.  I have no system capable of
running Internet Explorer, nor do I desire to send dollars towards
Redmond in order to obtain an OS license in order to do so.

Something is busted in the IE AJAX code used by Gerrit Code Review.
I'm guessing that instead of making the data available to the AJAX
callback, IE wants to save it as a file on disk.  No clue why.
And due to the lack of IE, I am unable to debug the problem myself.
I am waiting for someone who really cares about using IE to debug
it and contribute the patch back.

FWIW, there are open source browsers available even for Microsoft
Windows.  Firefox and Chrome come to mind...  both work, as their
underlying engines are ported to more OSes and are easier to test.
Firefox is currently better tested however.
 
> 2009/2/17 Shawn O. Pearce <spearce@spearce.org>:
> > Gerrit is a web based code review system, facilitating online code
> > reviews for projects using the Git version control system.
> > 
> >  Live Demo:  http://review.source.android.com/open

-- 
Shawn.
