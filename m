From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sun, 8 Feb 2009 04:52:03 -0500
Message-ID: <20090208095203.GA12614@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net> <20090207064454.GB14906@coredump.intra.peff.net> <7vljsizog1.fsf@gitster.siamese.dyndns.org> <20090207114444.GB18079@coredump.intra.peff.net> <7viqnludiv.fsf@gitster.siamese.dyndns.org> <20090208085933.GB4392@coredump.intra.peff.net> <7vmycxz28s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 10:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6M2-0006ZX-Ks
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 10:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbZBHJwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 04:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbZBHJwH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 04:52:07 -0500
Received: from peff.net ([208.65.91.99]:47684 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbZBHJwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 04:52:06 -0500
Received: (qmail 26231 invoked by uid 107); 8 Feb 2009 09:52:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 04:52:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 04:52:03 -0500
Content-Disposition: inline
In-Reply-To: <7vmycxz28s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108940>

On Sun, Feb 08, 2009 at 01:50:27AM -0800, Junio C Hamano wrote:

> Oh, then the output format would, just like "grep" given more than one
> file tells which file it found the match in, talk about which path the
> output entry talks about when given more than one path.
> 
> Something like:
> 
> 	$ git check-ignore foo/bar xyzzy~ hello.c
> 	foo/bar: foo/.gitignore:4: ??r
>         xyzzy~: .git/info/excludes:22: *~

Right, exactly. What I was trying to say in my original message was that
my toy implementation _didn't_ do that, and it is a downside.

-Peff
