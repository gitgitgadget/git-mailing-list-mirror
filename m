From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Wed, 17 Aug 2011 09:11:32 +0700
Message-ID: <CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
 <7vippxgm6y.fsf@alter.siamese.dyndns.org> <20110816210108.GA13710@sigill.intra.peff.net>
 <7vbovpggva.fsf@alter.siamese.dyndns.org> <20110816222212.GA19471@sigill.intra.peff.net>
 <7vzkj9eza2.fsf@alter.siamese.dyndns.org> <20110816230654.GA21793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtVc2-00084u-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab1HQCMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 22:12:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44760 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1HQCMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 22:12:03 -0400
Received: by bke11 with SMTP id 11so363439bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fpenut4hcAMWroDXM0NSpQWAxt80SSirCOs8fKjeL74=;
        b=JD75mkQvu392H10WVd52rwJ8EI+tdR2Ri5nnQtrPz/vxIUpjSlDBH3WROBT6b6nrOt
         BfvfQxJeOqEmYSpvQr7WKmwG2bnw6PAUrs5lomGlQBCQ0cIHMvJVs0U4ti/zdkSY+DVL
         NWaObi86g8+ZRaW5jxNAKJb1ro/vS/F3A4JC0=
Received: by 10.204.233.76 with SMTP id jx12mr159182bkb.71.1313547122134; Tue,
 16 Aug 2011 19:12:02 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 19:11:32 -0700 (PDT)
In-Reply-To: <20110816230654.GA21793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179496>

2011/8/17 Jeff King <peff@peff.net>:
>> As a way to punt from making "add -e" usable, I'd think it would be a
>> workable q&d workaround, even though it feels wrong, and I would imagine
>> that normal people would probably prefer the "check out to a temporary
>> file to be edited" solution you wrote in your previous message.
>
> Yeah, I think that is the sanest of the options brought up in this

I blame git for training me always do "git diff" before update index.
But if we add "add -e", I could also make "add -e -p" work, (edit
temporary file first, then fall back to interactive mode and let me
review my changes).

> thread. I'm curious if Duy had another use case, though, that made him
> think of --swap.

Two reasons. I already mentioned the ability to quickly checkout index
for a quick test (though there could be more problems down that road).

The other one could be done another way too. I translation
coordinator. When a translator sends their translations to me, I'd
pick good translations and commit them, leaving the rest for
discussion. This is why I don't want to touch wt. While adding
translations to index, I may find a mistake in current translation
(ie. in index) and want to fix it too.
-- 
Duy
