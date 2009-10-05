From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: make all test files executable
Date: Mon, 5 Oct 2009 05:59:12 -0400
Message-ID: <20091005095912.GA31426@coredump.intra.peff.net>
References: <4AC55E78.7010109@mailservices.uwaterloo.ca>
 <20091002080134.GD27664@coredump.intra.peff.net>
 <20091002083946.GA8627@coredump.intra.peff.net>
 <1762B430-2DC0-48F5-8C34-8428F9145A1E@mailservices.uwaterloo.ca>
 <20091004134022.GA14209@sigill.intra.peff.net>
 <4AC94B07.4000803@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:01:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MukNP-0002pN-Hf
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbZJEJ75 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 05:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbZJEJ75
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 05:59:57 -0400
Received: from peff.net ([208.65.91.99]:33075 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758657AbZJEJ74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 05:59:56 -0400
Received: (qmail 16122 invoked by uid 107); 5 Oct 2009 10:02:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 06:02:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 05:59:12 -0400
Content-Disposition: inline
In-Reply-To: <4AC94B07.4000803@mailservices.uwaterloo.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129546>

On Sun, Oct 04, 2009 at 09:25:27PM -0400, Mark Rada wrote:

> > It looks like you send with Thunderbird. How do you get the diff content
> > into the email? Is it possible that it wraps the content after you have
> > gotten it there?
> 
> I don't think so, I have plug-in that disables wrapping and has worked
> just fine for the last couple of patches I sent, so I'm not sure what
> was going on there.

I don't know, then. I'm pretty sure it wasn't wrapped up on my end, as
it is also wrapped in gmane:

  http://article.gmane.org/gmane.comp.version-control.git/129420

Maybe some hints are here:

  http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird

> > an mbox from mutt, which "git am" understands just fine. I'd have to see
> > what was in your .eml file to know why "git am" couldn't figure it out
> > (and it might be a good test case, as "git am" has recently learned to
> > accept more mailbox formats).
> 
> I've attached a copy of the .eml file.

Hmm. The .eml format appears to be some kind of inscrutable binary
format. "git am" certainly won't understand it. I'm not sure how you
created it, but you need to convince Thunderbird to export as an 'mbox'
format (which it clearly understands, as that is its native local
format). I have no idea how to do that, though.

-Peff
