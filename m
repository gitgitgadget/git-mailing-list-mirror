From: chris@seberino.org
Subject: git reset --hard <commit> superfluous?
Date: Fri, 2 Jan 2009 17:13:19 -0800
Message-ID: <20090103011319.GA24149@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 02:14:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIv6B-0008VB-5r
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 02:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321AbZACBNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 20:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbZACBNV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 20:13:21 -0500
Received: from li30-51.members.linode.com ([65.49.60.51]:41113 "EHLO
	seberino.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758215AbZACBNV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 20:13:21 -0500
Received: by seberino.org (Postfix, from userid 1000)
	id 92A75184BB; Fri,  2 Jan 2009 17:13:19 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104451>

David

git reset --hard <commit>
"resets" the current branch head.

Is this equivalent to deleting the branch
and doing

git branch <branch> <commit> ??

So "git reset --hard" is syntactic sugar and 'unnecessary' right?

cs
