From: Bill Lear <rael@zopyra.com>
Subject: Re: Git log of all (modifying) commands run on a repo?
Date: Wed, 7 Feb 2007 16:39:06 -0600
Message-ID: <17866.21770.762672.84327@lisa.zopyra.com>
References: <17866.20355.744025.133326@lisa.zopyra.com>
	<eqdjt3$jo5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvRc-0001fc-Lj
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbXBGWjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161467AbXBGWjN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:39:13 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61650 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161469AbXBGWjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:39:13 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l17MdBJ07431;
	Wed, 7 Feb 2007 16:39:11 -0600
In-Reply-To: <eqdjt3$jo5$1@sea.gmane.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38984>

On Wednesday, February 7, 2007 at 23:29:56 (+0100) Jakub Narebski writes:
>...
>Is history of shell commands too short? Reflogs doesn't help
>(concatenate all reflogs, perhaps preceding them with file name,
>and sort by date) either?

Well, I thought of shell history also, but the problem is, that we often
have multiple repos on a machine (we may be executing a long-running
experiment in one, for example, and not want to disturb it).

Shell history in that case doesn't help.  Also, not having the branch
information is a minus (each of us puts the current git branch in our
prompt).

I didn't know about reflogs.  What did you have in mind?  Could you
show an example, please?


Bill
