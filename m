From: Jeff King <peff@peff.net>
Subject: Re: git commit -v does not removes the patch
Date: Mon, 10 Nov 2008 19:07:06 -0500
Message-ID: <20081111000706.GA26223@coredump.intra.peff.net>
References: <adf1fd3d0811100720n52ac1d47id9b7f402412aa0d3@mail.gmail.com> <20081110181023.GA22753@coredump.intra.peff.net> <adf1fd3d0811101434j658b2e8aj83d8cbe2293f5021@mail.gmail.com> <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 01:09:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzgo2-0000b0-Il
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 01:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbYKKAHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 19:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbYKKAHK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 19:07:10 -0500
Received: from peff.net ([208.65.91.99]:2576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbYKKAHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 19:07:09 -0500
Received: (qmail 9750 invoked by uid 111); 11 Nov 2008 00:07:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 10 Nov 2008 19:07:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2008 19:07:06 -0500
Content-Disposition: inline
In-Reply-To: <7vej1j40x5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100603>

On Mon, Nov 10, 2008 at 03:27:18PM -0800, Junio C Hamano wrote:

> > It is exactly as you described. I'll try in other systems.
> 
> Guess in the dark... by any chance are you enabling color unconditionally?

I thought I covered that case explicitly...

...yes, I can't reproduce with color set to "always". And indeed,
looking at the diff for 4f672ad shows that we always turn off color for
the message that goes to the editor (since we can't trust our isatty
setting _anyway_, since we're not going to the tty).

So that's not it.

-Peff
