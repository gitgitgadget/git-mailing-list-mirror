From: Jeff King <peff@peff.net>
Subject: Re: configure clobbers LDFLAGS
Date: Mon, 5 Jan 2009 01:00:58 -0500
Message-ID: <20090105060058.GB13189@coredump.intra.peff.net>
References: <m3tz8e32ru.fsf@multivac.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: prj@po.cwru.edu
X-From: git-owner@vger.kernel.org Mon Jan 05 07:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJiXm-00029R-RN
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 07:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbZAEGBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 01:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZAEGBD
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 01:01:03 -0500
Received: from peff.net ([208.65.91.99]:58989 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbZAEGBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 01:01:02 -0500
Received: (qmail 11248 invoked by uid 107); 5 Jan 2009 06:01:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Jan 2009 01:01:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Jan 2009 01:00:58 -0500
Content-Disposition: inline
In-Reply-To: <m3tz8e32ru.fsf@multivac.cwru.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104564>

On Sun, Jan 04, 2009 at 09:27:41PM -0500, Paul Jarc wrote:

> In a couple of tests, configure clobbers the LDFLAGS value set by the
> caller.  This patch fixes it.

Thanks for the patch. It looks obviously correct to me, and the problem
was just some typos introduced by 798a9450.

Junio, I think this should go onto maint.

> (I'm not subscribed; Mail-Followup-To set.)

The usual behavior on this list is to reply to the sender, cc'ing the
list and any previous to or cc's. So MFT is unnecessary and generally
frowned upon here.

Also, if you are planning on sending more patches, the usual practice is
for them to be inline rather than attached, with the commit message as
the body and any cover letter (like MFT discussion) after the
triple-dash; git format-patch will generate this format for you.  More
information is in Documentation/SubmittingPatches.

-Peff
