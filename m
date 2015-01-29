From: Jeff King <peff@peff.net>
Subject: Re: Testsuite regression with perl 5.8.0 [Re: [ANNOUNCE] Git
 v2.3.0-rc2]
Date: Thu, 29 Jan 2015 10:52:15 -0500
Message-ID: <20150129155214.GC742@peff.net>
References: <xmqqpp9ziyqh.fsf@gitster.dls.corp.google.com>
 <54CA3611.1000804@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGrOH-00014v-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 16:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbbA2PwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 10:52:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:43021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752375AbbA2PwR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 10:52:17 -0500
Received: (qmail 26856 invoked by uid 102); 29 Jan 2015 15:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 09:52:16 -0600
Received: (qmail 18650 invoked by uid 107); 29 Jan 2015 15:52:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Jan 2015 10:52:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2015 10:52:15 -0500
Content-Disposition: inline
In-Reply-To: <54CA3611.1000804@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263151>

On Thu, Jan 29, 2015 at 02:30:57PM +0100, Tom G. Christensen wrote:

> On 28/01/15 00:35, Junio C Hamano wrote:
> >A release candidate Git v2.3.0-rc2 is now available for testing
> >at the usual places.
> >
> 
> Commit 2cf770 added testing of the --[no-]xmailer option to git send-email
> in t9001-send-email.sh
> Unfortunately it used the modern Getopt::long style of --no-<option> to
> negate the option which is not supported with Getopt::Long 2.32 as shipped
> with perl 5.8.0 on RHEL3 causing the tests to fail.
> 
> Changing the --no-xmailer option to the old --noxmailer style allows the
> tests to pass.

Both this and the curl-version issue you reported seem to have simple
solutions that you've already worked out and tested. Would you like to
express them in the form of patches so they can be applied? :)

-Peff
