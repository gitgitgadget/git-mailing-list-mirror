From: Sergey Organov <sorganov@gmail.com>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 08 Sep 2014 17:51:58 +0400
Message-ID: <87tx4i8bk1.fsf@osv.gnss.ru>
References: <87a96ecqe9.fsf@osv.gnss.ru> <20140905221336.GB701@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Sep 08 15:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQzMU-00076d-ET
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 15:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbaIHNwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 09:52:02 -0400
Received: from mail.javad.com ([54.86.164.124]:57163 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbaIHNwB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 09:52:01 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id E189060BF3;
	Mon,  8 Sep 2014 13:51:59 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XQzMM-0000sv-78; Mon, 08 Sep 2014 17:51:58 +0400
In-Reply-To: <20140905221336.GB701@serenity.lan> (John Keeping's message of
	"Fri, 5 Sep 2014 23:13:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256646>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Sep 05, 2014 at 02:28:46PM +0400, Sergey Organov wrote:
> ...
>> # Then I realize I need more changes and it gets complex enough to
>> # warrant a topic branch. I create the 'topic' branch that will track
>> # 'master' branch and reset 'master' back to its origin (remote
>> # origin/master in original scenario).
>> 
>> git checkout -b topic
>> git branch --force master origin_master
>
> This line is the problem, because the purpose of the `--fork-point`
> argument to `git rebase` is designed to help people recover from
> upstream rebases, which is essentially what you create here.  So when
> rebase calculates the local changes it realises (from the reflog) that
> the state of master before this command was before you created the
> branch, so only commits after it should be picked.

Thanks, but I did realize it myself (after I spent a few hours figuiring
it out). The question is what should I have done instead?

-- 
Sergey.
