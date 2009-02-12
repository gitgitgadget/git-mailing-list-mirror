From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 02:30:02 +0100
Message-ID: <2c6b72b30902111730u3b38dd5fpc0b3a8da695de219@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
	 <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
	 <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
	 <4992DB72.4080109@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Stefan Karpinski <stefan.karpinski@gmail.com>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQQQ-00038W-Bq
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756347AbZBLBaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756309AbZBLBaG
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:30:06 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:42350 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbZBLBaE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:30:04 -0500
Received: by bwz5 with SMTP id 5so692461bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=+G/9ruZ/40YtD08DawcWtK+T94CKQr4Cm3N2yxzy3n8=;
        b=xVqboE1gjunQt0lOY5NG4fTGOqb1Lm9PsFtJSvtt+MJjW7oBL90Hw5YO80wTTnKB+R
         wPTELtMtFGbdTY3wPHsLw5gN3DicaHZHRxwMEVlLpYusbF5LHzEX6EgNdODNGe6b4yjo
         vjmHL5ncBsp6xtdt1v00yiPNGdH+wwb5V4RtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=TlQwp1fQagJPeXX4SFekP9k5WUdbpUGvFyhdcFll1e9Y4emwRz79zKDDyXUVaItz2x
         1UBRrd9lrx+JfOwdZEuqMJuTQ8pCTj4f9Vg0XEkAJAfMS8DAAWX0ikhAce2IiLR0VvfP
         vxR2HNDD5ryTWpyoJ6KYS8nLGbAoxMSmD3Mb0=
Received: by 10.181.222.5 with SMTP id z5mr97108bkq.151.1234402202306; Wed, 11 
	Feb 2009 17:30:02 -0800 (PST)
In-Reply-To: <4992DB72.4080109@tedpavlic.com>
X-Google-Sender-Auth: 05bd31b80e867e0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109554>

On Wed, Feb 11, 2009 at 15:06, Ted Pavlic <ted@tedpavlic.com> wrote:
> That is, the trailing whitespace on a new line goes without highlight. I was
> under the (wrong?) impression that this was desired and that the whitespace
> highlighting was a bug. No?

The basic idea of the "cursor line" is that the whole line including
any trailing space is highlighted.

> (in fact, it might be useful if the trailing "screen space" is *not*
> highlighted. That makes it easy to X-ray trailing whitespace buried in the
> changeset)

Well, I don't know if tig is the right tool for detecting that.

I have noted your comment about different terminals being in play. A
fact that is rather discouraging. Will try to get some time in front
of OSX to look more into it. I have an idea for a temporary fix, which
I would like you to test when it is ready.

-- 
Jonas Fonseca
