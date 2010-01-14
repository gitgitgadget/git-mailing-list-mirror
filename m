From: Jeff King <peff@peff.net>
Subject: Re: Removal of post-upload-hook
Date: Thu, 14 Jan 2010 15:43:05 -0500
Message-ID: <20100114204305.GC26883@coredump.intra.peff.net>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
 <20100114193607.GB25863@coredump.intra.peff.net>
 <20100114194107.GA20033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Arun Raghavan <ford_prefect@gentoo.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:43:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVWXC-0007ZJ-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 21:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337Ab0ANUnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 15:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306Ab0ANUnJ
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 15:43:09 -0500
Received: from peff.net ([208.65.91.99]:57894 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227Ab0ANUnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 15:43:09 -0500
Received: (qmail 14859 invoked by uid 107); 14 Jan 2010 20:47:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 14 Jan 2010 15:47:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2010 15:43:05 -0500
Content-Disposition: inline
In-Reply-To: <20100114194107.GA20033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137022>

On Thu, Jan 14, 2010 at 11:41:07AM -0800, Shawn O. Pearce wrote:

> > Because receive-pack runs as the user who is pushing, not as the
> > repository owner. So by convincing you to push to my repository in a
> > multi-user environment, I convince you to run some arbitrary code of
> > mine.
> 
> Uhhh, this was in fetch/upload-pack Peff, not push/receive-pack.
> 
> Same issue though.

Errr...yeah. Sorry for the confusion. But yes, it's the same mechanism,
except that it is even easier to get people to pull from you (to get
them to push, you first have to get them to write a worthwhile code
contribution. ;) ).

-Peff
