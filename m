From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Sun, 02 Dec 2007 18:32:52 -0800
Message-ID: <7vabosse23.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:33:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz17Z-0001ks-Dk
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbXLCCdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbXLCCdA
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:33:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49969 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbXLCCc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:32:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E3F1C2EF;
	Sun,  2 Dec 2007 21:33:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 64F0C9C4DE;
	Sun,  2 Dec 2007 21:33:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66848>

"David Symonds" <dsymonds@gmail.com> writes:

> On Dec 3, 2007 9:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Please do not take this as the final decision made by the Emperor, whose
>> subjects now must follow.  This is a sanity-check to see if everybody is
>> on the same page.
>>
>> I am not the Emperor anyway ;-)
>>
>
>> Topics not in 'master' yet but should be in v1.5.4
>> --------------------------------------------------
>>
>> I think the following should go in, along with what we already have in
>> 'master':
>
> Can we add the git-status/git-checkout relative path stuff that's
> currently been sitting in 'next'? It would be a good step forward for
> usability.

I think checkout from subdirectory with relative was merged on November
18th to master, with d577bc58.  Relative path output for git-status is
part of the "git-commit in C" series, which is planned to go in.

But now you mention it, I realize that I ran "git-topic.perl" (found in
my 'todo' branch) without "--all" option when I made that list, and I
missed stuff fully merged to 'next'.  Sorry.

Here is a corrected list.

Topics not in 'master' yet but should be in v1.5.4
--------------------------------------------------

I think the following should go in, along with what we already have in
'master':

 * git-commit in C (Kristian and others)
 * git-add --patch (Wincent)
 * git-prune --expire (Dscho)
 * git-add --interactive coloring (Dan Zwell)
 * whitespace error classes in diff and patch, using gitattributes (Bruce and me)
 * cvsserver runs post-receive (Michael Witten)
 * git-rebase -i gives chance to rerere (Dscho)
 * git-rebase gives more appropriate help text (Wincent)
 * make refspec matching logic in git-push and git-fetch saner (Steffen Prohaska)
 * work-tree related minor fixes (Nguyen and Dscho)
 * allow update hook to munge commit (Steven Grimm)
 * git-fast-export (Dscho)
 * Add commitdiff to gitweb grep page (Denis Cheng)
 * "git pull --rebase" (Dscho)
 * "git config --get-color" (me)
 * "color.diff = true" means "auto" (me)
 * Rewrite "export VAR=VAL" to "VAR=VAL; export VAR" (Dscho)
 * run correct perl in Documentation (me, waiting for Merlyn)
