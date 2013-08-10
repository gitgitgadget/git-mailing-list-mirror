From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 23:40:56 -0700
Message-ID: <20130810064056.GA3165@elie.Belkin>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
 <20130809223758.GB7160@sigill.intra.peff.net>
 <7v38qi4g7r.fsf@alter.siamese.dyndns.org>
 <20130810061720.GA30185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Thorsten Glaser <tg@mirbsd.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V82rP-00056f-KS
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab3HJGlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:41:07 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:34442 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100Ab3HJGlF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:41:05 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so5194530pbc.35
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 23:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fRwUBxrV5SdygQlp5WW4pdcght8SQ3JZ6943VGgzNx8=;
        b=HbWhHj0AHFa4boSDDG81wYYIzlQciPE2jCjp06mGkmjA2Mkyx9DixYX/6xec4NzAbA
         lEHp1+txoPiPZ1zjcHy98MO+k4dDHMSk6atx7lUAkwNwbevXTa6KqjWAzI22yktv89SG
         zzqecyl4zSKl4ZxLMbvKJxXkXlORaYfqryssyhstrSsNh6y9HkLSeMLoOXEvNdL1r5zH
         U86G1rM8x8JCn8gSs/keC23/Pg2eeLN+v0x2Sa5EsN79LP6w9206gnzN6EziYjneoOp3
         SI4r6k2bZhru6daAtEERb/UrTHBe9p37JvG+1YO+NAEp1a+VPCvx/gErnUKPU8FSU14c
         qHYw==
X-Received: by 10.66.186.79 with SMTP id fi15mr3988344pac.160.1376116864389;
        Fri, 09 Aug 2013 23:41:04 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id s6sm26610462pan.12.2013.08.09.23.41.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 23:41:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130810061720.GA30185@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232067>

Jeff King wrote:

> Even if it worked, though, I am not sure it would be worth such a rule.
> The /etc/mailname file is not a standard, so you would effectively be
> cutting off the auto-ident behavior for people on every other system. If
> we are going to do that, we might as well do it uniformly.

I don't fully follow.  Do you mean that because other operating
systems choose not to make full use of an /etc/mailname file when it
is present (and instead use per-MTA configuration), git should not
take advantage of it to choose an appropriate email address?

Or do you mean that on non-Debian systems, the FQDN for localhost is
reliably the mailname, just like on Debian systems /etc/mailname is
supposed to be?

Confused,
Jonathan
