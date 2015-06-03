From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] auto-detect getdelim()
Date: Wed, 3 Jun 2015 00:35:32 -0400
Message-ID: <20150603043532.GB15989@peff.net>
References: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 06:40:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z00TP-00085b-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 06:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbbFCEff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 00:35:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40166 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750888AbbFCEff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 00:35:35 -0400
Received: (qmail 28863 invoked by uid 102); 3 Jun 2015 04:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Jun 2015 23:35:35 -0500
Received: (qmail 15849 invoked by uid 107); 3 Jun 2015 04:35:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 00:35:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 00:35:32 -0400
Content-Disposition: inline
In-Reply-To: <1433279744-23379-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270625>

On Tue, Jun 02, 2015 at 05:15:42PM -0400, Eric Sunshine wrote:

> This series updates config.mak.uname to define HAVE_GETDELIM on Mac OS X
> when appropriate, and adds a configure check for the same.
> 
> Changes since v1[1]:
> 
> patch 1/2 -- optimize OS X version recognition:
> 
> * Use `...` for 'expr' invocation to extract digits from $(uname_R),
>   thus only a fork(), rather than gmake $(shell...), which spawns via
>   fork()+exec().
> 
> * Use 'test' relational operator -ge rather than 'expr >=', along with
>   'echo' to compare version number. Since 'test' and 'echo' are
>   typically shell builtins, this should be faster than invoking 'expr' a
>   second time.
> 
> patch 2/2 -- unchanged

Thanks, this version looks good to me.

-Peff
