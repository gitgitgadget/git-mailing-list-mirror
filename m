From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Tue, 06 May 2014 07:59:22 +1000
Message-ID: <fbc4c901-9389-48ea-a675-73739a11a647@email.android.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com> <1399121375-14727-2-git-send-email-nod.helm@gmail.com> <1399121375-14727-3-git-send-email-nod.helm@gmail.com> <1399121375-14727-4-git-send-email-nod.helm@gmail.com> <1399121375-14727-5-git-send-email-nod.helm@gmail.com> <1399121375-14727-6-git-send-email-nod.helm@gmail.com> <20140505050938.GB6569@sigill.intra.peff.net> <40d16f4b-440c-4268-bd6a-e7f413d01801@email.android.com> <20140505214930.GB16971@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, greend@obbligato.org, apenwarr@gmail.com,
	gpmcgee@gmail.com, mmogilvi_git@miniinfo.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 06 19:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAv-0007Xo-V4
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833AbaEEV7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:59:39 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38337 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316AbaEEV7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:59:38 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so6299289pdj.24
        for <git@vger.kernel.org>; Mon, 05 May 2014 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=7dbDSB1mJ6BPHzpx8X4EKcf6QFCdMRa2vINS6PaNi6M=;
        b=ES4BRZIad4KDmiZjpAGIjJlHuFw7wViy9sU8JyqYUGVovyqXiQuQ/+zwJ07ABEYKIx
         kdPbLZGVIbhILWWGv+D1BHpVCV/degWqTCQvnR6hmQ9gI9jcDmIHjY4Jp+vT+a4j9y9J
         XKiqdZ/7QmdzBf1meohnxm7X652ZSEjzCjnLvdm0xr9bwXIVm9Bm5qRS3uBtroDsQ2kn
         N+Yo4Rfo9yQG8akAOPcOus1P9IgboYxw1fJIceEfU9aWpSTxFJaM5gPAYPgoeYYs+1vy
         rEq2U7j8uH9MDFI++xMW0RWWO/sCU2J8jruTuB6ZYVae5GiSrBGr8gVSY/CY53kZH+H9
         028A==
X-Received: by 10.66.140.104 with SMTP id rf8mr76439417pab.107.1399327178309;
        Mon, 05 May 2014 14:59:38 -0700 (PDT)
Received: from [10.94.103.239] ([101.119.29.90])
        by mx.google.com with ESMTPSA id yj6sm81173214pab.19.2014.05.05.14.59.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 05 May 2014 14:59:37 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <20140505214930.GB16971@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248173>

On 6 May 2014 07:49:30 GMT+10:00, Jeff King <peff@peff.net> wrote:
>On Tue, May 06, 2014 at 07:41:29AM +1000, James Denholm wrote:
>
>> >I do not think BSD-ism matters for "rm", as it works pretty much the
>> >same everywhere. "install", on the other hand, is a bit weirder
>between
>> >systems. So you might want to leave that comment as-is.
>> 
>> True. I might just buff that out when sending the patch to Junio,
>unless
>> protocol dictates otherwise - a reroll for a single comment line
>seems
>> a bit excessive to me at the moment.
>
>I don't think it is that big a deal either way.
>
>It's fine to tweak when you send re-roll the final for Junio. Sometimes
>for trivial fixups like this, Junio can just tweak it as he applies,
>but
>I do not know if he is even paying attention to this thread, so you may
>want to re-post anyway to get his attention.

Sure, sounds good and will do.

>Either way, feel free to add my:
>
>  Reviewed-by: Jeff King <peff@peff.net>

Awesome, thanks again.

Regards,
James Denholm.
