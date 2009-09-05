From: Jeff King <peff@peff.net>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 04:02:49 -0400
Message-ID: <20090905080249.GA8801@coredump.intra.peff.net>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
 <7v3a717rgl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:03:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqEi-0000fT-F3
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbZIEICw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbZIEICv
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:02:51 -0400
Received: from peff.net ([208.65.91.99]:54125 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbZIEICu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:02:50 -0400
Received: (qmail 25667 invoked by uid 107); 5 Sep 2009 08:03:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:03:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:02:49 -0400
Content-Disposition: inline
In-Reply-To: <7v3a717rgl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127790>

On Sat, Sep 05, 2009 at 12:58:50AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I assume you mean "ls-files".  I have every once in a while been annoyed
> > by that, but given how infrequently I run ls-files, it is not a big
> > deal. :)
> 
> I did mean ls-tree, but I misspelled the name of the escape hatch.

Oh, I never noticed that behavior before. For "ls-files", I think it is
at least a little sane, but it makes no sense whatsoever for ls-tree.

> At this moment (as my brain is not quite functioning), I can only say we
> agreed to disagree what feels more natural here.

I agree that we agreed to disagree. But there is still one open
question: would you take a patch for a "full-tree" config variable that
would impact add (and probably grep) for 1.7.0? You can sleep on it if
you want. ;)

-Peff
