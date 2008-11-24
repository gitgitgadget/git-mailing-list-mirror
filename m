From: Peter Krefting <peter@softwolves.pp.se>
Subject: How do I delete a git submodule?
Date: Mon, 24 Nov 2008 15:44:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0811241537580.22925@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 15:45:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4cgz-0004Vp-C5
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 15:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbYKXOoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 09:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYKXOoV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 09:44:21 -0500
Received: from ds9.cixit.se ([193.15.169.228]:50144 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbYKXOoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 09:44:21 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mAOEiIY1007522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Nov 2008 15:44:18 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mAOEiHtS007517;
	Mon, 24 Nov 2008 15:44:17 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 24 Nov 2008 15:44:18 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101606>

Hi!

I am trying to remove a submodule from a project, but can't figure out
how to do it. With "modules/aldc" as a submodule:

  $ cat .gitmodules
  [submodule "modules/aldc"]
          path = modules/aldc
          url = [...cut...]
  [...more entries here...]
  $ git status
  [...cut...]
  nothing to commit (working directory clean)

Starting from a clean set-up.

  $ git submodule rm modules/aldc
  -ff17d9e0e76d01e99d26aa16b28cf327c5abb48a modules/aldc
  $ git status
  [...cut...]
  nothing to commit (working directory clean)

The obvious command didn't give any errors, but didn't do anything,
either. (I notice that there is no mention of a "git submodule rm" on
the git-submodule man page.)

  $ git rm modules/aldc
  rm 'modules/aldc'
  fatal: git rm: modules/aldc: Permission denied
  $ git status
  [...cut...]
  nothing to commit (working directory clean)

Nope, that didn't work either.

What am I missing?

  $ git --version
  git version 1.6.0.2.1172.ga5ed0

(This is Git-1.6.0.2-preview20080923 on Windows XP)

-- 
\\// Peter - http://www.softwolves.pp.se/
