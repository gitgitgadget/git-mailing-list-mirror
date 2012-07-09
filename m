From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Git and Quilt
Date: Mon, 9 Jul 2012 16:20:42 +0400
Message-ID: <20120709162042.0149100574d2d04497a952fc@domain007.com>
References: <1341835029.10119.36.camel@sysadmin>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jimmy Thrasibule <thrasibule.jimmy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 14:21:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoCxT-0005ky-40
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 14:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513Ab2GIMUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 08:20:49 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:42108 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab2GIMUs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 08:20:48 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q69CKhip031069;
	Mon, 9 Jul 2012 16:20:44 +0400
In-Reply-To: <1341835029.10119.36.camel@sysadmin>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201200>

On Mon, 09 Jul 2012 13:57:09 +0200
Jimmy Thrasibule <thrasibule.jimmy@gmail.com> wrote:

> I have a core project on which I maintain a set of patches using
> Quilt. This allows me to make changes to the project without touching
> the files so I can upgrade to new versions easily.
> 
> I keep my patches and the core project in a Git repository. When I
> want to change something, I apply my patches using Quilt, then I
> revert all my changes and I just commit the resulting patch.
> 
> I would like to have a branch where all my patches are applied to
> deploy the code but I can't find any good way to do this.
> 
> If I create a new branch from master and apply the patches, I will
> have conflicts on the next merge. I need something to apply the
> patches before the merge (maybe using one of the hooks?).

Isn't what you're doing a perfect fit for rebasing [1]?
That is, you keep your changes as a series of commits on top of your
"upstream" branch and each time you're about to bring upstream changes
in, you rebase your local branch on top on the updated upstream branch.

1. http://git-scm.com/book/en/Git-Branching-Rebasing
