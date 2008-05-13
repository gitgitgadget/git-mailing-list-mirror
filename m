From: amishera <amishera2007@gmail.com>
Subject: abouy git reset command
Date: Tue, 13 May 2008 00:07:45 -0700 (PDT)
Message-ID: <17202423.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 09:09:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvod7-000247-19
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 09:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbYEMHHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753197AbYEMHHq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 03:07:46 -0400
Received: from kuber.nabble.com ([216.139.236.158]:48156 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbYEMHHp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 03:07:45 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Jvobx-0001Ks-5z
	for git@vger.kernel.org; Tue, 13 May 2008 00:07:45 -0700
X-Nabble-From: amishera2007@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81996>


Hi,
I just want to make sure whether my understanding of that command is correct
or not. I have 3 basic requirements:

1. I have changed something after the commits and I think those are wrong.
So I want to undo all changes and the working directory should reflect last
commit:

git reset --hard HEAD

2. I have some changes in the index and I want undo them.

git reset HEAD

3. I just want to undo the last commit but not the working tree:

git reset HEAD^

If they are correct commands please let me know. 

Besides in the man page for git reset it is mentioned:

git-reset - Reset current HEAD to the specified state

Which means it is supposed to work with commits. But why is the same command
work in case 2 and case 3 above? 

Moreover, can any body tell me the use of

git reset --soft

The following language is confusing:

--soft

    Does not touch the index file nor the working tree at all, but requires
them to be in a good order.

Thanks in advance.
-- 
View this message in context: http://www.nabble.com/abouy-git-reset-command-tp17202423p17202423.html
Sent from the git mailing list archive at Nabble.com.
