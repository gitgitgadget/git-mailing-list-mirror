From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-gui: suggest gc only when counting at least 2
 objects
Date: Sun, 13 Sep 2009 16:44:33 -0400
Message-ID: <20090913204433.GA8796@coredump.intra.peff.net>
References: <20090909195158.GA12968@localhost>
 <20090913160637.GA15256@localhost>
 <7vr5uasp4a.fsf@alter.siamese.dyndns.org>
 <20090913184150.GA19209@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com, "Shawn O. Pearce" <spearce@spearce.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Sep 13 22:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmvw9-0007Gq-Ek
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 22:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbZIMUoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755119AbZIMUod
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 16:44:33 -0400
Received: from peff.net ([208.65.91.99]:38310 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755080AbZIMUod (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 16:44:33 -0400
Received: (qmail 20228 invoked by uid 107); 13 Sep 2009 20:44:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 16:44:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 16:44:33 -0400
Content-Disposition: inline
In-Reply-To: <20090913184150.GA19209@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128411>

On Sun, Sep 13, 2009 at 08:41:50PM +0200, Clemens Buchacher wrote:

> On Sun, Sep 13, 2009 at 10:58:45AM -0700, Junio C Hamano wrote:
> > Somebody cares to explain why this threashold number has to be different
> > per platform in the first place? 
> 
> I really don't know. I vaguely remember someone claim that performance on
> Windows suffered from many loose objects more than on other platforms. I
> can't find any discussion of it though.

Maybe 8ff487c?

-Peff
