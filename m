From: Jeremy Morton <admin@game-point.net>
Subject: Recording the current branch on each commit?
Date: Sun, 27 Apr 2014 00:56:47 +0100
Message-ID: <535C47BF.2070805@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 02:04:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeCaV-00039y-25
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 02:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbaD0AEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 20:04:40 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:39310 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaD0AEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 20:04:39 -0400
X-Greylist: delayed 477 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Apr 2014 20:04:39 EDT
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 4970C18A09A9
	for <git@vger.kernel.org>; Sat, 26 Apr 2014 19:04:35 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247188>

Currently, git records a checksum, author, commit date/time, and commit 
message with every commit (as get be seen from 'git log').  I think it 
would be useful if, along with the Author and Date, git recorded the 
name of the current branch on each commit.  The branch name can provide 
useful contextual information.  For instance, let's say I'm developing a 
suite of games.  If the commit message says "Added basic options 
dialog", it might be useful to see that the branch name is 
"pacman-minigame" indicating that the commit pertains to the options 
dialog in the Pacman minigame.  Basically, I'm saying that well-named 
branches can and do carry useful contextual information that oughtn't to 
be thrown away.  Currently, when you delete that branch, you lose the 
branch name altogether.

So what do you think?  Would it be good to have a patch to add this feature?

-- 
Best regards,
Jeremy Morton (Jez)
