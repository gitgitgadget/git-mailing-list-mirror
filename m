From: xuinkrbin <nabble.20.xuinkrbin@spamgourmet.com>
Subject: While the awesome switch is always on, so is the confusion switch.
Date: Tue, 4 May 2010 08:17:25 -0700 (PDT)
Message-ID: <28447763.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 17:17:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9JsL-0002Gc-6c
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 17:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab0EDPR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 11:17:27 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38371 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0EDPR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 11:17:26 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1O9JsD-0001U0-KV
	for git@vger.kernel.org; Tue, 04 May 2010 08:17:25 -0700
X-Nabble-From: nabble.20.xuinkrbin@spamgourmet.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146315>


Hi, All!

So, here's the situation.  I start with no modifications to HEAD and no
stashes.  I verify the lack of stashes with a 'git stash list'.  I make some
changes so I now have modifications to HEAD and, still, no stashes.  I
verify the lack of stashes with a 'git stash list'.  I run 'git stash' so I
now have no modifications to but a stash.  I verify the presence of a stash
with a 'git stash list'.  I run 'git stash pop' so I now have modifications
to head but no stashes.  I run 'git stash list' to verify the lack of
stashes and receive the following message:
	fatal: bad object refs/stash
If I delete .git/refs/stash and repeat the process, I find the same results. 
The contents of .git/refs/stash are also embedded within
.git/logs/refs/stash, if that fact means anything.  Can Anyone point Me in
the direction of documentation on this particular problem to help clear up
why this is happening and which might help Me to determine what I should do
about it?

Thanks!

mi'e xuinkrbin.
-- 
View this message in context: http://old.nabble.com/While-the-awesome-switch-is-always-on%2C-so-is-the-confusion-switch.-tp28447763p28447763.html
Sent from the git mailing list archive at Nabble.com.
