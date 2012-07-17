From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git rebase -i does not rebase if all lines are removed
Date: Tue, 17 Jul 2012 12:55:35 +0200
Message-ID: <1342522535.20671.7.camel@centaur.cmartin.tk>
References: <CAGHpTBKn+avCrWegktoJRurG+oycq6Sb9CiRDCBQG=hSMUkjiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 13:10:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sr5fE-0007PH-AL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 13:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2GQLJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 07:09:55 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:60983 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab2GQLJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 07:09:54 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2012 07:09:54 EDT
Received: from [192.168.1.5] (p57A1FFA4.dip.t-dialin.net [87.161.255.164])
	by hessy.dwim.me (Postfix) with ESMTPSA id 1CD7C814A7;
	Tue, 17 Jul 2012 13:00:50 +0200 (CEST)
In-Reply-To: <CAGHpTBKn+avCrWegktoJRurG+oycq6Sb9CiRDCBQG=hSMUkjiA@mail.gmail.com>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201600>

On Tue, 2012-07-17 at 13:46 +0300, Orgad and Raizel Shaneh wrote:
> Make a commit on top of master.
> 
> git rebase -i origin/master
> 
> Remove the commit.
> 
> Git prints "Nothing to do" and does not rebase.
> 
> Running 'git rebase -i' when there are no local commits has 'noop' in
> the first line, and with it the rebase is successful. Why is this
> 'noop' mandatory?

If you read the instructions, the last line says

    # However, if you remove everything, the rebase will be aborted

so if you want to do a no-op, then you need to tell it. This is the same
way you abort a commit, by providing it with an empty message.

But more important would be /why/ you feel that rebase -i is the tool
you should be using. If you'd like to move the branch pointer back,
that's what the reset command is for. rebase deals with moving commits
from one base to another and optionally reordering, squashing or
removing some of them.

   cmn
