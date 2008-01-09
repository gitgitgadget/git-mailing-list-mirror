From: Jan Hudec <bulb@ucw.cz>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 9 Jan 2008 19:46:30 +0100
Message-ID: <20080109184630.GB20892@efreet.light.src>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <200801071947.28586.robin.rosenberg.lists@dewire.com> <alpine.LSU.1.00.0801071915470.10101@racer.site> <200801072203.23938.robin.rosenberg.lists@dewire.com> <20080107224204.55539c31@jaiman> <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Jan 09 19:47:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCfxJ-0006lt-6m
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 19:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYAISqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 13:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYAISqn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 13:46:43 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:38660 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbYAISqn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 13:46:43 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D9DAA57432;
	Wed,  9 Jan 2008 19:46:41 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id ItFM6mIkB6ot; Wed,  9 Jan 2008 19:46:38 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 4E191574A6;
	Wed,  9 Jan 2008 19:46:38 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JCfwc-00036l-9w; Wed, 09 Jan 2008 19:46:30 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801081150010.25629@ds9.cixit.se>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70003>

On Tue, Jan 08, 2008 at 11:56:00 +0100, Peter Karlsson wrote:
> Thomas Neumann:
> 
> > as a user, I expect a SCM to only modify a file when I have
> > explicitly asked it to do so.
> 
> As a user, I exepect things to just work. With RCS/CVS/Subversion, it
> does, because it differentiates between text files (internally encoding
> NLs with "LF", but I couldn't care less what it uses there) and binary
> files (which it doesn't change). With git it currently doesn't since it
> treats everything as binary files.

With subversion you must explicitely enable it to "just" work. Subversion
auto-tags files with specified extensions, when they are added, with
svn:eol property specifying how the file should be converted and than
converts (everywhere) the files to specified line endings. However, AFAIK, it
does not convert anything unless the properties are set and the default
config has the automatic setting *commented out*.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
