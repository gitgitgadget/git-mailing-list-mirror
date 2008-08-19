From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Wed, 20 Aug 2008 10:26:48 +1200
Message-ID: <48AB48A8.80904@vilain.net>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com> <20080819185804.GA17943@coredump.intra.peff.net> <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com> <20080819190832.GC17943@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 20 00:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVZgL-0003JT-7J
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 00:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbYHSW1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 18:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYHSW1B
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 18:27:01 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51383 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbYHSW07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 18:26:59 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 4C42021C93A; Wed, 20 Aug 2008 10:26:58 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id BE08421C92A;
	Wed, 20 Aug 2008 10:26:48 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <20080819190832.GC17943@coredump.intra.peff.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92929>

Jeff King wrote:
>> If the patch is acceptable, I will update the githooks doc with more
>> information, but we would like this so that you could add a hook that
>> runs your automated tests before a push would go through.
> 
> I think the common wisdom has been that such tests should be done on the
> _receiving_ end, since that makes a more trustworthy enforcement point.

Probably true, but if someone wants to arrange it the other way around,
what harm is there in that?

Sam
