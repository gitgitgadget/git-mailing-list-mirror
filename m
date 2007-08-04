From: Robert Fitzsimons <robfitz@273k.net>
Subject: Re: [PATCH] gitweb: Fix handling of $file_name in feed generation
Date: Sat, 4 Aug 2007 01:27:08 +0100
Message-ID: <20070804002708.GA9840@localhost>
References: <20070803020555.GB8593@dervierte> <200708031110.55969.jnareb@gmail.com> <200708031950.43126.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	Robert Fitzsimons <robfitz@273k.net>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 02:57:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH7xh-0002Wj-Qt
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 02:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921AbXHDA5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 20:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757992AbXHDA5m
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 20:57:42 -0400
Received: from igraine.blacknight.ie ([81.17.252.25]:36982 "EHLO
	igraine.blacknight.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757619AbXHDA5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 20:57:41 -0400
X-Greylist: delayed 1756 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2007 20:57:41 EDT
Received: from 213-202-146-226.bas502.dsl.esat.net ([213.202.146.226] helo=localhost)
	by igraine.blacknight.ie with esmtp (Exim 4.60)
	(envelope-from <robfitz@273k.net>)
	id 1IH7V2-0000xb-Vu; Sat, 04 Aug 2007 01:28:09 +0100
Content-Disposition: inline
In-Reply-To: <200708031950.43126.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-blacknight-igraine-MailScanner-Information: Please contact the ISP for more information
X-blacknight-igraine-MailScanner: Found to be clean
X-blacknight-igraine-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-0.012, required 7,
	autolearn=disabled, RCVD_IN_NERDS_IE -2.00, RCVD_IN_SORBS_DUL 1.99)
X-MailScanner-From: robfitz@273k.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54783>

> Subject: [PATCH] gitweb: Fix handling of $file_name in feed generation
> 
> The commit b6093a5c, by Robert Fitzsimons:
>   "gitweb: Change atom, rss actions to use parse_commits."
> forgot to pass $file_name parameter to parse_commits subroutine.
> 
> If git_feed is provided a file name, it ought to show only the history
> affecting that file or a directory.  The title was being set
> correctly, but all commits from history were being shown.
> 
> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Silly me.  Jakub's change is the correct fix for the bug.

Robert
