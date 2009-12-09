From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Wed, 09 Dec 2009 12:55:55 +0900
Message-ID: <20091209125555.6117@nanako3.lavabit.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302> <20091205062708.6117@nanako3.lavabit.com> <7vd42t6f9i.fsf@alter.siamese.dyndns.org> <20091208121314.6117@nanako3.lavabit.com> <7viqchhl7h.fsf@alter.siamese.dyndns.org> <20091208093515.GA32655@sigill.intra.peff.net> <fabb9a1e0912080551s32295cfahf05bdc715360360@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 05:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIDis-0007IQ-FI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 05:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933516AbZLIEAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 23:00:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756638AbZLIEAB
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 23:00:01 -0500
Received: from karen.lavabit.com ([72.249.41.33]:37732 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756642AbZLID77 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 22:59:59 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 8DDE011B864;
	Tue,  8 Dec 2009 22:00:06 -0600 (CST)
Received: from 4204.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 1TB777OINL46; Tue, 08 Dec 2009 22:00:06 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=3ssKyPDvj6wEsgSnke26cmNdjBnaPhDSuEjS9Edxhwm9kqpgJMuOfl1n2JwhLKbbGaDUqAFyTXTdRc5q4p08aLC9BroI34f09j2E+EaHW/wlRTnyST4PIwqCNKbi9M+LpPqelCCDI0fdzhc5Lkw5X4imrwi/F9UuRwfHOi0x09Y=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <fabb9a1e0912080551s32295cfahf05bdc715360360@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134931>

Quoting Sverre Rabbelier <srabbelier@gmail.com>

> Heya,
>
> On Tue, Dec 8, 2009 at 10:35, Jeff King <peff@peff.net> wrote:
>> $ bash
>> $ echo "!fixup commit"
>> bash: !fixup: event not found
>> $ echo "fixup! commit"
>> fixup! commit
>
> Speaking of which, must we use that annoying bang? I hate how bash
> gets in my way when I try to write a commit message with a a bang in
> it, I'd much rather use a different character that is not in risk of
> being mistreated by my shell. (Although it seems that bash does do TRT
> in the 'fixup!' case.)
>
> -- 
> Cheers,
>
> Sverre Rabbelier

There was a strong objection (I think from Johanes) against not 
using 'unusual' letters during the initial round back in June 
2009. Even when explicitly giving '--auto-squash' from the 
command line, there can be commits with confusing titles 
like "fixup the ancient bug in cat-file" in addition to 
the ones you wanted to mark with the "fixup!" marker.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
