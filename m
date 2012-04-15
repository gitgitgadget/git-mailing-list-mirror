From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] t5570: use explicit push refspec
Date: Sun, 15 Apr 2012 02:11:33 +0200
Message-ID: <20120415001133.GB32140@ecki>
References: <20120414182907.GA3915@ecki>
 <20120414183225.GB3915@ecki>
 <7viph1288e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 02:12:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJD5J-0000u5-VX
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 02:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557Ab2DOAMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 20:12:49 -0400
Received: from smtpout15.highway.telekom.at ([195.3.96.90]:58269 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755143Ab2DOAMt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 20:12:49 -0400
Received: (qmail 11744 invoked from network); 15 Apr 2012 00:12:46 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL504.highway.telekom.at
X-Spam-Level: ****
Received: from p5b22d2b0.dip.t-dialin.net (HELO [127.0.0.1]) (aon.912301525.1@aon.at@[91.34.210.176])
          (envelope-sender <drizzd@aon.at>)
          by smarthub76.res.a1.net (qmail-ldap-1.03) with AES128-SHA encrypted SMTP
          for <gitster@pobox.com>; 15 Apr 2012 00:12:46 -0000
Content-Disposition: inline
In-Reply-To: <7viph1288e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195539>

On Sat, Apr 14, 2012 at 04:40:01PM -0700, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> > The default mode for push without arguments will change. Some warnings
> > are about to be enabled for such use, which causes some t5570 tests to
> > fail because they do not expect this output. Fix this by passing an
> > explicit refspec to git push.
> 
> I wonder if a better fix is to configure "push.default = matching" in the
> test repository.  Otherwise wouldn't the result of the push change once
> the default changes?

The push.default option matters only if a refspec is not specified. By
adding a refspec, push.default should not matter any more. Unless that
is going to change as well?
