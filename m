From: Stepan Kasal <kasal@ucw.cz>
Subject: git gui clone bug
Date: Wed, 11 Dec 2013 18:26:57 +0100
Organization: <)><
Message-ID: <20131211172657.GA15272@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 18:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqnZ7-0004Y2-NO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 18:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab3LKR1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 12:27:01 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:54291 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3LKR1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 12:27:00 -0500
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 558421C00AD
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 18:26:58 +0100 (CET)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id rBBHQwIW015282
	for <git@vger.kernel.org>; Wed, 11 Dec 2013 18:26:58 +0100
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id rBBHQvtY015281
	for git@vger.kernel.org; Wed, 11 Dec 2013 18:26:57 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239208>

Hello,
I tried to use git gui in an empty dir (via Git Cheetah).

I selected to clone from a file:///Y:/subdir/foo.git

The result differed from the usual "git clone URL", as the newly
created "master" branch was not set to track origin/master.
"git pull" failed.

When I start by "git clone", I can immediately proceed with "git
pull"

The difference can be checked in .git/config, in section
branch.master.

Have a nice day,
	Stepan Kasal
