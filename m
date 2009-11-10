From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Girocco hosting infrastructure v1.0
Date: Tue, 10 Nov 2009 11:40:27 +0100
Message-ID: <20091110104027.GI17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 11:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7o9c-00038B-P8
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 11:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbZKJKk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 05:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbZKJKk0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 05:40:26 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37446 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbZKJKkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 05:40:24 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id E19CC86201A; Tue, 10 Nov 2009 11:40:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132558>

  Hello!

  I would like to announce Girocco-1.0, the first stable release of
a universal Git project hosting infrastructure. You can get it at

	http://repo.or.cz/w/girocco.git

  You guessed right, Girocco is the software repo.or.cz runs at;
however, compared to the past, it's much cleaned up, cleanly packaged
for easy re-deployment and fully configurable, thanks to sponsorship
of Novartis and Novell. (Apologies for switching repo.or.cz to it and
releasing it one year later than it should've been done.)

  Thus, you should be able to easily deploy a local Girocco instance
at your site and configure it to do only what you want. Girocco allows
both full push-based project hosting, or just mirroring and showing
existing projects (either local or remote) - i.e. you can also use it
just to collect scattered repositories of your developers and present
them all at single place. The push-based hosting offers currently two
models, chroot hosting and hooks-based permissions (for trusted
environments) - it should be easy to add other models.

  This way, Girocco might present an interesting alternative to
Gitorious for people who prefer mirroring over full project hosting,
prefer then rawer gitweb interface ;-), like the repo.or.cz simple
forking model or want to make use of the GitHub-like flexible
commit notifications mechanism.

  (If you are actually going to deploy Girocco somewhere, it's good to
tell me so that I can take it into account to e.g. provide upgrade paths
for future Girocco changes.)

  If you are used to repo.or.cz, what's new in Girocco at the user's
end?

  * Friendlier homepage.

  * Friendlier project/user management interface.

  * Friendlier mirror cloning process (you can see the progress in your
    browser).

  * Support for automatic Git mirroring of SVN repositories.

  * Support for new-commit notifications, both for push and mirror
    project modes:
	* Get a notification to specified mail address(es)
	* Get a notification by receiving a POST HTTP request with
	  GitHub-compatible JSON payload
	* Have repo.or.cz send commit notifications to the CIA
	  service [http://cia.vc/]

  * Much easier to contribute a change to Girocco if you are missing
    any feature on repo.or.cz!

  Well, have fun!

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
