From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Difference between pull --rebase and fetch+rebase
Date: Thu, 7 Jan 2010 17:00:36 +0100
Message-ID: <adf1fd3d1001070800k6fa501fej39b84f849b7e5b50@mail.gmail.com>
References: <27059158.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: martinvz <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 17:01:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSun4-0003KO-Dc
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 17:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab0AGQAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 11:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380Ab0AGQAj
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 11:00:39 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:35218 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270Ab0AGQAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 11:00:38 -0500
Received: by bwz27 with SMTP id 27so11517429bwz.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 08:00:36 -0800 (PST)
Received: by 10.102.174.1 with SMTP id w1mr4287780mue.51.1262880036663; Thu, 
	07 Jan 2010 08:00:36 -0800 (PST)
In-Reply-To: <27059158.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136350>

On Thu, Jan 7, 2010 at 1:23 PM, martinvz
<martin.von.zweigbergk@gmail.com> wrote:
>
> I have a branch configured to track a remote branch by rebasing. I excepted
> that "git pull" would therefore be equivalent to fetching from the remote
> repository followed by rebasing the remote branch, but it isn't. When doing
> "git rebase <remote>/<branch>", it applies only the commits after the merge
> base. When doing "git pull", it tries to apply two more commits (the two
> commits preceding the merge base). Why is this?
>
> I get the same result even if I do "git pull --rebase <remote> <branch>", it
> doesn't seem to have anything to do with incorrect configuration of the
> branch.

Yes, both should do the same (at least when upstream is not rebased).
Can you provide a test case or instructions to reproduce the behavior?

Thanks,
Santi
