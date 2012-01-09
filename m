From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 9 Jan 2012 10:13:33 +0100
Message-ID: <878vlh1bnm.fsf@thomas.inf.ethz.ch>
References: <20120108213134.GA18671@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jan 09 10:13:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkBIW-00018E-AJ
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 10:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab2AIJNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 04:13:38 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:13933 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab2AIJNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 04:13:36 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 10:13:33 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 10:13:33 +0100
In-Reply-To: <20120108213134.GA18671@ecki.lan> (Clemens Buchacher's message of
	"Sun, 8 Jan 2012 22:31:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188163>

Clemens Buchacher <drizzd@aon.at> writes:

> Interactive rebase is frequently used not to rebase history, but to
> manipulate recent commits. This is typically done using the following
> command:
>
>  git rebase -i HEAD~N
>
> Where N has to be large enough such that the the range HEAD~N..HEAD
> contains the desired commits. At the same time, it should be small
> enough such that the range HEAD~N..HEAD does not include published
> commits or a merge commit.
[...]
>  git rebase --fix
>
> By default, the range is limited to a maximum of 20 commits.

Given the name I would expect --fix to rebase far enough to make recent
fixup!/squash! commits take effect.  Perhaps name it --recent?

(And I also think that the 20 is rather arbitrary...)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
