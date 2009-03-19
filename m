From: Jeff King <peff@peff.net>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Thu, 19 Mar 2009 00:04:02 -0400
Message-ID: <20090319040402.GB32435@coredump.intra.peff.net>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com> <20090318005413.GC25454@coredump.intra.peff.net> <49C0C769.8020401@drmicha.warpmail.net> <76718490903181411p743382f1qb053363f28a800b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Tom Preston-Werner <tom@github.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 05:06:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk9WD-0007Ke-46
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 05:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbZCSEEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZCSEEL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 00:04:11 -0400
Received: from peff.net ([208.65.91.99]:45834 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbZCSEEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 00:04:11 -0400
Received: (qmail 29393 invoked by uid 107); 19 Mar 2009 04:04:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Mar 2009 00:04:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2009 00:04:02 -0400
Content-Disposition: inline
In-Reply-To: <76718490903181411p743382f1qb053363f28a800b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113711>

On Wed, Mar 18, 2009 at 05:11:25PM -0400, Jay Soffian wrote:

> I think there are two reasonable paths forward:
> 
> 1) Address Jeff's concerns above so that the symref can be sent.
> 2) In lieu of (1), have clone at least warn that multiple branches
> match and that it just picked one.

I think we should do (2) regardless. Even with an updated client,
remote servers may have an older git which does not support (1) for some
time.

So I guess it's time to refactor guess_remote_head _again_. :)

-Peff
