From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH] submodule: Fix documentation of update subcommand
Date: Mon, 03 Nov 2014 22:15:26 +0100
Message-ID: <87wq7c9ea9.fsf@steelpick.2x.cz>
References: <1415009391-14979-1-git-send-email-sojkam1@fel.cvut.cz> <xmqqegtkrtt9.fsf@gitster.dls.corp.google.com> <xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOyV-0008OQ-0U
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 22:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675AbaKCVPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 16:15:39 -0500
Received: from max.feld.cvut.cz ([147.32.192.36]:49610 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468AbaKCVPi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 16:15:38 -0500
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 460D05CCFDA;
	Mon,  3 Nov 2014 22:15:37 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id qPjzqcsK4Yst; Mon,  3 Nov 2014 22:15:32 +0100 (CET)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 096AD5CCFD4;
	Mon,  3 Nov 2014 22:15:32 +0100 (CET)
Received: from wsh by steelpick.2x.cz with local (Exim 4.84)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1XlOyE-0006JY-Fz; Mon, 03 Nov 2014 22:15:26 +0100
In-Reply-To: <xmqqsii0qa4l.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.18.2+157~ga00d359 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 03 2014, Junio C Hamano wrote:
> I did a bit more digging of the history, and came up with this,
> which would be with a clearer and fairer description.  Also to
> clarify, I spelled what Michal's "This" meant to refer to.
>
> -- >8 --
> From: Michal Sojka <sojkam1@fel.cvut.cz>
> Date: Mon, 3 Nov 2014 11:09:51 +0100
> Subject: [PATCH] submodule: clarify documentation for update subcommand
>
> e6a1c43a (document submdule.$name.update=none option for gitmodules,
> 2012-05-10) meant to say "Unlike the case where your .update
> configuration is set to either 'rebase' or 'merge', when it is set
> to 'none', the tip of the submodule would never move.  You can use
> the --checkout option if you want the contents of the submodule to
> be updated to some other commit."
>
> But the resulting text made it sound as if using "--checkout" would
> have no effect when .update configuration is set to 'rebase' or
> 'merge', which was misleading.  In fact, with the "--checkout"
> option, the tip of the submodule moves to the exact commit that is
> recorded in the superproject tree, regardless of .update
> configuration.

This is much better description than I was able to put together. Thanks.
I also agree with Jens that mentioning --merge and --rebase is
worthwhile.

-Michal
