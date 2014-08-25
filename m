From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Mon, 25 Aug 2014 15:33:58 -0400
Message-ID: <20140825193358.GG30953@peff.net>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <xmqqvbpgl638.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 21:34:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM01k-0003fb-P8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 21:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322AbaHYTeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 15:34:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:58638 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933253AbaHYTd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 15:33:59 -0400
Received: (qmail 31938 invoked by uid 102); 25 Aug 2014 19:33:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 14:33:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 15:33:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbpgl638.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255856>

On Mon, Aug 25, 2014 at 12:30:51PM -0700, Junio C Hamano wrote:

> Also interestingly, I notice that it is very clear that it is not
> "LIB_H" but "ANY_H" ;-)

Yeah, it has been that way for quite a while. I don't know if it is that
big a deal, but it would not be unreasonable to do a patch to rename on
top (I am not sure what the new one would be; ANY_H is probably OK).

-Peff
