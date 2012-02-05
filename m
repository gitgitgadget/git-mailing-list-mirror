From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/3] blame: fix email output with mailmap
Date: Sun, 5 Feb 2012 20:57:17 +0100
Message-ID: <87liohvysi.fsf@thomas.inf.ethz.ch>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
	<1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 20:57:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru8DG-0002gK-7t
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 20:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab2BET5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 14:57:21 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25419 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260Ab2BET5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 14:57:21 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 20:57:17 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 20:57:17 +0100
In-Reply-To: <1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 4 Feb 2012 21:50:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189951>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Cc: git@vger.kernel.org,  Junio C Hamano <gitster@pobox.com>,  "Brian Gianforcaro" <b.gianfo@gmail.com>,  "Marius Storm-Olsen" <marius@trolltech.com>,  "Junio C Hamano" <junkio@cox.net>

I hope you noticed that Cc lists like the above really prove my point
that you cannot automate common sense.  Your cccmd script apparently
uses the line range in

> diff --git a/builtin/blame.c b/builtin/blame.c
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1403,10 +1403,13 @@

to determine who to Cc.  But in doing so, it dug up an old address for
Junio.  It also added Brian whose only fault in all of this was fixing
style of the 'if' you are patching.

And on top of that it had absolutely no way of knowing that Cc'ing Peff
would have been a good idea, seeing as you two were involved in an
earlier discussion about this precise bug.

(Granted, omitting *Peff* doesn't make that much of a difference, since
for all I know he reads every email that crosses this list.  But my
point still stands.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
