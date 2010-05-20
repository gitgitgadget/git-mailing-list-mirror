From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6 v2] Make git log --graph looks better with -p and
 other diff options
Date: Thu, 20 May 2010 08:36:50 -0400
Message-ID: <20100520123650.GA7665@sigill.intra.peff.net>
References: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 14:38:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF50k-0002d1-LS
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 14:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab0ETMgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 May 2010 08:36:55 -0400
Received: from peff.net ([208.65.91.99]:38459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab0ETMgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 May 2010 08:36:54 -0400
Received: (qmail 12536 invoked by uid 107); 20 May 2010 12:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 20 May 2010 08:36:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 May 2010 08:36:51 -0400
Content-Disposition: inline
In-Reply-To: <1274351138-11813-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147385>

On Thu, May 20, 2010 at 03:25:32AM -0700, Bo Yang wrote:

> When we run git log --graph with any other diff output function, such as '-p','--check','--numstat' or other diff optoins, the diff output area have no graph lines ahead of it. And this make the text graph looks strange.
> The following 7 patches try to deal with this, and put the text graph
> columns before all the diff output lines.

This is very cool. "git log --graph --oneline --stat" is interesting to
see. It seems to work fine with "-p", "--stat", and "--raw". But try:

  git log --graph --oneline --summary 212f0ba

Summary lines for some reason don't get properly indented or prefixed
with branch lines.

-Peff
