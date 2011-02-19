From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/4] bump rename limit defaults (again)
Date: Sat, 19 Feb 2011 21:12:49 +0100
Message-ID: <AANLkTi=aWC_sXK1VBspsiVAwhkC4pP8Z+uq7QceLMopS@mail.gmail.com>
References: <20110219101936.GB20577@sigill.intra.peff.net>
	<20110219102128.GB22508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 19 21:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqtAl-0001PY-Qs
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 21:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab1BSUMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 15:12:51 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38473 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1BSUMu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 15:12:50 -0500
Received: by bwz15 with SMTP id 15so54342bwz.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EiGx6Aedj4YrCSQN/ZAwmMxuy1ygUtaBj4j9WtUSqkk=;
        b=ioHu+NvVk8uzDfu/fvAicAucDclHH7Rtl+IaDr5SwuM6OL72eKLFtam2+w6IZVI1Gb
         bJdlCEcmsU99PP9NHp/O2t0bbLINfsyisEvdoI2FmdwHn7N9zXTMRiwCbNFyELzvGfTo
         9tX7z3O5PPuSRBweiaEBwZZyQapHY+yUCQ8gI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bygiS4OQVuUoOtvzDuLVI4MX4Itct46pAJSTVf/sFRmAvzZcuargAdQVSNQaNpQk3l
         fQQV+1Qzz2c7qTl0ca/AvpMHJSCM2WsLMYHC6TtIGvAQAO5tYdP70MF+HOnEeVsFtuHn
         xLm54WcgNoxnV7kNOGdIZZktNrWGAXQT4pslA=
Received: by 10.204.71.20 with SMTP id f20mr1981813bkj.139.1298146369137; Sat,
 19 Feb 2011 12:12:49 -0800 (PST)
Received: by 10.204.24.6 with HTTP; Sat, 19 Feb 2011 12:12:49 -0800 (PST)
In-Reply-To: <20110219102128.GB22508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167380>

On Sat, Feb 19, 2011 at 11:21, Jeff King <peff@peff.net> wrote:

> Let's bump the diff/merge default limits from 200/500 to
> 400/1000. Those are 2 seconds and 10 seconds respectively on
> my modern hardware.

This is somewhat outside the scope of your patch, but rather than
making these decisions for the user and compiling them into Git
wouldn't it be better to expose it somehow?

E.g. when you do a git-merge show a progress bar (similar to
git-clone) showing that we're trying to do rename detection, show that
we stopped, and when we fail point out that the user could run
git-merge with some switch that would make Git try harder.
