From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] launch_editor: ignore SIGINT while the editor has
 control
Date: Mon, 12 Nov 2012 14:47:38 -0500
Message-ID: <20121112194738.GC4623@sigill.intra.peff.net>
References: <20121111163100.GB13188@sigill.intra.peff.net>
 <20121111165510.GB19850@sigill.intra.peff.net>
 <7v4nkuk966.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Fox <pgf@foxharp.boston.ma.us>,
	Kalle Olavi Niemitalo <kon@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:47:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXzzA-0005vW-TC
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 20:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2KLTrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 14:47:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44916 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2KLTrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 14:47:42 -0500
Received: (qmail 13046 invoked by uid 107); 12 Nov 2012 19:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 14:48:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 14:47:38 -0500
Content-Disposition: inline
In-Reply-To: <7v4nkuk966.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209513>

On Mon, Nov 12, 2012 at 09:44:49AM -0800, Junio C Hamano wrote:

> How did this message happen?
> 
>     Subject: [PATCH 2/5] launch_editor: ignore SIGINT while the editor has control
>     To: Kalle Olavi Niemitalo <kon@iki.fi>
>     Cc: Paul Fox <pgf@foxharp.boston.ma.us>, git@vger.kernel.org
>     Date: Sun, 11 Nov 2012 11:55:11 -0500
>     Message-ID: <20121111165510.GB19850@sigill.intra.peff.net>
>     References: <20121111163100.GB13188@sigill.intra.peff.net>
> 
>     The user's editor likely catches SIGINT (ctrl-C).  but if
>     the user spawns a command from the editor and uses ctrl-C to
>     kill that command, the SIGINT will likely also kill git
>     itself (depending on the editor, this can leave the terminal
>     in an unusable state).
> 
>     Signed-off-by: Paul Fox <pgf@foxharp.boston.ma.us>
>     Signed-off-by: Jeff King <peff@peff.net>
>     ---
> 
> Judging from S-o-b, message-id and EHLO, I think this was sent by
> Peff, but came without Sender: or anything.
> 
> Just being curious.

I screwed up when sending out the series and did not properly move
Paul's "From" address from the email header down to the body. It is not
a git or send-email screw-up; I load format-patch output directly into
mutt as a template. Since I do not often send out other people's
patches, I never bothered to write a script to migrate the "from" into
the body automatically.

-Peff
