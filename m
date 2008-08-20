From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] feeding Maildir to git-am
Date: Wed, 20 Aug 2008 09:03:43 -0400
Message-ID: <20080820130342.GA6602@coredump.intra.peff.net>
References: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 15:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVnMu-0003NG-8m
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 15:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYHTNDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 09:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754211AbYHTNDr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 09:03:47 -0400
Received: from peff.net ([208.65.91.99]:3593 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbYHTNDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 09:03:46 -0400
Received: (qmail 22758 invoked by uid 111); 20 Aug 2008 13:03:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Aug 2008 09:03:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 09:03:43 -0400
Content-Disposition: inline
In-Reply-To: <7vbpzotfyy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92986>

On Tue, Aug 19, 2008 at 10:25:57PM -0700, Junio C Hamano wrote:

> I do not use Maildir myself but people who do not know how Maildir look
> like (including myself) would be left wondering why there is even no error
> message when giving a random directory full of format-patch output to am.

I don't use maildirs with git, but I have worked with them in the past,
and I think your patch is definitely an improvement.

However, I wonder if we could go one step further and just DWYM: if a
directory has "cur" or "new", treat it like a maildir (IOW, look in
there for patches), but otherwise treat it like a directory of
format-patch output.

-Peff
