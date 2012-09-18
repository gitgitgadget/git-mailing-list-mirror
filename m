From: Jeff King <peff@peff.net>
Subject: Re: How to create the " [PATCH 0/5]" first email?
Date: Mon, 17 Sep 2012 20:15:22 -0400
Message-ID: <20120918001522.GA10283@sigill.intra.peff.net>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <F93DBBE1DDAA44A28C9020F9A58FD825@PhilipOakley>
 <7vzk4rz00y.fsf@alter.siamese.dyndns.org>
 <98180D4AA94C468887029389CC535D4F@PhilipOakley>
 <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDlTS-0000g1-NA
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 02:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab2IRAP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 20:15:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46949 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab2IRAPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 20:15:25 -0400
Received: (qmail 15672 invoked by uid 107); 18 Sep 2012 00:15:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 20:15:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 20:15:22 -0400
Content-Disposition: inline
In-Reply-To: <7vfw6gqkfg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205773>

On Mon, Sep 17, 2012 at 04:49:39PM -0700, Junio C Hamano wrote:

> > However, when it came to creating the series, with comments, I
> > couldn't see a way of having my comments within my local commits, but
> > preparing a patch series that would properly include the '---'
> > separator.
> 
> An unofficial trick that works is to write the
> 
>     ---
> 
>      * This is an additional comment
> 
> 
> yourself when running "git commit".  That will be propagated to the
> output from format-patch.  You will have another "---" in front of
> the diffstat, but nobody is hurt by that.

But note that using "format-patch -s" will break; it puts the sign-off
below the "---".

> But when doing a big series that deserves a cover letter [PATCH 0/n],
> you will use editor on the output from format-patch anyway, and I
> find it simpler to do the follow-on comments at that point myself.

Me too (actually, I load it all into mutt and then comment on each as I
send them out, but it amounts to the same thing, seeing as how my MUA
just invokes $EDITOR when I edit a mail).

-Peff
