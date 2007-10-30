From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] core-tutorial: Use new syntax for git-merge.
Date: Tue, 30 Oct 2007 13:05:20 -0700
Message-ID: <7v640ol667.fsf@gitster.siamese.dyndns.org>
References: <87lk9k4bvp.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 21:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImxLS-0005eP-8P
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 21:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbXJ3UF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 16:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbXJ3UF1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 16:05:27 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:57436 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbXJ3UF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 16:05:26 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0C95F2F9;
	Tue, 30 Oct 2007 16:05:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9570E903FE;
	Tue, 30 Oct 2007 16:05:44 -0400 (EDT)
In-Reply-To: <87lk9k4bvp.fsf@osv.gnss.ru> (Sergei Organov's message of "Tue,
	30 Oct 2007 22:54:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62747>

Sergei Organov <osv@javad.com> writes:

> The patch below turns core-tutorial to use new syntax for
> git-merge. Please take close look at the last diff chunk, -- I'm not sure I
> got it right as it didn't have HEAD in the original version, -- was it already
> wrong before the patch?

You do not want the extra 'master' there.

> @@ -1607,8 +1607,8 @@ in both of them.  You could merge in 'diff-fix' first and then
>  'commit-fix' next, like this:
>  
>  ------------
> -$ git merge 'Merge fix in diff-fix' master diff-fix
> -$ git merge 'Merge fix in commit-fix' master commit-fix
> +$ git merge -m 'Merge fix in diff-fix' master diff-fix
> +$ git merge -m 'Merge fix in commit-fix' master commit-fix
>  ------------

The example is working on 'master' branch at this point and HEAD
and 'master' are equivalent there.
