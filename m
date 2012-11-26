From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: Can I zip a git repo without losing anything?
Date: Mon, 26 Nov 2012 17:04:41 +0400
Message-ID: <20121126170441.a6c94f108bc57cca8bcfe679@domain007.com>
References: <CAP-uhDcQg0BuEdHDTa6qVqLCeB-LE1GZtEqHgY_j1--XodsDKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Carl Smith <carl.input@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 14:05:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyMv-00077u-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2KZNEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:04:46 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:42209 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab2KZNEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:04:45 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id qAQD4ec8006413;
	Mon, 26 Nov 2012 17:04:41 +0400
In-Reply-To: <CAP-uhDcQg0BuEdHDTa6qVqLCeB-LE1GZtEqHgY_j1--XodsDKw@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210437>

On Mon, 26 Nov 2012 04:55:10 +0000
Carl Smith <carl.input@gmail.com> wrote:

> After suggesting using zip files to move our projects around, I was
> told that you can not zip a git repo without loosing all the history.
> This didn't make sense to me, but two people told me the same thing,
> so I wasn't sure. I think they may have been confusing the zipped file
> you can download from GitHub with a zipped git repo.
> 
> If someone could put me straight on this, I'd really appreciate it.

To amend the already provided answer -- if you need to move repos
around using the sneakernet, the tool you should probably use is
`git bundle`.
