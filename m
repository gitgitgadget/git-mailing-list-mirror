From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document clarification: gitmodules, gitattributes
Date: Sun, 31 Aug 2008 09:38:40 -0700
Message-ID: <7vwshx2l7z.fsf@gitster.siamese.dyndns.org>
References: <1220198427-13017-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZpy1-0005Ek-GA
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 18:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbYHaQiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 12:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYHaQiq
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 12:38:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYHaQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 12:38:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91E3F6EF1A;
	Sun, 31 Aug 2008 12:38:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BB6736EF19; Sun, 31 Aug 2008 12:38:42 -0400 (EDT)
In-Reply-To: <1220198427-13017-1-git-send-email-hendeby@isy.liu.se> (Gustaf
 Hendeby's message of "Sun, 31 Aug 2008 18:00:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4787ED76-777B-11DD-8EFD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94494>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> The SYNOPSIS section of gitattibutes and gitmodule fail to clearly
> specify the name of the in tree files used.  This patch brings in the
> initial `.' and the fact that the `.gitmodules' file should reside at
> the top-level of the working tree.
>
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
>
> If this patch isn't accepted, the reverse changes should be made to
> the gitignore documentation.

The sole reason they lacked the initial "." was because AsciiDOC
mishandled ".gitmodules" that began the line; we used to have the dot but
removed it as a workaround because we couldn't find a good solution by
tweaking the mark-up.

By prefixing "$GIT_FOOBAR/" in front of them, your patch makes the issue
go away while conveying the fact that it has to be at the toplevel of the
work tree, not anywhere in the tree.  Very nice.
