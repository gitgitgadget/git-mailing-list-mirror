From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [BUG] unable to checkout branch with a clean worktree
Date: Mon, 05 Jan 2009 18:54:48 +0100
Message-ID: <87fxjxk593.fsf@cup.kalibalik.dk>
References: <35079.bFoQE3daRhY=.1231170168.squirrel@webmail.hotelhot.dk>
	<20090105160527.GA7718@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 05 18:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJthK-0005KF-2n
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 18:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbZAERyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 12:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbZAERyw
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 12:54:52 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:42602 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbZAERyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 12:54:52 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0A9BC308D4;
	Mon,  5 Jan 2009 18:53:57 +0100 (CET)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id BD56630013;
	Mon,  5 Jan 2009 18:53:56 +0100 (CET)
In-Reply-To: <20090105160527.GA7718@localhost> (Clemens Buchacher's message of "Mon\, 5 Jan 2009 17\:05\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104589>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Jan 05, 2009 at 04:42:48PM +0100, Anders Melchiorsen wrote:
>> Git v1.6.1: The final checkout fails with an error about merge conflicts.
>
> This is fixed by the recent patches for verify_absent. (Actually,
> just PATCH 2/3 should be enough to fix this issue.)
>
> http://article.gmane.org/gmane.comp.version-control.git/104317

Right, I can confirm that the patch [2/3] fixes this, also in the repo
where the issue originally turned up.


Thanks,
Anders.
