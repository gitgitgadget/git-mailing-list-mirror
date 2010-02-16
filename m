From: Jeff King <peff@peff.net>
Subject: Re: Fatal error running status in new repo
Date: Tue, 16 Feb 2010 01:47:53 -0500
Message-ID: <20100216064753.GD2169@coredump.intra.peff.net>
References: <20100216041945.GB10296@vfb-9.home>
 <20100216060528.GB2169@coredump.intra.peff.net>
 <20100216062422.GC10296@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhHDz-0003D5-PZ
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210Ab0BPGrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:47:55 -0500
Received: from peff.net ([208.65.91.99]:49449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754122Ab0BPGry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:47:54 -0500
Received: (qmail 30055 invoked by uid 107); 16 Feb 2010 06:48:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 01:48:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 01:47:53 -0500
Content-Disposition: inline
In-Reply-To: <20100216062422.GC10296@vfb-9.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140075>

On Mon, Feb 15, 2010 at 10:24:22PM -0800, Jacob Helwig wrote:

> $ GIT_TRACE=1 git status
> trace: built-in: git 'status'
> # On branch master
> #
> # Initial commit
> #
> trace: run_command: 'submodule' 'summary' '--cached' '--for-status' '--summary-limit' '-1' 'HEAD'

Ah, OK. That is why I did not see it; I don't have submodulesummary
turned on.

I can reproduce your problem. The messages are actually from two
different spots. The first is actually a bug in the code I mentioned
earlier, and I'm still tracking down the second. Patches in a moment.

-Peff
