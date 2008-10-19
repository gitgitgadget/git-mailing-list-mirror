From: Matt McCutchen <matt@mattmccutchen.net>
Subject: "git checkout: --track and --no-track require -b" check
	accidentally resurrected?
Date: Sat, 18 Oct 2008 20:54:12 -0400
Message-ID: <1224377652.19061.12.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 19 02:55:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrMZs-00065T-4y
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 02:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbYJSAyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 20:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYJSAyP
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 20:54:15 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:56178 "EHLO
	jankymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751981AbYJSAyP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Oct 2008 20:54:15 -0400
Received: from [129.2.207.232] (ml2.student.umd.edu [129.2.207.232])
	by jankymail-a2.g.dreamhost.com (Postfix) with ESMTP id 0A43AB6A8D;
	Sat, 18 Oct 2008 17:54:13 -0700 (PDT)
X-Mailer: Evolution 2.22.3.1 (2.22.3.1-1.fc9) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98586>

Merge commit 9ba929ed resurrected the following two-line check, which
was removed in the first parent and unchanged in the second:

	if (!opts.new_branch && (opts.track != git_branch_track))
		die("git checkout: --track and --no-track require -b");

Is this intentional?  Does it make a difference?

(I noticed this while carefully examining 9ba929ed to find out why "git
merge" stopped honoring merge.conflictstyle.  Ironically, I hit this bug
again during the examination.)

Matt
