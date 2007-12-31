From: Jeff King <peff@peff.net>
Subject: Re: [bug] Working files created in bare repository when pushing to
	a rewound bare repository
Date: Mon, 31 Dec 2007 02:19:43 -0500
Message-ID: <20071231071943.GA10293@coredump.intra.peff.net>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com> <20071231064741.GA4250@coredump.intra.peff.net> <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com> <20071231070749.GB4250@coredump.intra.peff.net> <20071231071352.GC4250@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 08:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9EwV-0002E4-IR
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 08:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753142AbXLaHTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 02:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbXLaHTq
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 02:19:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3466 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753119AbXLaHTp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 02:19:45 -0500
Received: (qmail 1182 invoked by uid 111); 31 Dec 2007 07:19:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 31 Dec 2007 02:19:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Dec 2007 02:19:43 -0500
Content-Disposition: inline
In-Reply-To: <20071231071352.GC4250@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69392>

On Mon, Dec 31, 2007 at 02:13:52AM -0500, Jeff King wrote:

> +test_expect_success 'setup non-bare' '
> +	echo one >file &&
> +	git add file &&
> +	git commit -m one

This is of course missing a && at the end.

-Peff
