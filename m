From: Jeff King <peff@peff.net>
Subject: Re: git checkout branch puzzle
Date: Sun, 2 May 2010 00:59:01 -0400
Message-ID: <20100502045901.GD14776@coredump.intra.peff.net>
References: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Chris.Cheney" <chris.cheney.nospam@tesco.net>
X-From: git-owner@vger.kernel.org Sun May 02 06:59:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8RGq-0008P7-9B
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 06:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0EBE7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 00:59:07 -0400
Received: from peff.net ([208.65.91.99]:40375 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0EBE7F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 00:59:05 -0400
Received: (qmail 3678 invoked by uid 107); 2 May 2010 04:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 00:59:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 00:59:01 -0400
Content-Disposition: inline
In-Reply-To: <Xns9D6BC0C4C8784ChrisCheneytesconet@80.91.229.10>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146134>

On Sat, May 01, 2010 at 05:55:47PM +0000, Chris.Cheney wrote:

> I have been using msysgit (curently 1.7.0.2.msysgit.0) for about 18 months 
> and thought that I had managed to understand most things. However, the 
> following sequence has me baffled:
> 
> a) on branch 'master', git status shows that the working directory is clean
> 
> b) git checkout HEAD^ gives the usual moan about moving to a head which 
> isn't a local branch
> 
> c) git checkout master followed by git status gives "changed but not 
> updated" and a list of "modified" files

Part (c) shouldn't show anything in "git status". I wonder if it is a
line-ending conversion issue, since you are using msysgit, and since
that is the usual culprit for files mysteriously looking changed. Might
you have recently changed the settings of core.autocrlf?

-Peff
