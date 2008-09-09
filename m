From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] is_directory(): a generic helper function
Date: Tue, 9 Sep 2008 08:32:07 -0400
Message-ID: <20080909123207.GA25799@coredump.intra.peff.net>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com> <1220948830-3275-2-git-send-email-gitster@pobox.com> <48C6508B.1080600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 09 14:33:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd2PH-0005pS-L9
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 14:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbYIIMcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 08:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYIIMcK
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 08:32:10 -0400
Received: from peff.net ([208.65.91.99]:4363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbYIIMcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 08:32:09 -0400
Received: (qmail 7770 invoked by uid 111); 9 Sep 2008 12:32:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 09 Sep 2008 08:32:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Sep 2008 08:32:07 -0400
Content-Disposition: inline
In-Reply-To: <48C6508B.1080600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95378>

On Tue, Sep 09, 2008 at 12:31:39PM +0200, Johannes Sixt wrote:

> Junio C Hamano schrieb:
> > +/*
> > + * Do not use this for inspecting *tracked* content.  When path is a
> > + * symlink to a directory, we do not want to say it is a directory.
> 
> I though stat(2) checks the thing that a symlink points to. Then either
> this comment is not correct or you want to use lstat(2), no?

I assume he meant "do not use this for tracked content, because in that
case...". But I had to read it twice to make sense.

> > + * Worth yet, leading components in path could contain symbolic links.

And this didn't help. I assume it should be "worse yet" and Junio
developed some sort of typing lisp?

-Peff
