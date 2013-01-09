From: Jeff King <peff@peff.net>
Subject: Re: Enabling scissors by default?
Date: Wed, 9 Jan 2013 12:10:11 -0500
Message-ID: <20130109171011.GB5332@sigill.intra.peff.net>
References: <50EC92C6.7090509@ubuntu.com>
 <7vvcb7b8lc.fsf@alter.siamese.dyndns.org>
 <50ECAAE2.2020507@ubuntu.com>
 <7vr4lvb63a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phillip Susi <psusi@ubuntu.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TszAn-0000i1-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244Ab3AIRKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:10:19 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50798 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932229Ab3AIRKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:10:18 -0500
Received: (qmail 30486 invoked by uid 107); 9 Jan 2013 17:11:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jan 2013 12:11:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jan 2013 12:10:11 -0500
Content-Disposition: inline
In-Reply-To: <7vr4lvb63a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213070>

On Tue, Jan 08, 2013 at 03:36:09PM -0800, Junio C Hamano wrote:

> You could introduce a new configuration variable "am.scissors" and
> personally turn it on, though.  Setting that variable *does* count
> as the user explicitly asking for it.

I think we have mailinfo.scissors already.

> > I often see patches being tweaked in response to feedback and
> > resubmitted, usually with a description of what has changed since the
> > previous version.  Such descriptions don't need to be in the change
> > log when it is finally applied and seem a perfect use of scissors.
> 
> Putting such small logs under "---" line is the accepted practice.

Maybe it is just me, but I find the scissors form more readable, because
the "cover letter" material often serves to introduce and give context
to the patch (e.g., "Thanks for your feedback. I've tried to do X, and
it came out well. Here's the patch." serves as an introduction, and
logically comes before the commit message itself).

That does not say anything one way or another about how dangerous or not
it might be to enable scissors by default. Just my two cents that I like
the scissors style for patches that come as part of a discussion (and I
prefer the "---" style when making comments on the contents of a patch;
i.e., when the comments make more sense to be read after reading the
commit message to understand what the patch does).

-Peff
