From: nicofari64 <nicola.farina@info-line.it>
Subject: Help with subtree pull / push
Date: Tue, 27 May 2014 06:55:58 -0700 (PDT)
Message-ID: <1401198958683-7611751.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 15:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpHrH-0000tZ-L7
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 15:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaE0Nz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 09:55:59 -0400
Received: from sam.nabble.com ([216.139.236.26]:51950 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbaE0Nz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 09:55:59 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <nicola.farina@info-line.it>)
	id 1WpHrC-0000hB-MK
	for git@vger.kernel.org; Tue, 27 May 2014 06:55:58 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250168>

Hi
I am new to git, trying to see if I can use it at my work place to replace
Starteam.
There is only one Starteam feature that I miss, comparing it to git: shared
files.
Most projects, here, use lot of shared files, and Starteam handle these
pretty easily.
You just check in (commit + push in git terms) these files in Starteam
central repo and every project that "share" them see these as "out-of-date"
(so you know you have to "check out" (pull)). 
Very handy.
For every other aspect (not least ... ehm .. the price) Git seems better to
me: it handles much better moving and creating files, and I like the
distributed and "tree-oriented" approach better.
But shared files are a problem.
After lot of google search I came to the idea of using git subtree, to
achieve the same results of Starteam shared files.
So I have created 4 remote bare repositories, 1 for the main app and 3 for
the shared files parts.
After making some changes in shared files though I got in trouble:
subtree push keeps give me this error:

error: failed to push some refs to
'//vm2003test/OuvertureWebShared/Ouverture'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

Obviously I have already made the pull command (as suggested in the message)
and it says to me
that everything is up to date.

On SO there is the very same question
(http://stackoverflow.com/questions/13756055/git-subtree-subtree-up-to-date-but-cant-push)
but I was unable to try the proposed solution since my git client
(GitExtensions on windows) does not support apparently the grave accent.
Moreover I don't actually understand that workaround.
Thanks for any help
Bye
Nicola



--
View this message in context: http://git.661346.n2.nabble.com/Help-with-subtree-pull-push-tp7611751.html
Sent from the git mailing list archive at Nabble.com.
