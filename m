From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2013, #02; Tue, 4)
Date: Wed, 5 Jun 2013 03:12:06 -0400
Message-ID: <20130605071206.GC14427@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <51AEE1C3.9020507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 05 09:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk7tH-0005JR-QW
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 09:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab3FEHML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 03:12:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:48195 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988Ab3FEHMK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 03:12:10 -0400
Received: (qmail 5784 invoked by uid 102); 5 Jun 2013 07:12:56 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 02:12:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 03:12:06 -0400
Content-Disposition: inline
In-Reply-To: <51AEE1C3.9020507@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226437>

On Wed, Jun 05, 2013 at 08:59:15AM +0200, Johannes Sixt wrote:

> Am 6/5/2013 1:45, schrieb Junio C Hamano:
> > * jk/test-exit-code-by-signal (2013-06-02) 1 commit
> >   (merged to 'next' on 2013-06-03 at 25af892)
> >  + t0005: test git exit code from signal death
> > 
> >  Will merge to 'master'.
> 
> I haven't gotten around to run this new test on Windows. I've reason to
> believe that it won't pass as is. Please don't let it graduate, yet.

Yeah, I sort of assumed that we would need to check for either "3" or
"131" on Windows, but I wasn't sure which. I don't think there is any
rush on it.

-Peff
