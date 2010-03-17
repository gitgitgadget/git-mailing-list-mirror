From: jateeq <jawad_atiq@hotmail.com>
Subject: Getting a branch's time of creation
Date: Wed, 17 Mar 2010 07:45:07 -0700 (PDT)
Message-ID: <27933166.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 15:45:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NruUs-0005kg-99
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 15:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab0CQOpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 10:45:10 -0400
Received: from kuber.nabble.com ([216.139.236.158]:53835 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab0CQOpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 10:45:09 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1NruUd-00028U-95
	for git@vger.kernel.org; Wed, 17 Mar 2010 07:45:07 -0700
X-Nabble-From: jawad_atiq@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142394>


Hello,

I am trying to find the time at which a remote branch was created, so that I
can use the '--since' option in git log to limit the commits to only ones
that were created for that branch (read below to see why I can't use 'git
log <branchnname>). So my question: does git remember the time at which a
branch was created, and how can it be listed?

NOTE: Once I clone a repository that contains Branch1 (which will have its
own commits as well as commits from the master branch), I create Branch2 in
the clone to track Branch1. Branch1 will have commits before the cloning,
and Branch2 will have its own commits after the cloning, but I want to list
both. The way I am thinking of doing it is to list all commits for Branch2,
and then limit the commits to only ones that were created after Branch1 was
created.

If anyone has suggestions on doing this alternatively, feel free to pitch
in. Thank you.
Jawad.

-- 
View this message in context: http://old.nabble.com/Getting-a-branch%27s-time-of-creation-tp27933166p27933166.html
Sent from the git mailing list archive at Nabble.com.
