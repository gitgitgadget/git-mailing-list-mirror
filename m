From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t6024-recursive-merge.sh: hide spurious output when
	not running verbosely
Date: Fri, 29 Feb 2008 18:54:43 -0500
Message-ID: <20080229235442.GA20028@sigill.intra.peff.net>
References: <1204323805-23185-1-git-send-email-mh@glandium.org> <20080229225331.GA8440@coredump.intra.peff.net> <20080229225816.GA24892@glandium.org> <7vfxvbbbhn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:55:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVF4U-0001dO-AC
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 00:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbYB2Xyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 18:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758964AbYB2Xyq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 18:54:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3832 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760658AbYB2Xyp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 18:54:45 -0500
Received: (qmail 13001 invoked by uid 111); 29 Feb 2008 23:54:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 29 Feb 2008 18:54:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Feb 2008 18:54:43 -0500
Content-Disposition: inline
In-Reply-To: <7vfxvbbbhn.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75594>

On Fri, Feb 29, 2008 at 03:15:32PM -0800, Junio C Hamano wrote:

> >> >  test_expect_success 'refuse to merge binary files' '
> >> >  	printf "\0" > binary-file &&
> >> >  	git add binary-file &&
> >> 
> >> Should this perhaps just be:
> >> 
> >>   test_expect_success 'reset state' 'git reset --hard'
> >
> > Is it really about testing git reset ?
> 
> No, it is about setting the stage to perform the test in
> question, so it belongs inside.

That sounds reasonable to me.

-Peff
