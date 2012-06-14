From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] remove the impression of unexpectedness when access is
	denied
Date: Thu, 14 Jun 2012 09:39:17 +0200
Message-ID: <20120614073917.GA51232@book.hvoigt.net>
References: <20120610182310.GB2427@book.hvoigt.net> <20120611190207.GA20889@sigill.intra.peff.net> <20120614071259.GA51076@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 09:46:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf4lV-0006Or-LK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 09:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809Ab2FNHqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 03:46:34 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:53695 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab2FNHqd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 03:46:33 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Sf4eE-0008NI-0a; Thu, 14 Jun 2012 09:39:18 +0200
Content-Disposition: inline
In-Reply-To: <20120614071259.GA51076@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199975>

Hi,

On Thu, Jun 14, 2012 at 09:13:06AM +0200, Heiko Voigt wrote:
> This is the shortest I was currently able to come up with.

BTW, I could probably just add another function named e.g.

	packet_read_line_allow_shorter(...

and do an internal static function for handling this.

Cheers Heiko
