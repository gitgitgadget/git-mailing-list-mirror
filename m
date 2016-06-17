Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E8620179
	for <e@80x24.org>; Fri, 17 Jun 2016 23:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbcFQXiX (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:38:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:56447 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbcFQXiW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 19:38:22 -0400
Received: (qmail 8111 invoked by uid 102); 17 Jun 2016 23:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:22 -0400
Received: (qmail 30230 invoked by uid 107); 17 Jun 2016 23:38:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Jun 2016 19:38:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Jun 2016 19:38:20 -0400
Date:	Fri, 17 Jun 2016 19:38:20 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/7] gpg-interface cleanups
Message-ID: <20160617233819.GA31909@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160616093248.GA15130@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 05:32:48AM -0400, Jeff King wrote:

>   [1/7]: gpg-interface: use child_process.args
>   [2/7]: verify_signed_buffer: drop pbuf variable
>   [3/7]: verify_signed_buffer: use tempfile object
>   [4/7]: run-command: add pipe_command helper
>   [5/7]: verify_signed_buffer: use pipe_command
>   [6/7]: sign_buffer: use pipe_command
>   [7/7]: gpg-interface: check gpg signature creation status

Here's a re-roll, fixing a few things in 4/7:

  - s/capture/pipe/ in the pipe_command docstring, from Eric

  - make internal pump_io functions static, from Ramsay

and more importantly:

  - I screwed up the in-body "From:" in the final patch; Michael should
    be the author

-Peff
