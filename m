From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 11:50:51 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk>
 <Pine.LNX.4.64.0710112144380.4174@racer.site>
 <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se>
 <Pine.LNX.4.64.0710121057540.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 12:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgI74-0000ix-GX
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 12:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbXJLKuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755549AbXJLKuz
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 06:50:55 -0400
Received: from ds9.cixit.se ([193.15.169.228]:36973 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655AbXJLKuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 06:50:54 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9CAopnQ003474
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Oct 2007 12:50:51 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9CAopsQ003469;
	Fri, 12 Oct 2007 12:50:51 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0710121057540.25221@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 12 Oct 2007 12:50:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60671>

Hi!

> please do not play games with the To: header.  We have a policy here 
> (which is supposed to be good netiquette) that we keep people in the Cc: 
> list that we respond to.

Sorry, didn't mean to do anything. I try to avoid Cc'ing people that
are on the mailing list, and apparently strange things happened that
kept the mailing list only as Cc. I'll try to remember setting To:
properly.


Back on-topic:

> But don't you see?  When switching branches, this totally breaks down.

Why would it? If the file is the same on both branches, nothing would
happen (it is still the same version), and if the file is different, it
gets changed anyway, and a new keyword expansion would take place.

> No, really, IMHO it is enough to show either the commit name or the
> blob name of the file. After all, you are not interested in the date
> that this file was last committed, but in the _contents_.

Yes, but I want it on the lowest addressable unit size, i.e on the file
level (I could possibly want to have the last commit for a set of files
when I have something that get generated from several sources, but that
is rare for a regular website, unless since javascripts and stylesheets
etc. are delivered separately).

Already today when you do "git log" on a file, you get the log filtered
for only changes to that file. So the mechanisms seem already to be
there, I just need to figure out how to apply them to what I want.

> So why not go for the contents?  With CVS/SVN you only have the
> chance to do that by date or version number. With git, we have a more
> powerful way: we do it by a hash of the contents.

Yes, but the hash if of "everything". I'm not interested in
"everything" in this context, and I don't want to have a separate git
repository for each file...

> If it's not what you want, I suggest rethinking what you want ;-)
> Otherwise it is scripting time for you.  It's easy enough with git.

That's what I'm trying to figure out. I assume it would be possible to
do with some kind of hook that is run on checkout. But I can't figure
out how to do that.

-- 
\\// Peter - http://www.softwolves.pp.se/
