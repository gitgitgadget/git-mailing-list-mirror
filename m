From: Jeff King <peff@peff.net>
Subject: Re: PATH modifications for git-hook processes
Date: Thu, 16 Apr 2015 02:31:37 -0400
Message-ID: <20150416063137.GA7761@peff.net>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
 <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
 <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
 <20150416061732.GA5612@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthew Rothenberg <mroth@khanacademy.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 08:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidKz-0005XU-5B
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 08:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbbDPGbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 02:31:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:46043 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756785AbbDPGbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 02:31:40 -0400
Received: (qmail 15674 invoked by uid 102); 16 Apr 2015 06:31:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 01:31:40 -0500
Received: (qmail 22758 invoked by uid 107); 16 Apr 2015 06:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 02:32:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 02:31:37 -0400
Content-Disposition: inline
In-Reply-To: <20150416061732.GA5612@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267252>

On Thu, Apr 16, 2015 at 02:17:32AM -0400, Jeff King wrote:

> So it uses a special git-specific version of exec, and doesn't touch the
> PATH. Later, we did 231af83 (Teach the "git" command to handle some
> commands internally, 2006-02-26), which says at the end:
> 
>    There's one other change: the search order for external programs is
>    modified slightly, so that the first entry remains GIT_EXEC_DIR, but
>    the second entry is the same directory as the git wrapper itself was
>    executed out of - if we can figure it out from argv[0], of course.
> 
> There was some question of whether this would be a problem[1], but we
> realized it is OK due to 77cb17e, mentioned above.

I forgot to include my footnote, which was a link to the thread:

  http://thread.gmane.org/gmane.comp.version-control.git/16798

-Peff
