From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Problems cloning on Mac OS
Date: Thu, 15 May 2008 06:22:08 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0805150618570.23917@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 15 07:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwVvn-00045J-6V
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 07:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbYEOFWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 01:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753658AbYEOFWT
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 01:22:19 -0400
Received: from ds9.cixit.se ([193.15.169.228]:36653 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753629AbYEOFWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 01:22:10 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m4F5M85e024193
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 May 2008 07:22:08 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m4F5M81h024188;
	Thu, 15 May 2008 07:22:08 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 15 May 2008 07:22:08 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82180>

Hi!

I am having problems cloning with git running on Mac OS X (installed
from macports). I am cloning from a Linux box:

$ git clone ssh://peter@server/path localpath
Initialized empty Git repository in /Users/peter/tmp/localpath/.git/
percent_expand: NULL replacement
fatal: The remote end hung up unexpectedly
fetch-pack from 'ssh://server/path' failed.

$ git --version
git version 1.5.5.1


Any ideas what is wrong? I successfully cloned from that repository to
a Windows (msysgit) install yesterday, over ssh.

Git on the Linux box I'm cloning from:
$ git --version
git version 1.5.4.2

(installed from Debian package version 1:1.5.4.2-1~bpo40+2)

-- 
\\// Peter - http://www.softwolves.pp.se/
