From: Jeremy Morton <admin@game-point.net>
Subject: Running interpret-trailers automatically on each commit?
Date: Fri, 28 Aug 2015 16:22:25 +0100
Message-ID: <55E07CB1.0@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 17:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVLcu-0005B4-9H
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 17:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbbH1PbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 11:31:24 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:42583 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbbH1PbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 11:31:24 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2015 11:31:24 EDT
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 7050718A00F2
	for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:23:09 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276722>

I see that interpret-trailers has been added by default in git 2.5.0. 
  However the documentation isn't that great and I can't tell whether 
it gets run automatically when I do a "git commit".  My guess is that 
it doesn't - that you have to set up a hook to get it to run each commit.

As far as I can tell, there is no way to configure global git hooks. 
Sure, you can set init.templatedir but that only applies for 
newly-init'ed or cloned repos.  So if I have 50 repos on my hard drive 
I still have to go through every one of them and set up a hook for it.

Basically, am I right in thinking that there is *still* no way for me 
to configure git (on a global, not per-repo basis) to automatically 
tack a trailer onto every commit message?  For the record, I want that 
trailer to be the current branch name.

-- 
Best regards,
Jeremy Morton (Jez)
