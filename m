From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file: move comment about return value where it
 belongs
Date: Mon, 28 Oct 2013 16:19:43 -0400
Message-ID: <20131028201942.GA21891@sigill.intra.peff.net>
References: <20131026223431.21409.92481.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 21:19:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VatHx-0000eL-QF
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 21:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab3J1UTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 16:19:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:57228 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756341Ab3J1UTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 16:19:45 -0400
Received: (qmail 13875 invoked by uid 102); 28 Oct 2013 20:19:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 15:19:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 16:19:43 -0400
Content-Disposition: inline
In-Reply-To: <20131026223431.21409.92481.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236857>

On Sun, Oct 27, 2013 at 12:34:30AM +0200, Christian Couder wrote:

> Commit 5b0864070 (sha1_object_info_extended: make type calculation
> optional, Jul 12 2013) changed the return value of the
> sha1_object_info_extended function to 0/-1 for success/error.
> 
> Previously this function returned the object type for success or
> -1 for error. But unfortunately the above commit forgot to change
> or move the comment above this function that says "returns enum
> object_type or negative".
> 
> To fix this inconsistency, let's move the comment above the
> sha1_object_info function where it is still true.

Thanks for catching this. Your analysis and patch looks good to me.

-Peff
