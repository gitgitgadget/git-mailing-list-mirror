From: Yue Lin Ho <yuelinho777@gmail.com>
Subject: Re: git update-index not delete lock file when using different
 worktree
Date: Fri, 18 Jul 2014 01:21:35 -0700 (PDT)
Message-ID: <1405671695257-7615378.post@n2.nabble.com>
References: <1405567125455-7615300.post@n2.nabble.com> <1405585628972-7615306.post@n2.nabble.com> <20140717103654.GA18897@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 10:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X83QD-0001vB-OA
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 10:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759702AbaGRIVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 04:21:37 -0400
Received: from sam.nabble.com ([216.139.236.26]:58795 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758687AbaGRIVf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 04:21:35 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <yuelinho777@gmail.com>)
	id 1X83Q7-0003ea-8Z
	for git@vger.kernel.org; Fri, 18 Jul 2014 01:21:35 -0700
In-Reply-To: <20140717103654.GA18897@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253797>

Hi Duy:

I tested your patch. It works. :)
(only one case.)

Thank you.

There are 26 hold_locked_index() in these files:

Line  475 of builtin\add.c
Line 4234 of \builtin\apply.c
Line  259 of \builtin\checkout.c
Line  448 of \builtin\checkout.c
Line  139 of \builtin\checkout-index.c
Line  643 of \builtin\clone.c
Line  323 of \builtin\commit.c
Line  362 of \builtin\commit.c
Line  383 of \builtin\commit.c
Line  434 of \builtin\commit.c
Line 1295 of \builtin\commit.c
Line  479 of \builtin\describe.c
Line  211 of \builtin\diff.c
Line  660 of \builtin\merge.c
Line  700 of \builtin\merge.c
Line   88 of \builtin\mv.c
Line  152 of \builtin\read-tree.c
Line  338 of \builtin\reset.c
Line  296 of \builtin\rm.c
Line  808 of \builtin\update-index.c
Line  588 of \cache-tree.c
Line   75 of \merge.c
Line 2004 of \merge-recursive.c
Line  482 of \rerere.c
Line  301 of \sequencer.c
Line  671 of \sequencer.c

Yue Lin




--
View this message in context: http://git.661346.n2.nabble.com/git-update-index-not-delete-lock-file-when-using-different-worktree-tp7615300p7615378.html
Sent from the git mailing list archive at Nabble.com.
