From: David Mansfield <david@cobite.com>
Subject: Re: git-cvs-import and branches
Date: Fri, 17 Feb 2006 15:35:15 -0500
Organization: Cobite, Inc
Message-ID: <1140208515.3397.177.camel@gandalf.cobite.com>
References: <mj+md-20060217.193815.10412.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, CVSps@dm.cobite.com
X-From: git-owner@vger.kernel.org Fri Feb 17 21:36:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FACKS-0007td-Fy
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 21:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWBQUfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbWBQUfV
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 15:35:21 -0500
Received: from iris.cobite.com ([208.222.83.2]:14826 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S1751752AbWBQUfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 15:35:19 -0500
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 6FD5798981; Fri, 17 Feb 2006 15:35:04 -0500 (EST)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 12775-06; Fri, 17 Feb 2006 15:35:04 -0500 (EST)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id 4667D989CD; Fri, 17 Feb 2006 15:35:04 -0500 (EST)
Received: from gandalf.cobite.com (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 295CC98803; Fri, 17 Feb 2006 15:35:02 -0500 (EST)
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <mj+md-20060217.193815.10412.albireo@ucw.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16364>

On Fri, 2006-02-17 at 20:55 +0100, Martin Mares wrote:
> Hello!
> 
> I'm git-importing a rather large CVS repository with lots of branches and
> although the mainline is imported correctly, the branches aren't. They
> usually contain some changes introduced to the ancestor branch after
> the point the new branch has been tagged.
> 
> I haven't studied git-cvsimport and cvsps in much detail yet, but it seems
> that git-cvsimport forks off the branch at the first patchset reported by
> cvsps which mentions the branch and copies the current state of the ancestor
> branch at that time.
> 
> This doesn't seem to be correct, since many changes might have happened
> to the ancestor branch since the real branching point. However, since
> cvsps doesn't report the branching points (and they aren't exact points anyway
> since tagging is not atomic in CVS), I don't see how to make cvsimport
> find the right starting revision.

Ugh.  I understand the problem but really don't have any solutions
off-hand.  Unfortunately, I dying under a 'real work' load at the
moment, so I have to apologize and say, 'good luck.'


David
