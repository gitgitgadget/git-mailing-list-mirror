From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Thu, 21 Mar 2013 01:16:40 +0530
Message-ID: <CALkWK0=vrtO6Mjaaj-bWZgd=8VOd+O6Q7Vebr=mkiXLEBBeYsg@mail.gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-6-git-send-email-artagnon@gmail.com> <20130320183255.GL3655@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:47:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOyv-0000iU-U2
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757752Ab3CTTrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:47:01 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:49060 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159Ab3CTTrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:47:00 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so2548062ieb.17
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UFW73gKk+UtoYlXL1CkCS/2jhSDOzEvqSGO2f8msY+g=;
        b=Eg4bBGX88fMxYaZaXl3JHIDpq/Tt/CeArmQ4sBc2ZrlzuHAGTKPO1aZR51q0p0Zmaj
         +KFM14UaCkjHLYjmjfRWwA7fiNtSKVdQ0IaeBCsAyiREcjy+Er7RghykvxGuTEFvAU3r
         syKtISipm2YEejcmPGjtbuOBOhueyg4dEPw7a9BDpJhej1KFBhr9iUi8H1noLYhcgUNM
         t6S6UMhbSK32qaxt+UCoeB/yZhoEAUqjW8uHRTpGwjG3EvMhQn1PrwVHPJwF4smYD6HG
         jPYvRM+YLrhIGhZX7ijPqnkPFayKApAxJQVJqzuOVwnlwNEuLYkliXEpkuXqjOzAUCTZ
         gHXQ==
X-Received: by 10.50.17.71 with SMTP id m7mr277537igd.14.1363808820635; Wed,
 20 Mar 2013 12:47:00 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 12:46:40 -0700 (PDT)
In-Reply-To: <20130320183255.GL3655@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218666>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> This new configuration variable defines the default remote to push to,
>> and overrides `branch.<name>.remote` for all branches.
>
> Micronit: I think this would be easier to explain if it came after
> patch 6, since then you could say "In other words, it is a default for
> branch.<name>.pushremote for all branches" and readers would not have
> to wonder "Why does the more generic configuration override the more
> specific one?".

I'm sorry, but this is not worth a rebase.
