From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-am.txt: advertise 'git am --abort' instead of 'rm
 .git/rebase-apply'
Date: Tue, 22 Mar 2011 15:17:08 -0400
Message-ID: <20110322191708.GA23447@sigill.intra.peff.net>
References: <1300819345-28279-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 20:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q274x-0001is-1K
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 20:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1CVTRL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 15:17:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41718
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab1CVTRK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 15:17:10 -0400
Received: (qmail 28290 invoked by uid 107); 22 Mar 2011 19:17:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 15:17:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 15:17:08 -0400
Content-Disposition: inline
In-Reply-To: <1300819345-28279-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169765>

On Tue, Mar 22, 2011 at 07:42:25PM +0100, SZEDER G=C3=A1bor wrote:

> -The command refuses to process new mailboxes while the `.git/rebase-=
apply`
> -directory exists, so if you decide to start over from scratch,
> -run `rm -f -r .git/rebase-apply` before running the command with mai=
lbox
> +The command refuses to process new mailboxes before the current
> +operation isn't finished, so if you decide to start over from scratc=
h,
> +run `git am --abort` before running the command with mailbox
>  names.

Grammar: it should be "...before the current operation is finished".

-Peff
