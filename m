From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Tue, 10 Mar 2009 20:30:22 -0400
Message-ID: <20090311003022.GA22273@coredump.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net> <7v8wnflrws.fsf@gitster.siamese.dyndns.org> <20090310181730.GD26351@sigill.intra.peff.net> <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 01:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhCMd-00034S-KO
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 01:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbZCKAa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 20:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZCKAa2
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 20:30:28 -0400
Received: from peff.net ([208.65.91.99]:45088 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbZCKAa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 20:30:27 -0400
Received: (qmail 15117 invoked by uid 107); 11 Mar 2009 00:30:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Mar 2009 20:30:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Mar 2009 20:30:22 -0400
Content-Disposition: inline
In-Reply-To: <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112861>

On Tue, Mar 10, 2009 at 06:57:55PM -0500, Chris Johnsen wrote:

> On 2009 Mar 10, at 13:17, Jeff King wrote:
>> Can somebody with an OS X box try:
>>
>>   $ /bin/sh
>>   $ eval 'false
>>
>>     '
>>   $ echo $?
>>
>> It should print '1'; if it prints '0', the shell is broken.
>
> I wrote t3505 on a Mac OS X 10.4.11 system. On that system, /bin/sh is a 
> copy of bash v2.05b. Your test code prints 1 here.

OK, then nothing to worry about there. I have no idea which shell
OpenBSD and NetBSD use these days, and I don't have access to a box.
Anybody?

-Peff
