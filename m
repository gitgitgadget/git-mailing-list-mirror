From: Francis Irving <francis@scraperwiki.com>
Subject: Documentation for "git log --all" incorrect
Date: Wed, 29 Oct 2014 11:51:34 +0000
Message-ID: <20141029115134.GA33348@bat.dot-bit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 13:24:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjSIb-0004ew-Om
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 13:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbaJ2MYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 08:24:19 -0400
Received: from balrog.mythic-beasts.com ([93.93.130.6]:43439 "EHLO
	balrog.mythic-beasts.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932585AbaJ2MYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 08:24:18 -0400
X-Greylist: delayed 1959 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2014 08:24:18 EDT
Received: from [93.93.130.49] (port=44088 helo=sphinx.mythic-beasts.com)
	by balrog.mythic-beasts.com with esmtp (Exim 4.80)
	(envelope-from <francis@scraperwiki.com>)
	id 1XjRmr-0000zN-Ly
	for git@vger.kernel.org; Wed, 29 Oct 2014 11:51:37 +0000
Received: from secure.pacec.co.uk ([93.93.130.55]:47385 helo=bat.localdomain)
	by sphinx.mythic-beasts.com with esmtp (Exim 4.72)
	(envelope-from <francis@scraperwiki.com>)
	id 1XjRmq-0008VY-21
	for git@vger.kernel.org; Wed, 29 Oct 2014 11:51:37 +0000
Received: by bat.localdomain (Postfix, from userid 502)
	id 2040552AF39C; Wed, 29 Oct 2014 11:51:35 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Mythic-Sender-Verify: + host 64.233.166.27 accepted RCPT TO with '250 2.1.5 OK fd5si6216464wib.95 - gsmtp'
X-Spam-Status: No, score=-1.2
X-BlackCat-Spam-Score: -11
Received-SPF: softfail (secure.pacec.co.uk: transitioning domain of francis@scraperwiki.com does not designate 93.93.130.55 as permitted sender) client-ip=93.93.130.55 envelope-from=francis@scraperwiki.com helo=bat.localdomain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The help for "git log --all" says:

       --all
                  Pretend as if all the refs in refs/ are listed on
                  the command line as <commit>.

This makes no sense, as <commit> is not a documented valid command line
parameter. These are the documented parameters:

        SYNOPSIS
               git log [<options>] [<revision range>] [[--] <path>...]

Even if it means <revision range>, which is my best guess, it still
makes no sense as <revision range> cannot be a list of many refs.

I suspect both the documentation for "--all" and the documentation for
the basic options are either incorrect, or confusing by using multiple
names for the same thing.

I'm using git 1.9.2

Francis
