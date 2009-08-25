From: Jeff King <peff@peff.net>
Subject: Re: hitting home directory's parent
Date: Tue, 25 Aug 2009 00:48:18 -0400
Message-ID: <20090825044818.GB13738@coredump.intra.peff.net>
References: <20090821200503.GA19660@panix.com>
 <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com>
 <20090822150542.GA29507@panix.com>
 <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com>
 <20090822181607.GA25823@coredump.intra.peff.net>
 <20090823051244.GB10761@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Convissor <danielc@analysisandsolutions.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 06:48:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfnxL-0004WW-BF
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 06:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415AbZHYEsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754409AbZHYEsS
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:48:18 -0400
Received: from peff.net ([208.65.91.99]:39118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754329AbZHYEsR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 00:48:17 -0400
Received: (qmail 13850 invoked by uid 107); 25 Aug 2009 04:48:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 00:48:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 00:48:18 -0400
Content-Disposition: inline
In-Reply-To: <20090823051244.GB10761@panix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126998>

On Sun, Aug 23, 2009 at 01:12:44AM -0400, Daniel Convissor wrote:

> That explains what's happening.  cmd_help() calls git_config().  Though 
> it seems it would be more, uh, helpful, if help produced basic usage 
> output no matter what, and then produce the more detailed config based 
> output if possible.

I agree, but the way the code is structured right now means doing this
right is probably a pretty big change (see my other message to Duy). So
I think it will probably go unfixed for the time being.

> Is there a bug tracker y'all use where I can enter a ticket?

We don't have a formal bug tracker, but this is really just a sub-part
of another issue, so it will get addressed when the parent issue is
fixed.

-Peff
