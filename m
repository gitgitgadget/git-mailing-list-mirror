From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Merge problems with git-mingw
Date: Tue, 9 Oct 2007 09:56:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710090953240.26773@ds9.cixit.se>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se> 
 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com> 
 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se> 
 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com> 
 <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
 <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
 <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se> <470B2F7E.4080308@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 10:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfAtB-0001vW-MO
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 10:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbXJII4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 04:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbXJII4U
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 04:56:20 -0400
Received: from ds9.cixit.se ([193.15.169.228]:57393 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbXJII4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 04:56:19 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l998uHnQ007645
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Oct 2007 10:56:17 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l998uHtY007640;
	Tue, 9 Oct 2007 10:56:17 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <470B2F7E.4080308@viscovery.net>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 09 Oct 2007 10:56:17 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60370>

Hi!

> What if you run 'git var -l' outside a repository? From CMD?
> Have you tried 'git-var -l' (note the dash)? From CMD?

C:\Program Files\Git\bin>git var -l
usage: git-var [-l | <variable>]

C:\Program Files\Git\bin>git-var -l
fatal: Not a git repository

C:\Program Files\Git\bin>git --version
git version 1.5.3.mingw.1

> Are you sure you have only one version of git in the PATH?

Yes.

> What's in your .git/config?

This is the .git/config file for one of the repositories where it
fails:

  [core]
        repositoryformatversion = 0
        filemode = false
        bare = false
        logallrefupdates = true
        symlinks = false
        pager = less -x3 -r

  [instaweb]
        local = true
        httpd = c:/cygwin/usr/sbin/lighttpd.exe -f
        port = 4321
        browser = c:/progra~1/opera/opera.exe
        modulepath = c:/cygwin/usr/lib/apache
  [diff]
        renames = copies
        external = C:/Program Files/tkdiff/tkdiff.exe
  [user]
        name = Peter Karlsson
        email = peter.karlsson@tandbergdata.com

This is my global $HOME/.gitconfig:

  [user]
  name = Peter Karlsson
  email = peter@softwolves.pp.se
  [core]
          editor = c:/cygwin/bin/joe.exe
          pager = less -x3 -r
  [color]
  [color]
          pager = true

-- 
\\// Peter - http://www.softwolves.pp.se/
