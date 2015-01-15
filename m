From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] pack-bitmap.c: make pack_bitmap_filename() static
Date: Thu, 15 Jan 2015 01:51:35 -0500
Message-ID: <20150115065134.GE11028@peff.net>
References: <1421278855-8126-1-git-send-email-gitster@pobox.com>
 <1421278855-8126-9-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:51:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBeHO-0003MS-5a
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbbAOGvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:51:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:34821 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750782AbbAOGvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:51:37 -0500
Received: (qmail 20769 invoked by uid 102); 15 Jan 2015 06:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 00:51:38 -0600
Received: (qmail 10482 invoked by uid 107); 15 Jan 2015 06:51:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Jan 2015 01:51:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Jan 2015 01:51:35 -0500
Content-Disposition: inline
In-Reply-To: <1421278855-8126-9-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262462>

On Wed, Jan 14, 2015 at 03:40:53PM -0800, Junio C Hamano wrote:

>  pack-bitmap.c | 28 ++++++++++++++--------------
>  pack-bitmap.h |  1 -
>  2 files changed, 14 insertions(+), 15 deletions(-)

Looks good. I have some other not-yet-public bitmap stuff to send
pending cleanup and testing, but I checked and none of it cares about
this function.

-Peff
