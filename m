From: Paul Fox <pgf@foxharp.boston.ma.us>
Subject: Re: What's cooking in git.git (Nov 2012, #06; Mon, 19)
Date: Tue, 20 Nov 2012 06:59:22 -0500
Message-ID: <20121120115923.746252E9301@grass.foxharp.boston.ma.us>
References: <7vpq39up0m.fsf@alter.siamese.dyndns.org> (sfid-20121119_185521_871211_B8238659)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 12:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TamUN-0002iH-R8
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 12:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab2KTL7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 06:59:25 -0500
Received: from colo.foxharp.net ([166.84.7.52]:54619 "EHLO colo.foxharp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2KTL7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 06:59:24 -0500
Received: from grass.foxharp.boston.ma.us (localhost [127.0.0.1])
	by colo.foxharp.net (Postfix) with ESMTP id B135A540E4;
	Tue, 20 Nov 2012 06:56:20 -0500 (EST)
Received: by grass.foxharp.boston.ma.us (Postfix, from userid 1000)
	id 746252E9301; Tue, 20 Nov 2012 06:59:23 -0500 (EST)
Received: from grass (localhost [127.0.0.1])
	by grass.foxharp.boston.ma.us (Postfix) with ESMTP id 2B74B2E9300;
	Tue, 20 Nov 2012 06:59:23 -0500 (EST)
In-reply-to: <7vpq39up0m.fsf@alter.siamese.dyndns.org> (sfid-20121119_185521_871211_B8238659)
Content-ID: <22310.1353412762.1@grass>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210094>

junio c hamano wrote:
 > [Stalled]
 > 
 > * pf/editor-ignore-sigint (2012-11-11) 5 commits
 >  - launch_editor: propagate SIGINT from editor to git
 >  - run-command: do not warn about child death by SIGINT
 >  - run-command: drop silent_exec_failure arg from wait_or_whine
 >  - launch_editor: ignore SIGINT while the editor has control
 >  - launch_editor: refactor to use start/finish_command
 > 
 >  Avoid confusing cases where the user hits Ctrl-C while in the editor
 >  session, not realizing git will receive the signal. Since most editors
 >  will take over the terminal and will block SIGINT, this is not likely
 >  to confuse anyone.
 > 
 >  Some people raised issues with emacsclient, which are addressed by this
 >  re-roll. It should probably also handle SIGQUIT, and there were a
 >  handful of other review comments.
 > 
 >  Expecting a re-roll.

i don't have strong feelings on any of the later review comments
(though i guess the check on finish_command()'s return code needed
attention), and wasn't the last submitter, but would certainly like to
see this move forward.

paul
=---------------------
 paul fox, pgf@foxharp.boston.ma.us (arlington, ma, where it's 26.1 degrees)
