From: Jed Brown <jed@59a2.org>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 04 Apr 2013 14:01:07 -0500
Message-ID: <87vc82qfws.fsf@59A2.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan> <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de> <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com> <871uaqrwrp.fsf@59A2.org> <CAMP44s3zm+-220Xpqv_=JkJ=g2pS79hUNjacVZ=JejitcG=B8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpPr-0001fK-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763787Ab3DDTBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:01:14 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:58597 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763729Ab3DDTBN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:01:13 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so2906095obh.2
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=Y0izaK4UB0UsO2YfP36nrGkM7n8JH/2DAVprJlDpKXU=;
        b=gJTLQjsWHvvo1ydyS13kQREBR520g0g6Aj9f1REvsNgkpNHtcuLqNFWEmHVgwYrCMC
         jlvIQccdj6ZAxFohz11kywxcuWdgOmGKBUartXKAo/RHmCsmIsSJ1IgknlSqRpNJCAlR
         Wd91xWfe1hJe5QFRKyTKEA9AKdp5yLo0dPISO3G1KoGoP1wRgSXJzE+3SCEzzt2EegAS
         pnH05j5tgWlZiAq9pMmS6l7/27x/SmfJPv93hMQii077+sS1gHqWs0zUXS7WEayVVB/r
         UgW4RPRrYjklO6+ejRGSJrS1Co0KXywxiP6RzFLnDB0/8Z/7JPJUoxTpZDYSTUmzjakP
         gTrw==
X-Received: by 10.182.204.5 with SMTP id ku5mr5382513obc.22.1365102072441;
        Thu, 04 Apr 2013 12:01:12 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id a10sm8264071oez.1.2013.04.04.12.01.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 12:01:08 -0700 (PDT)
In-Reply-To: <CAMP44s3zm+-220Xpqv_=JkJ=g2pS79hUNjacVZ=JejitcG=B8A@mail.gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220066>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Where is the evidence? You say remote-hg doesn't work, I say it does,
> the difference is that I have evidence to prove it.

There are many projects that don't do what they claim.  I gave remote-hg
a few minutes and moved on since (at the time) it didn't seem
interesting enough to be worth the effort of making proper bug reports.
There's a lot of low-quality code in the world and I'm willing to
tolerate a certain false-positive rate.  I apologize for misdiagnosing
your project and I'm happy to believe that you have since fixed the
bugs.  I was merely answering you question of why some of us contributed
to gitifyhg in preference to remote-hg.

I see no value in dwelling on the value judgement I made a few months
ago.  Additionally, I have almost no use for either project any more.

> remote-hg doesn't fail with the non-fast-forward error, in fact, it
> doesn't fail at all, it pushes correctly, and that's reported as a
> failure.

I don't agree that force-pushing by default is "correct" behavior.
