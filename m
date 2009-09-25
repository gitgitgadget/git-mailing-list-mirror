From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: gitolite update
Date: Fri, 25 Sep 2009 15:49:44 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnhbppko.tl3.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 25 17:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrD3o-00060q-IE
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 17:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbZIYPuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 11:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753079AbZIYPuF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 11:50:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:56241 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZIYPuE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 11:50:04 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MrD3e-0005xG-8U
	for git@vger.kernel.org; Fri, 25 Sep 2009 17:50:06 +0200
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 17:50:06 +0200
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 17:50:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129095>

This is an update on gitolite, the "lite" rewrite of gitosis (in
perl) for a typical "corporate" environment, after a month of
moderately heavy use at my workplace and quite a lot of updates
and improvements (thanks to a lot of people on the list and on
IRC, and colleagues at work).  The latest version is at
git://github.com/sitaramc/gitolite.git -- I recommend the
"master" branch for most people.

My original reasons were per-branch permissions, limiting
rewind/non-ff to specific people, and to install on any Unix
with no dependencies and no root access, assuming git itself was
already installed somehow.

Over the past month it acquired some more features/improvements.
There's also oodles of documentation -- this is not one of those
"figure it out yourself" systems :-)

Summary
=======

  * simpler, but far more powerful, config file syntax,
    including specifying gitweb/daemon access.  You'll need this
    power if you manage lots of users + repos + combinations of
    access
  * more comprehensive logging
  * "personal namespace" prefix for each dev
  * migration guide and simple converter for gitosis conf file
  * "exclude" (or "deny" rights in the config file) -- this is
    the "rebel" branch in the repository, and always will be ;-)

All these points (and more) are explained in detail at
http://github.com/sitaramc/gitolite/blob/ml/update.mkd (I wasn't
sure if it was OK to post all that to the list; it was a bit
long).

Anyway, if you're looking for features like this, give it a
whirl -- I'd appreciate comments from users or even just people
who read that page and have some thing to say.  And needless to
say I'll gladly help anyone having trouble; preferably on #git
but the mailing list or personal email are fine too.

-- 
Sitaram

sitaramc@gmail.com / sitaram.chamarty@tcs.com
