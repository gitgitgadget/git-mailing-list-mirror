From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix dcommit, rebase when rewriteRoot is in use
Date: Sat, 08 Mar 2008 13:05:18 -0800
Message-ID: <7v3ar1sz8x.fsf@gitster.siamese.dyndns.org>
References: <1205006470-18882-1-git-send-email-jgoerzen@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 22:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY6F7-0006in-D1
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 22:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbYCHVFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 16:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYCHVFb
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 16:05:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYCHVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 16:05:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AFE253FB0;
	Sat,  8 Mar 2008 16:05:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0E9A73FAB; Sat,  8 Mar 2008 16:05:25 -0500 (EST)
In-Reply-To: <1205006470-18882-1-git-send-email-jgoerzen@complete.org> (John
 Goerzen's message of "Sat, 8 Mar 2008 14:01:10 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76586>

John Goerzen <jgoerzen@complete.org> writes:

> Problem described here:
>
> http://thread.gmane.org/gmane.comp.version-control.git/76561
>
> Signed-off-by: John Goerzen <jgoerzen@complete.org>

While I am sure Eric and git-svn users would appreciate a fix, please do
not write a commit log message like this.

Having a pointer to additional material is a very good practice, and will
be appreciated by the readers, but giving a pointer and nothing else means
that you are forcing your readers to hunt for out-of-line information.

One person who writes can spend an extra few minutes to summarize the
issue, and it will save time and effort for hundreds of readers.

If what is written is worth being read by that many readers, that is, and
in this case I am sure it is ;-).


