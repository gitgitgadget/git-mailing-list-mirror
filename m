From: "nathan bullock" <nathanbullock@gmail.com>
Subject: Re: I never want to push a given change
Date: Mon, 16 Jul 2007 23:04:04 -0600
Message-ID: <916b88c10707162204k69e47d25w1c03c04544bcbdf7@mail.gmail.com>
References: <916b88c10707160918n7a4948g5fb55a9d8ace9833@mail.gmail.com>
	 <76ACB85D-2969-406A-AA11-EAF2A104B9E7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Brian Gernhardt" <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 07:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAfEJ-0003Et-5P
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 07:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXGQFEH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 01:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbXGQFEG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 01:04:06 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:43652 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbXGQFEF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 01:04:05 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1043723nze
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 22:04:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RljxB0IZk8vSj3Tf/ihUuFzkYyW8+hgWM5ozhNh4a9BNzMqYMgJQq1eDqf5OGBDVoy861mRphRBzx23TKP/BOFqjaqIuMqduVgZghjBSxlhk1wu96eFrbibs97n6GA5BOq96usGW7jX+VeHBuO5f/Dn8U+ViOcKRMjnTYl6gK9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZdM+fOU8ACurvFeyV/a9SENyxAENUjZ5WX6oGzJ3zM0TqMjibX4hYgBJUcwZd0GRTHVy1P7uts+CGh7L+mez6u9RkowTt3bOwIqwXNAWVLZPJE26U9nG5JLGWcttJ0SmXwwDwR604p+vPFG9vr1ediS688Hy16CH1YKVkDuL7oI=
Received: by 10.115.88.1 with SMTP id q1mr48958wal.1184648644359;
        Mon, 16 Jul 2007 22:04:04 -0700 (PDT)
Received: by 10.115.74.2 with HTTP; Mon, 16 Jul 2007 22:04:04 -0700 (PDT)
In-Reply-To: <76ACB85D-2969-406A-AA11-EAF2A104B9E7@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52739>

On 7/16/07, Brian Gernhardt <benji@silverinsanity.com> wrote:
>
> On Jul 16, 2007, at 12:18 PM, nathan bullock wrote:
>
> > I have been using git for a little while and one thing that I would
> > like to
> > be able to do is never push a given change, or set of changes.
> >
> > So lets say I clone a .git repository. Then I make a couple of changes
> > that I don't want anyone else to see, do a commit. Then I make some
> > other changes that I want everyone else to see and do another commit.
> >
> > How do I push just the second commit?
> > And how do I make it so that every other time I do a push after
> > this that
> > first commit will never be sent?
>
> Generally the way I do such things is multiple branches.  Have a
> branch "local" (or a more descriptive name) that isn't pushed out
> anywhere.  Place any changes you do NOT want shared on that brach.
> Place changes to be shared on the master or appropriate topic
> branch.  Instead of committing changes to be shared on top of the
> local ones, use "git rebase" to keep the local branch on top of the
> shared ones.
>

Ahhh, thanks for that. You forced me to go stare at the git rebase documentation
until I actually understood what it does. It looks like that will work
perfectly.

Nathan
