From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (resend) 2/2] difftool: put the cursor on the editable
 file for Vim
Date: Sun, 18 Jan 2009 22:43:39 -0800
Message-ID: <7vzlhnre1w.fsf@gitster.siamese.dyndns.org>
References: <1232343269-27665-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 07:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOnsj-0007fQ-JZ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 07:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868AbZASGnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 01:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756236AbZASGnp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 01:43:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217AbZASGno (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 01:43:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C20EC91307;
	Mon, 19 Jan 2009 01:43:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F0AE791305; Mon,
 19 Jan 2009 01:43:40 -0500 (EST)
In-Reply-To: <1232343269-27665-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 18 Jan 2009 21:34:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83D94828-E5F4-11DD-9CED-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106328>

Ok, I see you updated from r to l.

Please do not mark such "an earlier one had a thinko, and here is a
corrected patch" as "resend".  It is confusing, because "resend" usually
means "I sent this earlier but somehow it did not reach the list, so here
is another copy verbatim."

Instead, please add a sentence or two after "---" lines to explain the
situation, like...

    You only need to edit worktree files when comparing against
    the worktree.  Put the cursor automatically into its window for
    vimdiff and gvimdiff to avoid doing <C-w>r every time.

    Signed-off-by: David Aguilar <davvid@gmail.com>
    ---

    Markus pointed out that 'l' is not left (it is right as in vi key
    bindings).

     contrib/difftool/git-difftool-helper |    8 ++++++--
     1 files changed, 6 insertions(+), 2 deletions(-)

and say "[PATCH 2/2 (corrected)]" so that I can easily tell which one was
a dud and which one I should take.

This time it wasn't confusing because the exchange between Markus and you
were the only unread messages before your three patches in my mailbox, but
you are not always that lucky.

Will take your original 1/2 and this one.

Thanks.
