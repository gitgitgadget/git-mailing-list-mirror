From: Jeff King <peff@peff.net>
Subject: Re: t9200 cvsexportcommit test fails on Ubuntu server 12.04.4 LTS
Date: Sat, 1 Mar 2014 01:46:43 -0500
Message-ID: <20140301064642.GD20397@sigill.intra.peff.net>
References: <5310D933.1@fabiodalfonso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fabio D'Alfonso <fabio.dalfonso@fabiodalfonso.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJdhD-0007kZ-69
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 07:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbaCAGqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 01:46:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:59211 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752145AbaCAGqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 01:46:45 -0500
Received: (qmail 23036 invoked by uid 102); 1 Mar 2014 06:46:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Mar 2014 00:46:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2014 01:46:43 -0500
Content-Disposition: inline
In-Reply-To: <5310D933.1@fabiodalfonso.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243045>

On Fri, Feb 28, 2014 at 07:45:07PM +0100, Fabio D'Alfonso wrote:

> I get 12 of 15 tests faling.
> 
> Any idea? the same build works fine on 11.04 where I have a desktop version.

No clue. It works fine for me here (Debian sid). Perhaps try running the
script like:

    ./t9200-git-cvsexportcommit.sh -v -i

which should give more information about what exactly is failing?

-Peff
