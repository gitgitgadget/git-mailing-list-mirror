From: "Wink Saville" <wink@saville.com>
Subject: Re: Git branching & pulling
Date: Tue, 22 May 2007 17:22:03 -0700
Message-ID: <d4cf37a60705221722t2167a0e8x810689218b87fb39@mail.gmail.com>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
	 <7vveepxr7m.fsf@assigned-by-dhcp.cox.net>
	 <d4cf37a60705190931rca1187ap9b98becb6c7c3b2a@mail.gmail.com>
	 <200705202230.24362.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 23 02:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqecG-0006NB-Hg
	for gcvg-git@gmane.org; Wed, 23 May 2007 02:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760686AbXEWAWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 20:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760993AbXEWAWH
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 20:22:07 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:50386 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760760AbXEWAWF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 20:22:05 -0400
Received: by wa-out-1112.google.com with SMTP id m33so5032wag
        for <git@vger.kernel.org>; Tue, 22 May 2007 17:22:03 -0700 (PDT)
Received: by 10.114.77.1 with SMTP id z1mr2592waa.1179879723069;
        Tue, 22 May 2007 17:22:03 -0700 (PDT)
Received: by 10.114.137.15 with HTTP; Tue, 22 May 2007 17:22:03 -0700 (PDT)
In-Reply-To: <200705202230.24362.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48134>

>
> Because git does not know what to merge; there is no config entry
> for "branch.test.merge", as the warning says. How would you reword
> this warning to make it easier to understand?
> But from your question, I assume that you expected git to have a
> "branch.test.merge" setting.
> What do you expect it to do? And why?
>
> Is my assumption correct that you want the last command to be equivalent
> to "git-pull . master"? And my further assumption, that you want this
> because you expect "git pull" to default to merging changes from its
> upstream (also when the upstream is local)?

Yes, as you said below that was the old behavior and besides when
the branch was created git was told what the upstream was it seems
reasonable that it remember that. When I clone a remote it does the
right thing it would seem when I make a branch it would behave
the same.

>
> Creation of a branch from another local one never has created
> "branch.x.remote" or "branch.x.merge" entries. I am not even sure
> that setting "branch.x.remote" to "." is working in the current version.

I tired to create the appropriate entries and it didn't work,
but maybe operator error.

> BTW: There was some old behavior of "git pull" to always pull the master
> branch from remote "origin" without any further parameters. I suppose that
> you did not want this to happen in your example above ?!
>

I expected it to pull from its upstream (i.e. the branches parent).

Wink
