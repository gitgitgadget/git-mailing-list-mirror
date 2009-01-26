From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 15:45:43 -0500
Message-ID: <20090126204543.GF27604@coredump.intra.peff.net>
References: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com> <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302> <d77df1110901260827j2200fe41oe1b84c387d88aba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:47:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYMZ-0006mk-Ev
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZAZUps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbZAZUps
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:45:48 -0500
Received: from peff.net ([208.65.91.99]:36813 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbZAZUpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:45:47 -0500
Received: (qmail 6406 invoked by uid 107); 26 Jan 2009 20:45:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 15:45:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 15:45:43 -0500
Content-Disposition: inline
In-Reply-To: <d77df1110901260827j2200fe41oe1b84c387d88aba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107271>

On Mon, Jan 26, 2009 at 10:27:18AM -0600, Nathan W. Panike wrote:

> I think I have an unusual workflow where my patch makes sense,
> although it probably does not for the vast majority of git users.  I
> regularly use 3 machines: S, L, and H.  I keep my work synchronized by
> using git.  Normally, I fetch from S to L or to H, depending on which
> machine I am working on at the moment.  I also push from L or H to S.
> I sporadically lose connectivity to S, so I have a hook in the repo on
> S to send a backup email to me on mail server M, which has a more
> reliable connection.  This email also serves as a  reminder when I

Have you considered sending a bundle instead of a patch in the backup
email? That is the more exact equivalent of a push (i.e., it preserves
your actual commits, sha1 and all).

-Peff
