From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 08:34:12 -0500
Message-ID: <20071221133412.GA15198@sigill.intra.peff.net>
References: <20071220203211.GA12296@bit.office.eurotux.com> <1198237002-21470-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luciano@eurotux.com, git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Dec 21 14:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5i1Q-0003kB-P2
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 14:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759193AbXLUNeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 08:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759445AbXLUNeQ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 08:34:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2985 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758975AbXLUNeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 08:34:16 -0500
Received: (qmail 26699 invoked by uid 111); 21 Dec 2007 13:34:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 21 Dec 2007 08:34:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Dec 2007 08:34:12 -0500
Content-Disposition: inline
In-Reply-To: <1198237002-21470-1-git-send-email-hendeby@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69065>

On Fri, Dec 21, 2007 at 12:36:42PM +0100, Gustaf Hendeby wrote:

> -	system($editor, $compose_filename);
> +	system("$editor $compose_filename");

If you are going to do it that way, I suspect you want to quotemeta
$compose_filename.

-Peff
