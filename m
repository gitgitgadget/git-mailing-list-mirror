From: Jeff King <peff@peff.net>
Subject: Re: CRLF support bugs (was: Re: .gitattributes glob matchingbroken)
Date: Tue, 4 Nov 2008 22:07:03 -0500
Message-ID: <20081105030702.GD20907@coredump.intra.peff.net>
References: <83od0yaxzk.fsf@kalahari.s2.org> <20081103090932.GA18424@coredump.intra.peff.net> <83y700alzf.fsf_-_@kalahari.s2.org> <20081104051432.GD31276@coredump.intra.peff.net> <63BEA5E623E09F4D92233FB12A9F79430296676E@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 04:08:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxYkn-0002vd-Vr
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 04:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146AbYKEDHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 22:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYKEDHH
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 22:07:07 -0500
Received: from peff.net ([208.65.91.99]:1568 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092AbYKEDHG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 22:07:06 -0500
Received: (qmail 11521 invoked by uid 111); 5 Nov 2008 03:07:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 04 Nov 2008 22:07:04 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2008 22:07:03 -0500
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F79430296676E@emailmn.mqsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100138>

On Tue, Nov 04, 2008 at 06:37:27AM -0600, Kelly F. Hickel wrote:

> From my point of view, the factoid that a particular file should be
> subjected to having its line endings munged is a _project_ decision.
> Whether or not to munge them on any given platform is a _local_
> decision.

Now that you spell it out, I am reminded that that is the argument I
remember having seen in past discussions. And of course, that argues for
.gitattributes being carried by the project, but the core.autocrlf
_config_ being a local decision.

Which, perhaps not coincidentally, is how it is currently implemented. :)

-Peff
