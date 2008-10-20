From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix multiple issues in index-pack
Date: Mon, 20 Oct 2008 16:56:49 -0400
Message-ID: <20081020205649.GA21859@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:39:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks1pC-0004AP-JM
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645AbYJTU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755641AbYJTU4w
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:56:52 -0400
Received: from peff.net ([208.65.91.99]:2691 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755634AbYJTU4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:56:51 -0400
Received: (qmail 16021 invoked by uid 111); 20 Oct 2008 20:56:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 16:56:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 16:56:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201609300.26244@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98731>

On Mon, Oct 20, 2008 at 04:46:19PM -0400, Nicolas Pitre wrote:

>  2( The code sequence:
> 
>         result->data = patch_delta(get_base_data(base), base->obj->size,
>                                    delta_data, delta_size, &result->size);
> 
>     has two issues of its own since base->obj->size should instead be
>     base->size as we want the size of the actual object data and not
>     the size of the delta object it is represented by.  Except that 

This one fixes my problem.

Tested-by: Jeff King <peff@peff.net>

-Peff
