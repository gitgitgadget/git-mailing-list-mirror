From: Jeff King <peff@peff.net>
Subject: Re: Newbie Query
Date: Tue, 20 Jan 2009 18:51:25 -0500
Message-ID: <20090120235125.GD17746@coredump.intra.peff.net>
References: <20090120191952.GA25322@uts.thewillards.local> <3f4fd2640901201217x22262655w115cc2a25e32865e@mail.gmail.com> <49763D2B.1000607@morey-chaisemartin.com> <200901201534.16571.bss@iguanasuicide.net> <49764647.1080606@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 00:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQOq-0000dv-EH
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 00:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbZATXv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 18:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756826AbZATXv2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 18:51:28 -0500
Received: from peff.net ([208.65.91.99]:44448 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756460AbZATXv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 18:51:27 -0500
Received: (qmail 5393 invoked by uid 107); 20 Jan 2009 23:51:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Jan 2009 18:51:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2009 18:51:25 -0500
Content-Disposition: inline
In-Reply-To: <49764647.1080606@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106541>

On Tue, Jan 20, 2009 at 10:46:47PM +0100, Nicolas Morey-Chaisemartin wrote:

> Well I know there are solutions to convert it to a bare repo.
> I was just wondering if there was a "clean" one which really converts
> the repo to a bare one and not create a copy which is bare.

It has been a long time since I have done this. It used to be that you
could simply "mv foo/.git foo.git" and be done with it. These days I
think you would also need "git config core.bare true". But I haven't
actually tested it recently.

You may also want to tweak other config settings (e.g., bare
repositories do not generally have reflogs turned on, but non-bare do).

-Peff
