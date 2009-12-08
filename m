From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Tue, 8 Dec 2009 00:57:35 -0500
Message-ID: <20091208055735.GA9951@coredump.intra.peff.net>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsz9qxj.fsf@alter.siamese.dyndns.org>
 <20091207210608.6117@nanako3.lavabit.com>
 <7vein635vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 06:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHt5D-0001Qi-Lk
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 06:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbZLHF5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 00:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbZLHF5e
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 00:57:34 -0500
Received: from peff.net ([208.65.91.99]:45096 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbZLHF5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 00:57:32 -0500
Received: (qmail 7844 invoked by uid 107); 8 Dec 2009 06:02:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Dec 2009 01:02:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Dec 2009 00:57:35 -0500
Content-Disposition: inline
In-Reply-To: <7vein635vn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134816>

On Mon, Dec 07, 2009 at 12:07:24PM -0800, Junio C Hamano wrote:

> I haven't asked people why they choose to write like this:
> 
> 	char* string;
> 
> beyond "that is how we were taught and what we are used to".

I have seen it in C++ code and recommended many years ago on
comp.lang.c++. The argument was something along the lines of:

  1. It's good to keep type information together, especially in C++
     where you are often doing things like using types as template
     parameters.

  2. The fact that "char* foo, bar" doesn't do what you want isn't
     relevant if you have a style guideline not to declare two variables
     on the same line (because it's easier to notice both if they each
     get their own line, and because in C++ you can declare closer to
     the point of use).

But that is me paraphrasing an argument I read on usenet almost 10 years
ago, so I may be entirely misremembering (and please don't flame me; I
am presenting it for anthropological curiosity, not because I believe we
should use that style).

-Peff
