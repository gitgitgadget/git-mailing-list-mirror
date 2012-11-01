From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 01 Nov 2012 10:22:49 +0900
Message-ID: <16b87432-2862-4be9-afea-5b672101af62@email.android.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com> <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net> <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com> <5090EFCA.7070606@drmicha.warpmail.net> <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 02:23:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTjV6-0006CH-9X
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 02:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761332Ab2KABXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 21:23:03 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:34092 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190Ab2KABXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 21:23:01 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so906361dak.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 18:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=GtiEDMl3O/XruFDHgRg34jksi7QbFON43Xp78Z6Rv20=;
        b=bybcuMCtGauZI3a7ITNFR2lfA8LcO1E9Tgn/Lns9xd63kRzxmr6Tta5jvDrlkHM38X
         ryL595S8PNiziLzL+A+JmWrRXimVxNTG8P9njXbuDCn/FRm+EWzTkUEjpWd4E3s/kqoe
         nO0+Nrf48oP1XaHAJRSOZGqyWGk/PrOgYSOByGyP6x/sAQiSunnD7rj0dJoDZitFrUcN
         mRXoHQcicQnNQ3aCXNFrSFZ4+lfwUg3zHNNftfuCkrf9chGksYm7UFZ4bGszy59xthNd
         cWn9BP/c1buDctjdE0ZZbgW1FP2fEyOpHVx6nPxwZ2RNYnKOabPWxdgVVG05rRplWcQk
         9AvA==
Received: by 10.66.86.65 with SMTP id n1mr106900749paz.48.1351732980716;
        Wed, 31 Oct 2012 18:23:00 -0700 (PDT)
Received: from [192.168.0.3] (112.136.53.59.er.eaccess.ne.jp. [112.136.53.59])
        by mx.google.com with ESMTPS id n7sm3037027pav.26.2012.10.31.18.22.57
        (version=SSLv3 cipher=OTHER);
        Wed, 31 Oct 2012 18:22:59 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208856>



Felipe Contreras <felipe.contreras@gmail.com> wrote:

>And finally, what do more do you expect me to do? About the code, and
>only the code.

The analysis that does in the log messages is an important part of "code" in this project, so that may be a good place to start. Both Jonathan and J6t asked specific updates to your log message, no?
