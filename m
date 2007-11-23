From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 23 Nov 2007 05:30:03 -0500
Message-ID: <20071123103003.GB6754@sigill.intra.peff.net>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <7vfxz89x9q.fsf@gitster.siamese.dyndns.org> <7vabpctx3b.fsf@gitster.siamese.dyndns.org> <7vsl30eyuk.fsf@gitster.siamese.dyndns.org> <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 11:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVnn-0007UB-1q
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXKWKaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 05:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbXKWKaI
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:30:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3455 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752859AbXKWKaH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:30:07 -0500
Received: (qmail 30275 invoked by uid 111); 23 Nov 2007 10:30:05 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 23 Nov 2007 05:30:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Nov 2007 05:30:03 -0500
Content-Disposition: inline
In-Reply-To: <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65892>

On Fri, Nov 23, 2007 at 12:48:25AM -0800, Junio C Hamano wrote:

> * jk/send-pack (Tue Nov 20 06:18:01 2007 -0500) 29 commits
>  + send-pack: cluster ref status reporting

Did we decide that printing the "maybe you need to pull" hint is not
worth doing?

> * jk/rename (Tue Oct 30 00:24:42 2007 -0400) 3 commits
>  . handle renames using similarity engine
>  . introduce generic similarity library
>  . change hash table calling conventions
> 
> This was an attempt to use different strategy to speed up
> similarity computation, but does not work quite well as is.

This is still on my long-term todo list, but obviously needs quite a bit
of cleanup. Eventually I will get around to it.

I wonder if it is worth dropping from 'pu'. It doesn't pass the tests,
making it harder to play with other pu topics, and it is not being
actively worked on or tested by anyone.

-Peff
