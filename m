From: Thomas Koch <thomas@koch.ro>
Subject: git ignore logic does not work as advertised
Date: Sat, 15 Jun 2013 18:18:46 +0200
Message-ID: <1766682.Es1SNxTkk2@x121e>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 15 18:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnteZ-0007gO-45
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 18:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab3FOQsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 12:48:23 -0400
Received: from koch.ro ([88.198.2.104]:47402 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab3FOQsW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 12:48:22 -0400
X-Greylist: delayed 1771 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Jun 2013 12:48:22 EDT
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1UntBf-0005NJ-Ks
	for git@vger.kernel.org; Sat, 15 Jun 2013 18:18:47 +0200
User-Agent: KMail/4.10.2 (Linux/3.9-1-amd64; KDE/4.10.2; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227960>

Hi,

I'm using vcsh[1] to have my dotfiles in GIT. With that I use a .gitignore file 
referenced by core.excludesfile that looks like this:

# ignore everything by default
*

# but do not ignore emacs stuff
!.emacs.d/

# but than again please ignore backup files inside the .emacs.d folder
.emacs.d/backups

Now I'd expect git status to show everything in .emacs.d but not to show 
.emacs.d/backups. However the .emacs.d/backups folder is still shown in git 
status. I'd say that this is not in line with the man page and might be 
considered a bug.

[1] https://github.com/RichiH/vcsh

Thank you,

Thomas Koch, http://www.koch.ro
