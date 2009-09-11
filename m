From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 11:09:34 -0400
Message-ID: <20090911150934.GB977@coredump.intra.peff.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 17:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm7kv-0003ZP-F7
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 17:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192AbZIKPJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 11:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131AbZIKPJg
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 11:09:36 -0400
Received: from peff.net ([208.65.91.99]:52224 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbZIKPJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 11:09:35 -0400
Received: (qmail 7692 invoked by uid 107); 11 Sep 2009 15:09:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 11:09:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 11:09:34 -0400
Content-Disposition: inline
In-Reply-To: <20090911143651.GE1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128199>

On Fri, Sep 11, 2009 at 07:36:51AM -0700, Shawn O. Pearce wrote:

> > instead of just using "git config --get-regexp 'remote\..*\.url'", which
> > would be slightly more efficient, and also doesn't have this bug. ;)
> 
> F'king oversight.  You are right, this should be --get-regexp.
> There isn't a reason here, probably other than "I forgot about
> --get-regexp when I wrote the original code".

OK. I will leave a bash-completion patch for you (or somebody else
interested) as I don't use it myself.

Assuming you make such a patch, that will clear up the original issue. I
wonder if we should fix "git config --list". The current semantics seem
a little crazy to me, but it is a scriptable interface. I'm inclined to
call this a bug, though.

-Peff
