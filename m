From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 15:53:31 -0400
Message-ID: <20130826195331.GA21051@sigill.intra.peff.net>
References: <1377528372-31206-1-git-send-email-hordp@cisco.com>
 <20130826192826.GA23598@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 21:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2rG-0007w1-4u
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab3HZTxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:53:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:39510 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab3HZTxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 15:53:35 -0400
Received: (qmail 28083 invoked by uid 102); 26 Aug 2013 19:53:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Aug 2013 14:53:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Aug 2013 15:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20130826192826.GA23598@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233016>

On Mon, Aug 26, 2013 at 03:28:26PM -0400, Jeff King wrote:

> Changing the object_array API would be hard, but I don't think we need
> to do it here. Can we simply stop using object_array to pass the list,
> and instead just have a custom list?
> 
> I'll see how painful that is.

Not very, I think. Here's the series.

  [1/2]: grep: stop using object_array
  [2/2]: grep: use slash for path delimiter, not colon

-Peff
