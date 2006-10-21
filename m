From: Jeff King <peff@peff.net>
Subject: Re: git-imap-send and "From "
Date: Sat, 21 Oct 2006 14:01:45 -0400
Message-ID: <20061021180145.GA7983@coredump.intra.peff.net>
References: <200610211751.21581.andyparkins@gmail.com> <20061021175519.GA7432@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 20:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbLAN-000052-9V
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 20:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993120AbWJUSBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 14:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993139AbWJUSBs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 14:01:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:20700 "HELO
	peff.net") by vger.kernel.org with SMTP id S2993120AbWJUSBr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 14:01:47 -0400
Received: (qmail 24863 invoked from network); 21 Oct 2006 14:01:46 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 21 Oct 2006 14:01:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Oct 2006 14:01:45 -0400
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <20061021175519.GA7432@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29648>

On Sat, Oct 21, 2006 at 01:55:19PM -0400, Jeff King wrote:

> git-imap-send shouldn't be sending it. The IMAP protocol works with
> RFC822 messages, not mboxes.

FWIW, I just checked and git-imap-send does the right thing; it strips
the 'From ' line before sending to the imap server.

-Peff
