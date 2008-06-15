From: Mirko Stocker <me@misto.ch>
Subject: Re: Working with Git and CVS in a team.
Date: Sun, 15 Jun 2008 22:20:05 +0200
Message-ID: <200806152220.05290.me@misto.ch>
References: <200806131633.34980.mirko.stocker@hsr.ch> <200806132243.36695.m1stocke@hsr.ch> <20080613204740.GA29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Stocker Mirko (m1stocke@hsr.ch)" <m1stocke@hsr.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 22:25:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7ynS-0004vO-Qi
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 22:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbYFOUZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 16:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYFOUZA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 16:25:00 -0400
Received: from luc80-74-131-252.ch-meta.net ([80.74.131.252]:56179 "EHLO
	lucius.metanet.ch" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751959AbYFOUZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 16:25:00 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jun 2008 16:24:59 EDT
Received: (qmail 10458 invoked from network); 15 Jun 2008 22:17:36 +0200
Received: from 84-72-93-108.dclient.hispeed.ch (HELO ?192.168.1.127?) (84.72.93.108)
  by luc80-74-131-153.ch-meta.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Jun 2008 22:17:36 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080613204740.GA29404@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85114>

On Friday 13 June 2008 22:47:40 Miklos Vajna wrote:
> 'origin/origin' means the 'origin' branch of the 'origin' remote. Given
> that you said you created the 'origin' remote's repo using
> git-cvsimport, I assumed that the 'origin' remote has only one branch
> (named 'master').

Hm, git-cvsimport created a master and an origin branch. And then I push the 
origin branch to the bare repository to share it with my colleagues. So for 
the users, origin/origin contains the original CVS content, so we need to 
make the diff against that, don't we? That's how I think this whole thing 
works, I might be wrong :-)
