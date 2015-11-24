From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/git-update-index: add missing opts to
 synopsys
Date: Tue, 24 Nov 2015 15:46:03 -0500
Message-ID: <20151124204603.GE7174@sigill.intra.peff.net>
References: <1448366107-5179-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1KTa-0001ZR-Nm
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 21:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbbKXUqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 15:46:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:33404 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754701AbbKXUqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 15:46:07 -0500
Received: (qmail 21623 invoked by uid 102); 24 Nov 2015 20:46:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 14:46:05 -0600
Received: (qmail 18079 invoked by uid 107); 24 Nov 2015 20:46:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 15:46:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 15:46:03 -0500
Content-Disposition: inline
In-Reply-To: <1448366107-5179-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281628>

On Tue, Nov 24, 2015 at 12:55:07PM +0100, Christian Couder wrote:

> Untracked cache related options should appear in the synopsis.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-update-index.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index 1a296bc..3df9c26 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>  	     [--[no-]assume-unchanged]
>  	     [--[no-]skip-worktree]
>  	     [--ignore-submodules]
> +	     [--[no-|force-]untracked-cache]

Thanks, and it looks like they are already documented in the OPTIONS
section.

-Peff
