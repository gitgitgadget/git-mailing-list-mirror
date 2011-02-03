From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: moving to a git-backed wiki
Date: Thu, 3 Feb 2011 20:06:34 +0100
Message-ID: <AANLkTikshY8qHoFvghSu8q21j5Unp==Hf583OE2tkNrS@mail.gmail.com>
References: <7vwrll57ha.fsf@alter.siamese.dyndns.org> <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
 <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org> <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net> <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
 <4D488DCD.3080305@eaglescrag.net> <4D4929F4.3020805@snarc.org>
 <4D4A11D7.4040103@eaglescrag.net> <20110203174518.GA14871@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "J.H." <warthog19@eaglescrag.net>, Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 03 20:07:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl4We-0004Wv-9B
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 20:07:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506Ab1BCTHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 14:07:18 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43904 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932430Ab1BCTHR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 14:07:17 -0500
Received: by gwj20 with SMTP id 20so608920gwj.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 11:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ra5X4a+seoc2zdsa1GYuMeeYlAU5yIyPhAfLVzhNr3U=;
        b=WJK3wDDethdHPC5PYrGQTZGn9D9RvK3b+YlflcbzFV8qrSIynu0xULblE8wY8Tv4AP
         Snp6KUjJoEofLL4padf+K8KLVo8rx/1IgyuH3UxHTxAHIOxmzrL5RTxGld46a4auW1EM
         PNS2MFdOJG25FpT8hrXosG8tBSnQp63n+X678=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uCRv1z7Bmqcv81nzDplC0VbEm3dNsMNoGioQgXOO2R8EeSQkDSWomFAgPoZVo94M6d
         e+p6I/2qHW/Z1qoQReQ+wQudvhxaieDtKgjDH/x0eywH6TW2i775jffkD8KTqRywQdPG
         xAiErsc8IzYdkMsm6IUJrx+1BSFdbLUZV9CnI=
Received: by 10.150.58.2 with SMTP id g2mr8598391yba.397.1296760035993; Thu,
 03 Feb 2011 11:07:15 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Thu, 3 Feb 2011 11:06:34 -0800 (PST)
In-Reply-To: <20110203174518.GA14871@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166054>

Heya,

On Thu, Feb 3, 2011 at 18:45, Jeff King <peff@peff.net> wrote:
> Most of us don't really care if git is the ultimate storage mechanism. I
> could even build the git interface as a purely client thing on top of
> the CGI interface; the problem is that scraping the wiki pages for new
> versions over the net would be horribly inefficient.

Note that MediaWiki has a stable API that you could use instead :).

-- 
Cheers,

Sverre Rabbelier
