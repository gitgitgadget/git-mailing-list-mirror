From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 0/4] Some cleanups
Date: Thu, 31 Mar 2016 15:12:52 -0400
Message-ID: <20160331191252.GB5013@sigill.intra.peff.net>
References: <1459447446-32260-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sunshine@sunshineco.com, gitster@pobox.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:13:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ali1b-0006ln-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 21:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847AbcCaTM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 15:12:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:41846 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752206AbcCaTMz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 15:12:55 -0400
Received: (qmail 7510 invoked by uid 102); 31 Mar 2016 19:12:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:12:55 -0400
Received: (qmail 16658 invoked by uid 107); 31 Mar 2016 19:12:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 15:12:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 15:12:52 -0400
Content-Disposition: inline
In-Reply-To: <1459447446-32260-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290450>

On Thu, Mar 31, 2016 at 11:04:02AM -0700, Stefan Beller wrote:

> v3:
> Thanks Eric, Jeff, Junio for discussion!
> * use git_config_get_value instead of git_config_get_string in patch 1
> * Improve commit message to explain why strbuf_list_free frees more memory
>   (hence is the right thing to do)
> * the bundle code doesn't have a dedicated return variable,
>   but the error path always returns -1  
> * removed a duplicate of
>         +	if (!bundle_to_stdout)
>         +		close(bundle_fd);
>   in the bundle patch.
> * This applies on v2.8.0.

With the exception of the comments on patch 3, these all look good. I'll
leave it to Junio to decide whether he wants to polish up his "get rid
of strbuf_split" patch for patch 2. Certainly yours is a strict
improvement over what is there.

-Peff
