From: Thomas Koch <thomas-5j3myg3OO4w@public.gmane.org>
Subject: cdgit: cd relative to git workdir root
Date: Mon, 16 Sep 2013 21:01:14 +0200
Message-ID: <201309162101.14879.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"vcs-home" <vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
X-From: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org Mon Sep 16 21:04:17 2013
Return-path: <vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
Envelope-to: gcvh-vcs-home@m.gmane.org
Received: from domine.madduck.net ([77.109.139.90])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>)
	id 1VLe5o-0006kX-Bu
	for gcvh-vcs-home@m.gmane.org; Mon, 16 Sep 2013 21:04:16 +0200
Received: from domine.madduck.net (localhost [IPv6:::1])
	by domine.madduck.net (Postfix) with ESMTP id E0D2A20C74
	for <gcvh-vcs-home@m.gmane.org>; Mon, 16 Sep 2013 21:04:13 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.97.8 at domine
Received: from koch.ro (koch.ro [88.198.2.104])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by domine.madduck.net (Postfix) with ESMTPS id 2C0A42011F
	for <vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>; Mon, 16 Sep 2013 21:01:25 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.97.8 at domine
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44]
	helo=x121eofhwr1202.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80) (envelope-from <thomas-5j3myg3OO4w@public.gmane.org>)
	id 1VLe2x-0006oj-Bz; Mon, 16 Sep 2013 21:01:19 +0200
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.2-amd64; KDE/4.8.4; x86_64; ; )
X-BeenThere: vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: Discussion list for storing ~ under VCS control
	<vcs-home.lists.madduck.net>
List-Unsubscribe: <http://lists.madduck.net/options/vcs-home>,
	<mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.madduck.net/pipermail/vcs-home>
List-Post: <mailto:vcs-home-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org>
List-Help: <mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=help>
List-Subscribe: <http://lists.madduck.net/listinfo/vcs-home>,
	<mailto:vcs-home-request-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org?subject=subscribe>
Sender: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
Errors-To: vcs-home-bounces+gcvh-vcs-home=m.gmane.org-qhrM8SXbD5JdXEZaVTQqel6hYfS7NtTn@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234840>

Hi,

I frequently have the need to cd back to the root of the current git workdir 
and created to alias for this:

git alias root = rev-parse --show-toplevel

shell alias cdgit = cd $(git root)

Maybe somebody likes this.

Now it would be cool, to have an alias to cd into a specific subdir of the git 
worktree and have zsh (or bash) auto completion for this like

git clone git://git.kernel.org/pub/scm/git/git.git
cd git/gitweb/static/js/lib (just to be somewhere deep)
cdgit con<tab>/com<tab> (becomes: cdgit contrib/completion)

Somebody with zsh/bash skills who already did this?

Regards, Thomas Koch
