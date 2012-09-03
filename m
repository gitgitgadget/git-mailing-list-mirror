From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: checkout extra files
Date: Mon, 03 Sep 2012 16:47:54 +0200
Message-ID: <87harfw4bp.fsf@centaur.cmartin.tk>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<87sjazw6qq.fsf@centaur.cmartin.tk>
	<CAB9Jk9AkFW-fAqOZuhCMgMBdEZwDpe5ZG9Dkse=Wz_x9LvJEPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 16:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Xwi-0003io-E2
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 16:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174Ab2ICOrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 10:47:51 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:34653 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756482Ab2ICOrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 10:47:51 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id E9CDB800AD;
	Mon,  3 Sep 2012 16:47:49 +0200 (CEST)
Received: (nullmailer pid 5873 invoked by uid 1000);
	Mon, 03 Sep 2012 14:47:54 -0000
In-Reply-To: <CAB9Jk9AkFW-fAqOZuhCMgMBdEZwDpe5ZG9Dkse=Wz_x9LvJEPw@mail.gmail.com>
	(Angelo Borsotti's message of "Mon, 3 Sep 2012 16:05:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204699>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

[please keep it in the list]

> Hi Carlos,
>
> the behavior is quite clear, but the man pages do not describe it properly.
> The man pages state:
>
>     "It updates the named paths in the working tree from the index file or
>     from a named <tree-ish> ...".
>
> In my example, the "named paths in the working tree" is '*', which
> denotes

That grouping is not what it's saying. It doesn't update the files that
exist in the working tree matching some glob. It updates the files in
the working tree from either the index or a treeish. The pathspec
refers, as always, to the data source, and '*' matches all files.

It puts the named paths on to the working tree. Is that clearer?

> no files. So, the man pages are telling that the command updates nothing.
> The man pages should state that it copies from the index file of the names
> <tree-ish> the files that match the names paths and that are not present
> in the working tree.

Whether they are missing doesn't make any difference. It updates the
files you tell it from the index/tree. You told it to update all of
them.

   cmn
