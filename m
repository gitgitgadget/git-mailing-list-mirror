From: dquince <devin.quince@troppussoftware.com>
Subject: Cloning tags from master
Date: Mon, 15 Oct 2012 12:44:53 -0700 (PDT)
Message-ID: <1350330293914-7569301.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 15 22:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNqtq-0005YH-LG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 22:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666Ab2JOUET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 16:04:19 -0400
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:37159
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab2JOUET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 16:04:19 -0400
X-Greylist: delayed 1165 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Oct 2012 16:04:19 EDT
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <devin.quince@troppussoftware.com>)
	id 1TNqar-000886-Tv
	for git@vger.kernel.org; Mon, 15 Oct 2012 12:44:54 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207776>

I am trying to implement using tags in our build process, but am running into
an issue with pulling tags from master. My scenario is as follows
We decide on a release and I tag master with testtag which has commit
testtag-1-gf3b117e
When I make another commit to master and check the tag, I see it as
testtag-2-gfb56442
When I try and pull the tag using testtag, it just wants to pull the latest
commit to master. 

I verified this works in branches other than master, so can this be done
from master or does the tag just follow the head?




--
View this message in context: http://git.661346.n2.nabble.com/Cloning-tags-from-master-tp7569301.html
Sent from the git mailing list archive at Nabble.com.
