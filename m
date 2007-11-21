From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 0/3] Implement git-svn: info
Date: Wed, 21 Nov 2007 01:20:28 -0800
Message-ID: <20071121092028.GC23266@soma>
References: <1195627399-25209-1-git-send-email-ddkilzer@kilzer.net> <220901.13065.qm@web52408.mail.re2.yahoo.com> <20071121091809.GB23266@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 10:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IullJ-00011a-D0
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 10:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbXKUJUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 04:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbXKUJUb
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 04:20:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:36421 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbXKUJU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 04:20:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id D70B37DC0FE;
	Wed, 21 Nov 2007 01:20:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071121091809.GB23266@soma>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65623>

Eric Wong <normalperson@yhbt.net> wrote:
> "David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> > "David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> > > Eric Wong <normalperson@yhbt.net> wrote:
> > > > Can we expect the output of "svn info" to not change between
> > > > versions?  I know "svn status" has changed between versions of
> > > > svn.  I'd prefer if we keep the expected.* files hard-coded
> > > > in a test directory and compare those instead.  Maybe use sed
> > > > to substitute placeholders for timestamps..
> > > Done.
> > 
> > Grrr.  I remember the reason I didn't do this in the first place.  In Patch
> > 2/3, there are now hard-coded directory paths and my username in the static
> > expected-* files.
> > 
> > That means that either I need to replace the "URL:", "Repository Root:" and
> > "Last Changed Author:" fields with place-holders (weakening the effectiveness
> > of the tests), or switch back to more dynamic tests.
> > 
> > Thoughts?
> 
> Ah, good point.
> 
> On some of my tests (t9110, t9111, t9115), I get around this by
> generating a repository once and dumping it using `svnadmin dump'.

Wait, the paths/URLs will still be inconsistent, but author will at
least be correct...

Sorry, I need sleep :/

-- 
Eric Wong
