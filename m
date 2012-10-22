From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: merge --no-commit not able to report stats more verbosely?
Date: Mon, 22 Oct 2012 09:39:31 -0400
Organization: MAD House Graphics
Message-ID: <k63iai$kbp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 15:40:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQIEZ-0001I7-9r
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 15:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399Ab2JVNjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 09:39:48 -0400
Received: from plane.gmane.org ([80.91.229.3]:60240 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab2JVNjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 09:39:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQIEQ-0001Cu-Qd
	for git@vger.kernel.org; Mon, 22 Oct 2012 15:39:50 +0200
Received: from c-68-82-181-85.hsd1.de.comcast.net ([68.82.181.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 15:39:50 +0200
Received: from scottg.wp-hackers by c-68-82-181-85.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 15:39:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-68-82-181-85.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120911 Thunderbird/15.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208186>

As you can see from the below, I can't seem to get it to give me more
verbose results of what's being merged (as in the actual merge below)
with --stat or -v .. is it supposed to do that?

(develop)>$ git merge --no-commit --stat -v widget_twitter
Automatic merge went well; stopped before committing as requested
(develop|MERGING)>$ git merge --abort

(develop)>$ git merge widget_twitter
Merge made by the 'recursive' strategy.
 .../code/community/Dnd/Magentweet/Model/User.php   |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


(develop)>$ git --version
git version 1.7.7.6



-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
