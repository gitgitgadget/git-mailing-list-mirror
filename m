From: Junio C Hamano <jch@google.com>
Subject: Re: push.default: current vs upstream
Date: Thu, 19 Apr 2012 14:02:35 -0700
Message-ID: <xmqqd373v3is.fsf@junio.mtv.corp.google.com>
References: <vpqwr5uceis.fsf@bauges.imag.fr>
	<20120406071520.GD25301@sigill.intra.peff.net>
	<vpqr4w12tjj.fsf@bauges.imag.fr>
	<20120406080004.GA27940@sigill.intra.peff.net>
	<4F7FF19B.1060407@alum.mit.edu>
	<20120407075150.GA18168@sigill.intra.peff.net>
	<7viphaygsg.fsf@alter.siamese.dyndns.org>
	<vpq62d6dyzr.fsf@bauges.imag.fr>
	<20120412075535.GC31122@sigill.intra.peff.net>
	<vpqhawp2wxs.fsf@bauges.imag.fr>
	<20120412081407.GE31122@sigill.intra.peff.net>
	<vpqfwc9wckl.fsf@bauges.imag.fr>
	<7vpqbdeyfh.fsf@alter.siamese.dyndns.org>
	<xmqqzka7so2p.fsf@junio.mtv.corp.google.com>
	<vpqaa27bgon.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 19 23:10:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKycx-0007MA-LP
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 23:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478Ab2DSVKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 17:10:49 -0400
Received: from mail-lpp01m010-f74.google.com ([209.85.215.74]:53027 "EHLO
	mail-lpp01m010-f74.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754350Ab2DSVKp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 17:10:45 -0400
Received: by laai8 with SMTP id i8so429705laa.1
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Vln1SU0+Q12whF/4MgpZh6C8tkugueb/9MbBoLYMPqc=;
        b=a2eEDm1DaAAqwZqOOrPCdwS4Ju0yp6543qcjm2F7zd2gUJ8kocycvA8YD93FT0Jqaj
         1oBsmgvkSoOX4fgFzxwJafetwdnKVdnBmobdh7NUzlJlBEES6uyMZwY57VGr7OLZfzW2
         y/JfLuiD2wTxd+VOHcPnVwLZw3qtv54CYUsFyYeiJod7721mqxAabyetinb4peQmMNFv
         onMQ7PjtDQmknnAo0toa2icKWpj8mHec6hkZsD6XCn5Oecz6NRMpNqNT4F8ElL/4BNDD
         ZFY01arERY+GEPWmLknwX9W4QMEe87e/EIpTHseD+hnw3Jl3RZvLgx7RrWcekCX6s499
         iIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Vln1SU0+Q12whF/4MgpZh6C8tkugueb/9MbBoLYMPqc=;
        b=V7M6gCbSlm9Gb2Os6kXwfbdkEr66aXxJz6DLElRrKokGT5KIciqirdWPGMqhQTgzRm
         KznczhdYkP76F0EPM8FOtsSCQ138cjKKaO1LjovQbl9kXM8U1ve9SKbJP4FI1gJ6ZEW9
         DUqpilAYdFlMGG12TaQTaq5UyA4raPSg+WHdjH0vWkjZJAG3LBeZLdx9C7g6qBdFGlBd
         3PGYax3vAlkxQRmL56Ety+xIM9LkQNTDsWV94nrTNsh/joCX2/X8lMkusMY3c/E2FSI2
         AsOgX2jN/DmFNawbq/eA4L5kezpWJrN5pUXDAK3zhS+mgfdp87mGA1q1FSN3hfdfJd5z
         fmGQ==
Received: by 10.14.95.199 with SMTP id p47mr984235eef.3.1334869356330;
        Thu, 19 Apr 2012 14:02:36 -0700 (PDT)
Received: by 10.14.95.199 with SMTP id p47mr984226eef.3.1334869356234;
        Thu, 19 Apr 2012 14:02:36 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id s9si3187503eei.3.2012.04.19.14.02.36
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 19 Apr 2012 14:02:36 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 0ED915C0065;
	Thu, 19 Apr 2012 14:02:36 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 5DFACE1209; Thu, 19 Apr 2012 14:02:35 -0700 (PDT)
In-Reply-To: <vpqaa27bgon.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	19 Apr 2012 22:38:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlPLN6GurPBN0uZBKPhEQjntJAHj+3SJpVczfuj2hHWky+15mve8qL+6Ms0O1u109VNPIGVQ8Q+lrP9cIsES2L+hT47xylF05MM75lh6GCYVtBvZhEpRNlYV7SAlmTRCkc2ps2vQUPk0zeFW63wCQXHMm2WrZQKeZmQKPHN286LH6XYwlI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195970>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> So what happened to this discussion?  
>
> I've been busy, so did nothing, and my procrastination didn't pay ;-).

Heh, it rarely pays to procrastinate when it is clear that you are the
party who cares the most deeply about the issue among the ones capable
of changing the status quo.

As long as it is not forgotten, that is fine, and being busy is good ;-)

>> Does anybody want to roll the "simple" default based on Peff's patch?
>
> I was about to, actually. I'll go for Peff's semantics at least for now,
> and just add tests.

Thanks.
