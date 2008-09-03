From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 14:08:46 -0400
Message-ID: <20080903180846.GB16454@coredump.intra.peff.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net> <8A00EA31-ED43-45CF-A162-66DC45AE41F0@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 20:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kawnk-00014b-DK
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 20:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYICSIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 14:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYICSIt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 14:08:49 -0400
Received: from peff.net ([208.65.91.99]:2323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441AbYICSIs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 14:08:48 -0400
Received: (qmail 30145 invoked by uid 111); 3 Sep 2008 18:08:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 03 Sep 2008 14:08:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2008 14:08:46 -0400
Content-Disposition: inline
In-Reply-To: <8A00EA31-ED43-45CF-A162-66DC45AE41F0@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94830>

On Wed, Sep 03, 2008 at 04:11:32PM +0200, Wincent Colaiuta wrote:

>>  Previous HEAD position was 1234abcd
>>
>> when leaving the detached HEAD state, but it seems to have disappeared.
>
> Mightn't "Previous HEAD position was 1234abcd (detached)" be even more  
> helpful?

The full message is actually:

    Previous HEAD position was 1234abcd... subject line of 1234abcd

I am not opposed to changing it, but I will let others decide on what it
should say; my patch just reinstates the message itself (for which there
was code, but broken code).

-Peff
