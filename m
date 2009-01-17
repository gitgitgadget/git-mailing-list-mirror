From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so
	that editors can recognize, it as a bash script. Also adds a few
	simple comments above commands that, take arguments. The comments
	are meant to remind editors of potential, problems that
Date: Sat, 17 Jan 2009 10:21:08 -0500
Message-ID: <20090117152108.GA24899@coredump.intra.peff.net>
References: <2faad3050901160706y297a98d4r35340e4811ca3d2b@mail.gmail.com> <20090117014057.GA15331@coredump.intra.peff.net> <200901171337.49938.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Baz <brian.ewins@gmail.com>,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:22:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOD0N-0001yl-V4
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbZAQPVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 10:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758182AbZAQPVL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:21:11 -0500
Received: from peff.net ([208.65.91.99]:51089 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758212AbZAQPVK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 10:21:10 -0500
Received: (qmail 31549 invoked by uid 107); 17 Jan 2009 15:21:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Jan 2009 10:21:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jan 2009 10:21:08 -0500
Content-Disposition: inline
In-Reply-To: <200901171337.49938.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106058>

On Sat, Jan 17, 2009 at 01:37:48PM +0100, Markus Heidelberg wrote:

> > Personally, I find --pretty=oneline unreadable because so much of the
> > screen real estate is wasted on random characters that I don't care
> > about. I find --pretty=tformat:'%h %s' much nicer
> 
> But it doesn't automatically color the SHA1.

True. I was going to suggest %Cyellow, but for some reason only red,
green, and blue are implemented. How silly. Patch series to follow.

-Peff
