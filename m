From: strk <strk@keybit.net>
Subject: git-svn author file and svn2cl compatibility
Date: Wed, 22 Dec 2010 19:41:10 +0100
Message-ID: <20101222184110.GA53847@keybit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 22 19:50:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVTlA-0004Uq-Vv
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 19:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab0LVSt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 13:49:56 -0500
Received: from host147-8-static.59-217-b.business.telecomitalia.it ([217.59.8.147]:4413
	"EHLO freek.keybit.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab0LVStz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 13:49:55 -0500
X-Greylist: delayed 520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2010 13:49:54 EST
Received: (from strk@localhost)
	by freek.keybit.net (8.11.1/8.11.1) id oBMIfAk59989;
	Wed, 22 Dec 2010 19:41:10 +0100 (CET)
	(envelope-from strk@keybit.net)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164094>

The svn2cl tool [1] supports an author file to use for
generating the ChangeLog.

[1] http://arthurdejong.org/svn2cl/

Format of the file is:
 nick1:Name <email>
 nick2:Name 2 <email2>

It would be nice if git-svn could support the same format
in addition to the one using ``='' instead of ``:''.

That way you might have the authors file already available
in projects that made use of svn2cl.

Does it make sense ?

Please include me in reply as I'm not subscribed.

--strk; 

  ()   Free GIS & Flash consultant/developer
  /\   http://strk.keybit.net/services.html
