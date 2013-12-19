From: Adam Spiers <git@adamspiers.org>
Subject: prevent gitk collapsing tree view when viewing a different commit?
Date: Thu, 19 Dec 2013 15:15:07 +0000
Message-ID: <20131219151507.GC23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 16:15:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtfJo-00039G-3Z
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 16:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467Ab3LSPPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 10:15:11 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45208 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab3LSPPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 10:15:09 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id D8A9D2E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 15:15:07 +0000 (GMT)
Content-Disposition: inline
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239521>

Hi all,

If I launch gitk, switch the lower right pane from Patch view mode to
Tree view, expand a few directories, and then changing to viewing a
different commit, the tree automatically collapses again.  This is
really annoying when trying to view changes to the tree structure over
time; is there any way to stop it, or would it be an easy tweak to the
code for someone familiar with it?  I had a look at the code but could
hardly understand any of it :-/

Thanks,
Adam
