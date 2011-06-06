From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Mon,  6 Jun 2011 22:57:30 +0200
Message-ID: <cover.1307374519.git.hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 22:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgry-0005qJ-Di
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036Ab1FFU5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:57:48 -0400
Received: from darksea.de ([83.133.111.250]:38026 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750884Ab1FFU5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:57:48 -0400
Received: (qmail 6136 invoked from network); 6 Jun 2011 22:57:45 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 Jun 2011 22:57:45 +0200
X-Mailer: git-send-email 1.7.5.1.219.g4c6b2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175165>

If a submodule is used to seperate some bigger parts of a project into
an optional directory it is helpful to not clone/update them by default.

This series implements a new value 'none' for submodule.<name>.update.
If this option is set a submodule will not be updated or cloned by
default. If the user wants to work with the submodule he either needs
to explicitely configure the update option to 'checkout' or pass
--checkout as an option to the submodules. I chose this name to be
consistent with the existing --merge/--rebase options.

What do you think about this approach?

If we agree that this is the correct way to approach this use case I
would proceed to implement tests and documentation.

Cheers Heiko

Heiko Voigt (2):
  submodule: move update configuration variable further up
  add update 'none' flag to disable update of submodule by default

 git-submodule.sh |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

-- 
1.7.5.1.219.g4c6b2
