From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] fetch-pack: fix object_id of exact sha1
Date: Sat, 5 Mar 2016 11:59:47 -0500
Message-ID: <20160305165946.GA23114@sigill.intra.peff.net>
References: <20160304005000.GA1074@sigill.intra.peff.net>
 <1457140298-2400-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 17:59:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acFYb-0002wF-S4
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 17:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbcCEQ7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 11:59:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:55233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750704AbcCEQ7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 11:59:50 -0500
Received: (qmail 30293 invoked by uid 102); 5 Mar 2016 16:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 11:59:49 -0500
Received: (qmail 10761 invoked by uid 107); 5 Mar 2016 17:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 12:00:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 11:59:47 -0500
Content-Disposition: inline
In-Reply-To: <1457140298-2400-1-git-send-email-gabrielfrancosouza@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288314>

On Fri, Mar 04, 2016 at 10:11:38PM -0300, Gabriel Souza Franco wrote:

> Commit 58f2ed0 (remote-curl: pass ref SHA-1 to fetch-pack as well,
> 2013-12-05) added support for specifying a SHA-1 as well as a ref name.
> Add support for specifying just a SHA-1 and set the ref name to the same
> value in this case.
> 
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---
>  Documentation/git-fetch-pack.txt |  4 ++++
>  builtin/fetch-pack.c             | 16 +++++++++++++---
>  t/t5500-fetch-pack.sh            | 14 ++++++++++++++
>  3 files changed, 31 insertions(+), 3 deletions(-)

Thanks, this version looks good to me.

-Peff
