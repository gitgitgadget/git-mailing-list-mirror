From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
	topic
Date: Tue, 2 Dec 2008 18:30:04 -0500
Message-ID: <20081202233004.GA22379@coredump.intra.peff.net>
References: <20081201173037.GA41967@agadorsparticus> <20081201183258.GB24443@coredump.intra.peff.net> <7v7i6jqriv.fsf@gitster.siamese.dyndns.org> <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com> <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com> <alpine.DEB.1.00.0812022353410.27091@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 03 00:31:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7eiE-0004mS-9h
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 00:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYLBXaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 18:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYLBXaI
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 18:30:08 -0500
Received: from peff.net ([208.65.91.99]:3878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbYLBXaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 18:30:07 -0500
Received: (qmail 15028 invoked by uid 111); 2 Dec 2008 23:30:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 18:30:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 18:30:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812022353410.27091@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102187>

On Tue, Dec 02, 2008 at 11:55:03PM +0100, Johannes Schindelin wrote:

> If the whole thing gets longer than 24 lines, we have to leave some things 
> out.  Personally, I consider rm and mv unimportant enough that they could 
> be shown in an extended list, but be left out of the summary page.

For the record, the current output is 26 lines, plus you probably want
to account for 1 line of the user's next shell prompt. So we are 3 lines
over already.

Scott's proposal is about grouping the commands more sensibly. Many of
the complaints are about the length of the output. Maybe we should scrap
having a list of commands altogether and just point at section-specific
documentation, each of which could discuss basic commands related to it.

I think there has been mention of task-oriented documentation pointers
before, and I think this is a place where we would want it.

-Peff
