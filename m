From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git svn init throws Not a git repository (or any of the parent
 directories): .git
Date: Wed, 13 Feb 2013 17:15:20 +0400
Message-ID: <20130213171520.40674d470f678bc4ee25821c@domain007.com>
References: <CALiJYpDPf8R2mOZn5Ey_yArSAg73WRASKS1cqLsAu1tGJcO_SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: "amccloud@gmail.com" <amccloud@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5cBt-00072u-Af
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 14:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759358Ab3BMNP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 08:15:26 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:40286 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759363Ab3BMNPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 08:15:25 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r1DDFKPA026165;
	Wed, 13 Feb 2013 17:15:22 +0400
In-Reply-To: <CALiJYpDPf8R2mOZn5Ey_yArSAg73WRASKS1cqLsAu1tGJcO_SA@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216257>

On Wed, 13 Feb 2013 14:01:36 +0100
"amccloud@gmail.com" <amccloud@gmail.com> wrote:

> I have problem with git svn init:
> When I execute
> git svn init svn+ssh://username@example.com/path/repo
> I see:
> fatal: Not a git repository (or any of the parent directories): .git
> Already at toplevel, but .git not found
>  at /usr/lib/git-core/git-svn line 342

Are you doing `git init` first before running `git svn init ...`?
