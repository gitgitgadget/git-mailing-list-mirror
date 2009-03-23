From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Mon, 23 Mar 2009 02:57:10 -0400
Message-ID: <20090323065710.GA7048@coredump.intra.peff.net>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Mar 23 07:58:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lle7a-00086z-5n
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 07:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbZCWG5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 02:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754301AbZCWG5Q
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 02:57:16 -0400
Received: from peff.net ([208.65.91.99]:34063 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774AbZCWG5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 02:57:15 -0400
Received: (qmail 19138 invoked by uid 107); 23 Mar 2009 06:57:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 23 Mar 2009 02:57:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Mar 2009 02:57:10 -0400
Content-Disposition: inline
In-Reply-To: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114248>

On Sun, Mar 22, 2009 at 09:20:44AM -0400, Ben Walton wrote:

> Ensure that the Makefile that generates and installs the Documentation
> is aware of any SHELL_PATH setting.  Use this value if found or the
> current setting for SHELL if not.  This is an accommodation for systems
> where sh is not bash.

Nit: I have lots of systems where sh is not bash, and they work fine. It
is really about "where sh is not horribly broken". There aren't (AFAIK)
and should not be any bash-isms in these scripts.

The patch itself looks fine; thanks for addressing my concerns.

-Peff
