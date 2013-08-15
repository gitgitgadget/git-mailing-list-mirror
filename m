From: Jeff King <peff@peff.net>
Subject: Re: Bug: commit -p breaks with -m
Date: Thu, 15 Aug 2013 13:31:58 -0400
Message-ID: <20130815173158.GA27866@sigill.intra.peff.net>
References: <6EC98F2F-98FC-439B-BD9C-B1D0DB1F5E10@gmail.com>
 <20130815121635.GB22102@sigill.intra.peff.net>
 <7v1u5usw27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matan Nassau <matan.nassau@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 19:32:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA1P7-0007LR-MP
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 19:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016Ab3HORcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 13:32:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:48753 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758398Ab3HORcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 13:32:03 -0400
Received: (qmail 3329 invoked by uid 102); 15 Aug 2013 17:32:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Aug 2013 12:32:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Aug 2013 13:31:58 -0400
Content-Disposition: inline
In-Reply-To: <7v1u5usw27.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232355>

On Thu, Aug 15, 2013 at 10:28:16AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Unfortunately, I think that will require some refactoring of the
> > run_hook interface, which does not allow arbitrary environment
> > parameters to be set.
> 
> Heh, I said that long time ago, e.g. $gmane/212284 ;-)
> 
> This might turn out to be a good starting point, even though I
> didn't read it again before sending this message.
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/192669/focus=192806

Looking at both of those messages, I agree completely. I even started
to sketch out the refactoring when I sent the previous message, and it
looked a lot like the patch you sent.

-Peff
