From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Implement vc-git-annotate-show-diff-revision-at-line
 for emacs vc-git
Date: Fri, 22 Feb 2008 12:30:32 -0800
Message-ID: <7voda891jr.fsf@gitster.siamese.dyndns.org>
References: <1203706693.7552.56.camel@alexjb-desktop.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 21:31:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSeYG-00033t-I4
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 21:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbYBVUat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 15:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbYBVUas
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 15:30:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbYBVUas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 15:30:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A88744D2;
	Fri, 22 Feb 2008 15:30:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C888144D1; Fri, 22 Feb 2008 15:30:42 -0500 (EST)
In-Reply-To: <1203706693.7552.56.camel@alexjb-desktop.transitives.com> (Alex
 Bennee's message of "Fri, 22 Feb 2008 18:58:13 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74756>

Alex Bennee <kernel-hacker@bennee.com> writes:

> Whats the easiest command to show the parent commit of a given commit id
> (the closest analogy I can think of)? I tried:
>
>  git-show 486a974a --pretty="format:%P"

 * Have rev before option, like "git show --pretty=... 486a974"

 * Use -s to squelch diff output.

You should check how the %P format shows parents for a merge and
decide which parent you would want to follow.
