From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv4 0/9] Expose submodule parallelism to the user
Date: Fri, 20 Nov 2015 07:02:28 -0500
Message-ID: <20151120120228.GA15040@sigill.intra.peff.net>
References: <1447463222-12589-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 13:02:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzkOt-00034O-5M
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 13:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760011AbbKTMCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 07:02:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:60103 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759974AbbKTMCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 07:02:31 -0500
Received: (qmail 21914 invoked by uid 102); 20 Nov 2015 12:02:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 06:02:31 -0600
Received: (qmail 26936 invoked by uid 107); 20 Nov 2015 12:03:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Nov 2015 07:03:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Nov 2015 07:02:28 -0500
Content-Disposition: inline
In-Reply-To: <1447463222-12589-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281513>

On Fri, Nov 13, 2015 at 05:06:53PM -0800, Stefan Beller wrote:

> This replaces sb/submodule-parallel-update.
> It applies on top of d075d2604c0 (Merge branch
> 'rs/daemon-plug-child-leak' into sb/submodule-parallel-update,
> with additionally having merged submodule-parallel-fetch,
> which has applied "run-command: detect finished
> children by closed pipe rather than waitpid" on top of it.

Thanks for being detailed here. It makes a poor, inexperienced
maintainer's life much easier. :)

-Peff
