From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 01 Nov 2012 10:41:11 +0900
Message-ID: <c0f8d214-4d61-4b02-8bda-4f26c33ae30f@email.android.com>
References: <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net> <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <20121031102712.GB30879@sigill.intra.peff.net> <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTjmq-0007Bs-46
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 02:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab2KABlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 21:41:24 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:44708 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755208Ab2KABlX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 21:41:23 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so912924dak.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 18:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=8CwwSF2wGmU10Ph8VaJ5XaHTxATPZQryOqprlw/raw0=;
        b=jwK6tfNAqEEqCn4HXoFebrQ5QlmdPmILICu1s7H0ZQOSvFKFpqAsATfowOkbwo2wgE
         6ZYmzc5t3DAXGKCkuWvM51PL5wuZ9DB8Rss3p6gCpiBK10K9Wh+K8eFSVxn3UGYpgagI
         MPV5wC4Sxi7bwx3nuGkJNxhx4ukHQC2jx8aKuI57xI+SuqwvqUdrmSspcdzDc1CrH67V
         9+FUl0Tw3KiwS20HB94Kw6IrcsPy3u7pnjj0luzqbyRr9tNNtX2oc0aH+G6hV7+CzKNk
         EnXFoFclRm5dEx4UctjEX2nhBjvKO5RNk7GF7zqVwoPAs73RDUTGMArBFpvUuMDlXnmW
         xNEg==
Received: by 10.66.74.65 with SMTP id r1mr106867063pav.75.1351734082862;
        Wed, 31 Oct 2012 18:41:22 -0700 (PDT)
Received: from [192.168.0.3] (112.136.53.59.er.eaccess.ne.jp. [112.136.53.59])
        by mx.google.com with ESMTPS id sf4sm3137144pbc.75.2012.10.31.18.41.20
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 18:41:22 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208858>



Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

>Junio wanted a more general solution, adding infrastructure to the
>rev-list engine that I did not need -- and did not see the need for,
>either -- and given the amount of time I had invested in a working
>remote-hg and given that I needed it desperately for my day-job
>project, ...

This is relatively long ago (and I am away from my machine, so I cannot check) so I may misremembering things, but my impression is that since that discussion, we added a minimal "infrastructure" to the rev-list (I think we caled it rev-list-cmdline or something like that) and Sverre used it to update fast-export.

It may well be that what we have is still not sufficient to do everything you need, but it may be close enough to get extended for your original use case.
