From: Daniel Fiser <danfis@danfis.cz>
Subject: Pitweb: new web interface in python
Date: Thu, 3 Jun 2010 11:07:29 +0200
Message-ID: <20100603090728.GA4278@hawkwind.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 03 11:15:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK6WP-0003RL-5J
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 11:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab0FCJPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 05:15:08 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:34863 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758603Ab0FCJPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 05:15:05 -0400
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2010 05:15:04 EDT
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id D4BF619F33C6
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 11:06:05 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id chAfauoR1Jy4 for <git@vger.kernel.org>;
	Thu,  3 Jun 2010 11:06:04 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 7DEC819F3410
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 11:06:04 +0200 (CEST)
Received: from localhost (ui125.felk.cvut.cz [147.32.85.125])
	(Authenticated sender: fiserdan)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 30EDDFA004
	for <git@vger.kernel.org>; Thu,  3 Jun 2010 11:06:04 +0200 (CEST)
Content-Disposition: inline
X-PGP-Key: http://www.danfis.cz/danfis.gpg
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148301>

Hi all,
I would like to introduce you new pythonic web interface for git
repositories I have written - I called it pitweb.
You can find its homepage at http://pitweb.danfis.cz and you can browse
pitweb's repository using pitweb at http://gitview.danfis.cz/pitweb.git.
Pitweb is currently prepared to run under apache + mod_python but it
shouldn't be problem to modify it to run as cgi or whatever.  How it deals
with more than one repository can be seen at http://gitview.danfis.cz where
are couple of my projects.

If you are interested feel free to download it and try it (it's licensed
under LGPL) and please let me know if you would like to modify something,
if you have any patches you want to put upstream or simply if you liked it.

Cheers,
   Dan Fiser
