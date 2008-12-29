From: jidanni@jidanni.org
Subject: Re: "git-whatever" the new style vs. "git whatever"?
Date: Tue, 30 Dec 2008 07:19:10 +0800
Message-ID: <873ag64ljl.fsf@jidanni.org>
References: <495940AD.2070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bss@iguanasuicide.net, git@vger.kernel.org, pape@smarden.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 30 00:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHRQU-0007vl-L2
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 00:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbYL2XUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYL2XUK
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 18:20:10 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:58619 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753207AbYL2XUJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 18:20:09 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id C1419D26CC;
	Mon, 29 Dec 2008 15:20:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104140>

I swear we new users would have never guessed that git-whatever was
yes the new, but _deprecated_ style, until we asked on this newslist,
and today chucked Debian sid for Debian experimental, to see the
following. OK. Good to finally know. I feel sorry for all the Debian
Sid users who haven't heard the news and are putting the soon to break
form into their scripts and newsposts. Indeed, you on the mailing list
could point out to any users that what they just posted is going to
break soon.

Wait, e.g., git commit --help, man git-commit, etc. are still full of
the old notation here now in 1.6.0...

--- News for git-core (git-core git-email gitk) ---
git-core (1:1.6.0-1) experimental; urgency=low

  Most of the programs are now installed outside the default $PATH,
  except for "git", "gitk" and some server side programs that need
  to be accessible for technical reasons.  Invoking a git subcommand
  as "git-xyzzy" from the command line has been deprecated since
  early 2006 (and officially announced in the 1.5.4 release notes);
  using the "git-xyzzy" form in scripts after adding the output from
  "git --exec-path" to the $PATH is still supported in this release,
  but users are again strongly encouraged to adjust their scripts to
  use the "git xyzzy" form, as this support might be dropped in later
  releases.

 -- Gerrit Pape <pape@smarden.org>  Sun, 24 Aug 2008 22:31:44 +0000
