From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 10:44:25 +0100
Organization: At home
Message-ID: <fhbrll$ceq$1@ger.gmane.org>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home> <4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org> <fhbn50$uqu$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 10:45:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsKK-0002Vj-A6
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbXKMJon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXKMJon
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:44:43 -0500
Received: from main.gmane.org ([80.91.229.2]:33983 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751221AbXKMJon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:44:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrsJt-0004LV-Ps
	for git@vger.kernel.org; Tue, 13 Nov 2007 09:44:33 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 09:44:33 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 09:44:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64774>

Thomas Neumann wrote:

>> Perhaps also project description (if it exists?)

> one can specify a project description? I did not even know this. But
> yes, this would be useful, too.

It is project description for gitweb (git web interface), and I think also
for other web interfaces (cgit, wit, git-php). Or rather *repository*
description. It is in .git/description (in 'description' file in git
repository).

Unfortunately by default it contains (see: ${tempate_dir}/description)

  Unnamed repository; edit this file to name it for gitweb.

> In general I think git info should show everything to quickly understand
> what is currently checked out. The name of the current branch should
> probably be included, too.

Name of current branch, current directory, name of topdir (with '.git'
stripped if it is bare repository), perhaps oneline description of top
commit. And if branch is under StGit or Guilt (patch management interfaces)
control.

See also helper functions to set shell prompt in
contrib/completion/git-completion.bash. 

I for example have "1760:[gitweb/web!git]$ " as bash prompt:
 - 1760 is number of command in history, 
 - 'gitweb/web' is name of branch I am on,
 - 'git' is the name of repository
This migitates need got 'git-info' command.

> I use an alias with the commands proposed by Alex Riessen for now, but a
> more general command would be nice.

You can always write[*1*] git-info.sh or git-info.perl[*2*], and install it
as git-info in your git installation. And send patches here, to git mailing
list, for comments.

Footnotes:
----------
[*1*] Even if one of the most common complaints is "too many user-visible
      commands".
[*2*] Scripts are better for ptototyping. Choose your own poison: POSIX
      shell or Perl...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
