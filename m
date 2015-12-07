From: Sam Hocevar <sam@hocevar.net>
Subject: Re: [PATCH 1/2] git-p4: support multiple depot paths in p4 submit
Date: Mon, 7 Dec 2015 19:51:29 +0100
Message-ID: <20151207185129.GA48528@hocevar.net>
References: <20151205112203.GA15745@hocevar.net>
 <F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 19:51:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a60sw-0008R7-26
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 19:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbbLGSvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 13:51:38 -0500
Received: from poulet.zoy.org ([193.200.42.166]:60227 "EHLO smtp.zoy.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755624AbbLGSvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 13:51:37 -0500
Received: by smtp.zoy.org (Postfix, from userid 1000)
	id 86A08361298; Mon,  7 Dec 2015 19:51:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <F328D5D9-754A-41CC-A7B2-993B9315ED33@gmail.com>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282103>

On Sun, Dec 06, 2015, Lars Schneider wrote:
> Thanks for the patch! Do you see a way to demonstrate the bug in a test case similar to t9821 [1]?

   Not yet, I'm afraid. It's proving trickier than expected because for
now I can only reproduce the bug when the view uses multiples depots
(solution #2 on http://answers.perforce.com/articles/KB/2437), and
unfortunately the test case system in Git was designed for a single
depot.

   Would a refactor of lib-git-p4.sh (and probably all git-p4 tests) to
support multiple depots be acceptable and/or welcome? I prefer to ask
before I dig into the task.

Regards,
-- 
Sam.
