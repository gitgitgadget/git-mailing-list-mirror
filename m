From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git-daemon wrapper to wait until daemon is ready
Date: Sat, 14 Apr 2012 21:00:56 +0200
Message-ID: <20120414190056.GC3915@ecki>
References: <20120414182907.GA3915@ecki>
 <1334428952-sup-5241@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git <git@vger.kernel.org>, gitster <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Apr 14 21:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ8FE-0000Dr-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 21:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab2DNTCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 15:02:30 -0400
Received: from smtpout11.highway.telekom.at ([195.3.96.69]:22888 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755767Ab2DNTCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 15:02:13 -0400
Received: (qmail 20679 invoked from network); 14 Apr 2012 19:02:09 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL505.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub78.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <bwalton@artsci.utoronto.ca>; 14 Apr 2012 19:02:09 -0000
Content-Disposition: inline
In-Reply-To: <1334428952-sup-5241@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195504>

On Sat, Apr 14, 2012 at 02:43:41PM -0400, Ben Walton wrote:
> 
> > The shell script which is currently used to parse git daemon output does
> > not seem to work unreliably. In order to work around such issues,
> 
> Presumably you mean "work reliably" here?

Yes, that's what I meant the commit message to say. Thanks for noticing.

But I would like to wait for more info from the OP before we conclude
that this is indeed the case.
