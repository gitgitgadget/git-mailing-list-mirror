From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: "Not currently on any branch"
Date: Fri, 2 Oct 2009 13:58:42 -0700
Message-ID: <f488382f0910021358nc4a8c2ehca665c47aa39224c@mail.gmail.com>
References: <loom.20091002T215942-663@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Tim <timothyjwashington@yahoo.ca>
X-From: git-owner@vger.kernel.org Fri Oct 02 23:05:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtpJb-0008W1-FA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 23:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbZJBVE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbZJBVE7
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 17:04:59 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:43040 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbZJBVE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 17:04:58 -0400
Received: by yxe37 with SMTP id 37so1504718yxe.33
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 14:05:02 -0700 (PDT)
Received: by 10.91.189.5 with SMTP id r5mr1725639agp.31.1254517122365; Fri, 02 
	Oct 2009 13:58:42 -0700 (PDT)
In-Reply-To: <loom.20091002T215942-663@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129459>

On Fri, Oct 2, 2009 at 1:08 PM, Tim <timothyjwashington@yahoo.ca> wrote:
> I have some code in a git repo that is "Not currently on any branch". Now,
> there's the master branch and another branch 'ui-integration' that I'm using in
> this project. I don't know how the project got into this headless state, but I
> need to be using the 'ui-integration' branch.
>
> I tried looking around the blogosphere for a solution, and tried what I found
> here. But it seems like only my last commit (not the previous 10 I made) shows
> up in the master branch (not ui-integration ).
> http://blog.kortina.net/post/71935540/fix-git-not-currently-on-any-branch-problem
>
> What's the most straightforward & cleanest way to merge my changes in the
> headless branch to my 'ui-integration' branch?
>

Try 'git checkout -b temp', which creates a branch called 'temp' with
its HEAD at where you currently are, and then merge your changes to
ui-integration via 'git checkout ui-integration; git merge temp', and
finally drop the junk branch with 'git branch -d temp'

- Steven
