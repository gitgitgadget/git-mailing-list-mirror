From: malc@pulsesoft.com
Subject: git bisect issue
Date: Sat, 4 Apr 2009 13:11:39 +0400 (MSD)
Message-ID: <Pine.LNX.4.64.0904041307360.10230@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 12:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2sM-0000Be-2t
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 12:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150AbZDDKLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 06:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755106AbZDDKLt
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 06:11:49 -0400
Received: from fe02x03-cgp.akado.ru ([77.232.31.165]:56258 "EHLO akado.ru"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752946AbZDDKLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 06:11:49 -0400
X-Greylist: delayed 3602 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Apr 2009 06:11:48 EDT
Received: from [10.0.66.9] ([10.0.66.9] verified)
  by fe02-cgp.akado.ru (CommuniGate Pro SMTP 5.1.16)
  with ESMTP id 49591675 for git@vger.kernel.org; Sat, 04 Apr 2009 13:11:39 +0400
X-X-Sender: malc@linmac.oyster.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115580>

Hello,

I was trying to run git bisect today and stumbled upon this:

$ git bisect start
error: pathspec 'bisect' did not match any file(s) known to git.

.git had some (stale?) BISECT_XXX files in it, and removing them
helped. One of those (BISECT_START) consisted of a single line:
"bisect". If i remember correctly i used to have a bisect branch
in this particular repo.

-- 
mailto:av1474@comtv.ru
