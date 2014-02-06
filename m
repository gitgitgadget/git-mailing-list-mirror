From: David Kastrup <dak@gnu.org>
Subject: Re: Confusing git log --- First time bug submission please advise on best practices
Date: Thu, 06 Feb 2014 17:10:04 +0100
Message-ID: <874n4cjk83.fsf@fencepost.gnu.org>
References: <CAJaBJzJeeEKpaTVXv+LnZd49xjnDjU25y9i_3kKNOrRPVbP-wg@mail.gmail.com>
	<CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Francis Stephens <francisstephens@gmail.com>, git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Thu Feb 06 17:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBRWx-0001Ux-R5
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 17:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbaBFQKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 11:10:16 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:38433 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbaBFQKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 11:10:14 -0500
Received: from localhost ([127.0.0.1]:37475 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WBRWn-0006zO-HJ; Thu, 06 Feb 2014 11:10:13 -0500
Received: by lola (Postfix, from userid 1000)
	id 80803E04FA; Thu,  6 Feb 2014 17:10:04 +0100 (CET)
In-Reply-To: <CAAH6HY8unuytrKpEA-eisojUkG=X4D+o+vQDO5bC5YCSmusoHw@mail.gmail.com>
	(Vincent van Ravesteijn's message of "Thu, 6 Feb 2014 17:08:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241702>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> The commits that are in the log for master and which are not in the
> log for originssh/master are merged in at "6833fd4 (HEAD, master);
> Completed merge".
>
> As "git log" can only present the commits in a linear way, it shows
> the commits from the ancentry of both parents of HEAD in a reverse
> chronological order. This means that the commits from the two
> ancestries are mixed and commits that are shown after each other don't
> have to be parent and child. See the documentation of "git log" and
> the section "Commit Ordering": "By default, the commits are shown in
> reverse chronological order."

git log --graph can help with getting a better picture.

-- 
David Kastrup
