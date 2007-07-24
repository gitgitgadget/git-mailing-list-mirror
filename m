From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFH] Mark user-manual as UTF-8
Date: Tue, 24 Jul 2007 04:53:41 -0400
Message-ID: <20070724085340.GA10729@coredump.intra.peff.net>
References: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	"H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 10:53:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDG9M-0000Zp-BT
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 10:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbXGXIxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 04:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757255AbXGXIxp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 04:53:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1542 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757136AbXGXIxo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 04:53:44 -0400
Received: (qmail 25955 invoked from network); 24 Jul 2007 08:53:41 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 24 Jul 2007 08:53:41 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2007 04:53:41 -0400
Content-Disposition: inline
In-Reply-To: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53537>

On Tue, Jul 24, 2007 at 12:46:35AM -0700, Junio C Hamano wrote:

> This attempts to force UTF-8 on the generating end.
> [...]
>  * I have to warn that I do not really think I know what I am
>    doing, but this seems to "work for me".

I'm by no means a docbook expert, but I think what you've done is sane.
Supposedly there is an xsl:param "chunker.output.encoding" which would
let you do the same thing from the xsltproc command line, but I can't
seem to get it to work (and I don't know enough about xsl to even begin
figuring out why).

-Peff
