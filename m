From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Installation Plan
Date: Sat, 22 Dec 2012 09:48:03 +1100
Message-ID: <CAH5451nurRwHUmhUg5g=3xNXRXGpJmAVBx2KXobdJ1Mt9YQdaA@mail.gmail.com>
References: <50D475A9.9020407@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 23:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmBOU-0004oc-HI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 23:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116Ab2LUWsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 17:48:25 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:39412 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab2LUWsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 17:48:24 -0500
Received: by mail-qc0-f170.google.com with SMTP id d42so2893336qca.1
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ML+Yg9/t7Q3frWe8+RJKl1a51GIy4dCswdISkUg8H9I=;
        b=v2Pf5MnmG7Wk4ILg9CUL8upDhTgnzsq/NNh92QgMNlO0nkA0jb32Anp6gFs/59FQhh
         Ja/6is2SigYYHoURdRDZQEfEheEif+X7j6sSwspnnt9b8NDImaDmQly+A/YWpnZ52Ie6
         bLxEhen2NvDp1dKsHYcK8NGi0N82p1OOS35OSEeT2PAySt/AGc8ko9LCCAGgG0WUbqDx
         U2mnD6PIVB69fGfOfugBMcDuz8YiZ/8kOgTWXRvoVPmj89jOkoWQHNijx0WTNHIIEQ6Q
         xgjKIezBsaDXmmrINk2bt/dLXik7COKXZUyNAFjDXmCVeiUwNC07MPtpISR3idCRZF5e
         keUg==
Received: by 10.49.118.138 with SMTP id km10mr8904276qeb.18.1356130103844;
 Fri, 21 Dec 2012 14:48:23 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Fri, 21 Dec 2012 14:48:03 -0800 (PST)
In-Reply-To: <50D475A9.9020407@bellsouth.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212019>

hi Dennis,

In general your plan looks good. Note that you don't actually need the
Eclipse plugin at all, it just makes it possible to do git operations
while in your IDE. Most people will, even if they have the plugin,
still use the full client as it provides a lot more power and
flexibility. Use whatever you need to, and extend your toolset when
required.

Also, the leap from central repository on Linux to a clone on Windows
needs a little more thought. Will you set up a git server? Access the
central repository over ssh? A shared drive? Many people use a web
service (such as Bitbucket or GitHub) for this purpose as it becomes
easier to manage. You can then have a clone on the Linux box as well
as the Windows box.

On 22 December 2012 01:43, Dennis Putnam <dap1@bellsouth.net> wrote:
> Am I over simplifying things? I also think that this will open the door
> for collaborators in the event I need them with no changes to the way I
> work. I should note that builds are done on demand so is there a way to
> detect when a push is occurring and have the build script wait for
> completion and I suppose vise-versa?

You want to look into the different hooks available, most notable the
post-receive hook. There are also build servers that can monitor a
repository and build whenever it sees a new commit (Jenkins and Bamboo
are two I know of).

Regards,

Andrew Ardill
