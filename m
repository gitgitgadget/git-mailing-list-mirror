From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 22:24:37 -0400
Message-ID: <76718490808261924j1ddae535tdfb671dd9d3298aa@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080826210318.GA6305@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 04:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYAjW-00045I-0T
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 04:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYH0CYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 22:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYH0CYj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 22:24:39 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37363 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYH0CYi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 22:24:38 -0400
Received: by gxk9 with SMTP id 9so3824496gxk.13
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 19:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=70TLwSpaq952Bkqvz40ryzW2bycOj+mXjGX7EuqGjwc=;
        b=uDU5rH9gWzmZu82Meeod24zOYfSuhOfuoagNmTzlX60BWpmG+TVkU3yGylHahaUPZb
         i5paK/CoaXv1OiGamIK89mgEftwelUM7NzkCmJvZBAm0lI/gUnUbqPnSJjG6t5AJ6Fu1
         3g04Leyo/GgDMxCelMBYUHPYDhT8F+iJ8nRY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cEbLLIvoBCtTwowjM481DQyRiVWwFzlbf3Hm4RjymRxQFM1GhM0mTy4yMm6v7+3FOm
         LA3LMhDHhhb49ku7Vo8AbpPT4H9QG/AQQnsZwTqoTy9Tz6ILRJsgS3tPFLzWQA1xgWb6
         RhzUv5NbsK/tb5pSvAnZHlN4/1mPQEcuKNAuw=
Received: by 10.151.46.3 with SMTP id y3mr616227ybj.225.1219803877231;
        Tue, 26 Aug 2008 19:24:37 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Tue, 26 Aug 2008 19:24:37 -0700 (PDT)
In-Reply-To: <20080826210318.GA6305@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93845>

On Tue, Aug 26, 2008 at 5:03 PM, Jeff King <peff@peff.net> wrote:
> I was slightly negative on the change at the time of "/usr/bin vs
> /usr/libexec/git-core" and I planned to put "git --exec-path" in my
> PATH. But I gave the new way a try, and I have not been very bothered.
> So let me say that I really don't care much what happens with libexec,
> and you can hold me to that when the next flame-war breaks out if such a
> change is implemented. Now you have three opinions. :)

+1 on removing the links and I will say this: this change finally
motivated me to switch my login shell from tcsh (12 years I've been
using it!) to bash so I could use the completions and I'm happier for
it. So thank you git. :-)

j.
