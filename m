From: Jeff King <peff@peff.net>
Subject: Re: git checkout branch puzzle
Date: Mon, 3 May 2010 02:40:53 -0400
Message-ID: <20100503064053.GA20002@coredump.intra.peff.net>
References: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10>
 <20100502045901.GD14776@coredump.intra.peff.net>
 <Xns9D6C65C2DB06EChrisCheneytesconet@80.91.229.10>
 <Xns9D6CD773D97E5ChrisCheneytesconet@80.91.229.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
X-From: git-owner@vger.kernel.org Mon May 03 08:41:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8pKx-0002O3-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 08:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910Ab0ECGk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 02:40:58 -0400
Received: from peff.net ([208.65.91.99]:46612 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab0ECGk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 02:40:57 -0400
Received: (qmail 20789 invoked by uid 107); 3 May 2010 06:41:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 03 May 2010 02:41:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 May 2010 02:40:53 -0400
Content-Disposition: inline
In-Reply-To: <Xns9D6CD773D97E5ChrisCheneytesconet@80.91.229.10>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146217>

On Sun, May 02, 2010 at 08:09:32PM +0000, Chris.Cheney wrote:

> > Thanks for the reply and confirming what I believed about (c). 
> > 
> > It is possible that what you suggest might be involved - it's a
> > 2-developer situation, each using msysgit with their own local
> > repository and a remote master (bare) repository. I'll compare the
> > other's config file against mine.
> 
> Neither of our config files contain autocrlf settings, but it's something 
> that I'll look further into. Neither of us had made recent config changes.

I believe autocrlf is on by default for msysgit. But if there is nothing
in your config, then probably nothing changed. If you can reproduce the
situation, it might be worth narrowing down a simple test case and
posting the exact commands and output.

-Peff
