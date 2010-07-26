From: brennsuppa <joe@bastarde.at>
Subject: git push asking for a password
Date: Mon, 26 Jul 2010 03:31:20 -0700 (PDT)
Message-ID: <29265051.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 26 12:37:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdL3e-0000AF-5T
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 12:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab0GZKbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 06:31:22 -0400
Received: from kuber.nabble.com ([216.139.236.158]:46575 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab0GZKbV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 06:31:21 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1OdKxs-0002fv-Og
	for git@vger.kernel.org; Mon, 26 Jul 2010 03:31:20 -0700
X-Nabble-From: joe@bastarde.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151827>


Hi,

I'm working with git for the first time and when I started it I just had to
commit/push/pull on an existing repository.

Now I should create a new repo, but this fails when I try to git push origin
master:refs/heads/master because it is asking for a password, which should
not happen since ssh-keys are in use, right?

my setup:

I have an existing repo called drums, this works fine!
Now I tried to create a new one called guitars with this how to
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way

so my gitosis.conf is like this:
[gitosis]

[group gitosis-admin]
writable = gitosis-admin
members = brennsuppa

[group drums]
writable = drums
members = brennsuppa dan


[group guitars]
writable = guitars
members = brennsuppa dan eug

my key should be working, otherwise I cannot explain why it works with
drums, any help?


-- 
View this message in context: http://old.nabble.com/git-push-asking-for-a-password-tp29265051p29265051.html
Sent from the git mailing list archive at Nabble.com.
