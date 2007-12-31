From: Jeff King <peff@peff.net>
Subject: Re: [bug] Working files created in bare repository when pushing to
	a rewound bare repository
Date: Mon, 31 Dec 2007 02:07:50 -0500
Message-ID: <20071231070749.GB4250@coredump.intra.peff.net>
References: <46dff0320712302242m34b5267dlb3f26488293d5d51@mail.gmail.com> <20071231064741.GA4250@coredump.intra.peff.net> <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 08:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9El1-0000E6-Bu
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 08:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbXLaHHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 02:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbXLaHHw
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 02:07:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2034 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710AbXLaHHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 02:07:52 -0500
Received: (qmail 1120 invoked by uid 111); 31 Dec 2007 07:07:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 31 Dec 2007 02:07:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Dec 2007 02:07:50 -0500
Content-Disposition: inline
In-Reply-To: <46dff0320712302302p4c125ee1n2abc1561ba10c47e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69390>

On Mon, Dec 31, 2007 at 03:02:25PM +0800, Ping Yin wrote:

> Sorry for my inattention. However, i remembered the reason i added
> '--hard' is to avoid  the warn 'foo.txt: needs update'  when 'git
> reset HEAD^'. Now i know  '--soft' will do the right thing.
> 
> So how about use '--soft' as default in the bare repository?

I started on this when I realized that --soft doesn't even work. I
remember posting a patch to make --soft work in a bare repo when
git-reset was still a script. However, Junio indicated that using "git
branch -f" is the recommended workflow. Perhaps git-reset should be
disabled in bare repos totally?

-Peff
