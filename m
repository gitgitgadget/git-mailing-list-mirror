Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 6861 invoked by uid 107); 24 Aug 2009 08:22:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZHXIWZ (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZHXIWZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:22:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:40558 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbZHXIWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:22:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1240967qwh.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 01:22:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DMrBdOmNhrX75dWpcp0c1eAbSs6CcG7YVDDcGiZjKi4=;
        b=VuT8i7/MxSO5K7N6CgbPj32Wjomj+pm6s5vIARZRWHQ2krf5Q/UUB9yiGfwIz/9+RT
         dB6iGDuUHMIpBZXqAuUKp/CW2zf4Ca7U51FFccERXGy7mPbglyXJFGCDIPJt0B0Aj5rE
         82pltBhNprk1y7gJfWgk2Z298pSqFPKkT7eMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vqQ1AOqo/M/K3cto3ZSq0x1SDKW8oe8TpAUyR7OcGEM7+N6UEv/WQh3J0e2QVbeSTp
         SbSmo0Ee/r2VrAowm65GKyLtdJZEpKZxIl6u2Z+jfqu85/8yjHoMmoMxmxj05SEeIMi5
         m3EMU/RN5T0dqZnLj+STPwLrbrwpRUkTIkweg=
MIME-Version: 1.0
Received: by 10.224.56.145 with SMTP id y17mr2460016qag.317.1251102146280; 
	Mon, 24 Aug 2009 01:22:26 -0700 (PDT)
In-Reply-To: <40aa078e0908240120o36004f78m52aa34c8a338854c@mail.gmail.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <20090824060710.6117@nanako3.lavabit.com>
	 <4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
	 <4A92476A.4060205@microchip.com>
	 <40aa078e0908240120o36004f78m52aa34c8a338854c@mail.gmail.com>
Date:	Mon, 24 Aug 2009 10:22:26 +0200
Message-ID: <40aa078e0908240122j480a6470w346af5f67df27611@mail.gmail.com>
Subject: Re: Pulling one commit at a time.
From:	Erik Faye-Lund <kusmabite@googlemail.com>
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Kai Blin <kai@samba.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> $ git merge FETCH_HEAD

Uhm, of course, you'd have to reattach HEAD to your branch before
merging. My bad ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
