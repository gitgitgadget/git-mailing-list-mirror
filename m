From: Jeff King <peff@peff.net>
Subject: Re: Fatal: <hash> is corrupted can be caused by wrong permissions
Date: Sat, 25 Oct 2014 03:17:41 -0700
Message-ID: <20141025101741.GA17058@peff.net>
References: <20141024134802.93466250E0D@webabinitio.net>
 <vpqbnp1zhp7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "R. David Murray" <rdmurray@bitdance.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Oct 25 21:17:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6qV-0005oI-OJ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 21:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbaJYTRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 15:17:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:33585 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752379AbaJYTRq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 15:17:46 -0400
Received: (qmail 25418 invoked by uid 102); 25 Oct 2014 10:17:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Oct 2014 05:17:45 -0500
Received: (qmail 20960 invoked by uid 107); 25 Oct 2014 10:17:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Oct 2014 06:17:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Oct 2014 03:17:41 -0700
Content-Disposition: inline
In-Reply-To: <vpqbnp1zhp7.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 24, 2014 at 04:05:24PM +0200, Matthieu Moy wrote:

> I can reproduce with Git 1.7.10 by doing a chmod 0 on some object files,
> but recent Git's produce
> 
> Checking object directories: 100% (256/256), done.
> fatal: failed to read object ab2e06e74d922268fbff8d219dad9eee63786947: Permission denied
> 
> So I guess this has already been fixed :-).

Probably d6c8a05 (open_sha1_file: report "most interesting" errno,
2014-05-15). The example in the commit message even uses "chmod 0". :)

It's in v2.0.1.

-Peff
