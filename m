From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: Print a message describing the number of
	threads for packing
Date: Tue, 26 Feb 2008 03:06:34 -0500
Message-ID: <20080226080634.GA4129@coredump.intra.peff.net>
References: <47B1BEC6.6080906@nrlssc.navy.mil> <1203732369-30314-1-git-send-email-casey@nrlssc.navy.mil> <47BF812A.4020205@nrlssc.navy.mil> <20080226074933.GA3485@coredump.intra.peff.net> <7vhcfwb116.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 09:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTuqZ-0001mz-RV
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 09:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbYBZIGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 03:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755661AbYBZIGh
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 03:06:37 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2204 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712AbYBZIGg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 03:06:36 -0500
Received: (qmail 24007 invoked by uid 111); 26 Feb 2008 08:06:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Feb 2008 03:06:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Feb 2008 03:06:34 -0500
Content-Disposition: inline
In-Reply-To: <7vhcfwb116.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75109>

On Tue, Feb 26, 2008 at 12:00:05AM -0800, Junio C Hamano wrote:

> >> +	if (progress)
> >> +		fprintf(stderr, "Using %d pack threads.\n",
> >> +			delta_search_threads);
> >
> > I just noticed that this was in next.
> 
> Please send in a fix-up patch to remove it.  I noticed it while
> reviewing the patch, and even commented on it, but I somehow
> forgot that this leftover debugging message disqualified the
> series from 'next' when I was merging topics to 'next'.

Are you sure you are thinking of the same message? This one was
submitted in a patch by itself, and I didn't see any followup
discussion. It's in next as:

  6c723f5 pack-objects: Print a message describing the number of
          threads for packing

-Peff
