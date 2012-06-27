From: Chris Webb <chris@arachsys.com>
Subject: A handful of help-related patches
Date: Wed, 27 Jun 2012 21:54:59 +0100
Message-ID: <20120627205459.GC11498@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 22:55:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjzGY-0002PA-PB
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741Ab2F0UzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:55:03 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:43608 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab2F0UzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:55:02 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SjzGO-0001op-A9
	for git@vger.kernel.org; Wed, 27 Jun 2012 21:55:01 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200747>

Whilst looking at git-rebase, I noticed I have a few local git --help
related patches from a couple of years ago that I use on my own systems.

I'm not sure whether they're just personal quirks, but I thought I should
post them to the list in case they're of wider interest or might be relevant
upstream.

The first two patches allow the HTML path used by git-help --web to be set
in .gitconfig, and allow it to be a URL prefix, so you can do

  [help]
    format = html
    htmlpath = http://git-scm.com/docs

git wibble --help will then open http://git-scm.com/docs/git-wibble.html
instead of /share/doc/git/html/git-wibble.html in your browser.

The third patch adds a help format called 'usage' making git wibble --help
equivalent to git wibble -h, i.e. printing short command-line usage
information. (Generally that's what I want and I end up rather surprised
when I get an unwanted man page because my fingers are trained to type the
more universal --help rather than -h.)

This 'usage' help format is also good for making --help do something useful
other than produce an error message on our cut-down servers without man
pages, web browsers and so on.

Best wishes,

Chris.
