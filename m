From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 5 Feb 2014 16:09:54 -0500
Message-ID: <20140205210954.GA24142@sigill.intra.peff.net>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
 <20140205011632.GA3923@sigill.intra.peff.net>
 <xmqq1tzh494e.fsf@gitster.dls.corp.google.com>
 <20140205201243.GA16899@sigill.intra.peff.net>
 <xmqqsirx2teh.fsf@gitster.dls.corp.google.com>
 <20140205203740.GA17077@sigill.intra.peff.net>
 <xmqqfvnx2s7p.fsf@gitster.dls.corp.google.com>
 <20140205210129.GA24314@sigill.intra.peff.net>
 <xmqq7g992ror.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 22:10:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB9jq-0003X4-7M
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 22:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbaBEVKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 16:10:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:45333 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932520AbaBEVJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 16:09:56 -0500
Received: (qmail 20008 invoked by uid 102); 5 Feb 2014 21:09:56 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 15:09:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 16:09:54 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7g992ror.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241666>

On Wed, Feb 05, 2014 at 01:08:36PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... So the fact that this
> > bug exists doesn't really produce any user-visible behavior, and
> > hopefully post-release we would drop the code entirely, and the test
> > would have no reason to exist.
> 
> Heh, thanks, and I agree with the reasoning for the longer-term
> direction.  Perhaps I can/should hold it off that minimal fix-up
> patch from -rc3, then?  I am on the fence but I already started my
> today's integration cycle _with_ the fix merged to 'master', so...

I would say leave the fix for -rc3, but not worry about the test.

-Peff
