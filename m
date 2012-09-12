From: Bruce Korb <bruce.korb@gmail.com>
Subject: Re: [PATCH 2/3] sha1: clean pointer arithmetic
Date: Wed, 12 Sep 2012 14:25:24 -0700
Message-ID: <CAKRnqNJaG4Nw2AVMmSsweBzeNbkPKYQ+TUuGc_B2M464y6jbHA@mail.gmail.com>
References: <cover.1347442430.git.ydroneaud@opteya.com> <20dce012a57900b61e51c0e0d8dfb5573693010e.1347442430.git.ydroneaud@opteya.com>
 <7vd31rcck4.fsf@alter.siamese.dyndns.org> <1347483030.1961.13.camel@test.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 23:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBuRW-0007LG-9M
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 23:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753675Ab2ILVZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 17:25:46 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38817 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2ILVZp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 17:25:45 -0400
Received: by oago6 with SMTP id o6so1352931oag.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zgwUYuSW20Qq1aZNhwu6e1W9arI31SzpGUp9ZgtoXlw=;
        b=dlMS2lFwmVQ6bMtXaN0t5Oj7vwRyU6KHHMhWZXYnXLQntvVgiPY4Vmw9BygTvay2Cv
         sdWMJCxlw9jgq1usZbAAXX1NdMilCgTFLYI6r18k0QOS2BKWio38VvTYCfostfgaNzKZ
         qzx6gOnaxV16FrmVSG/yuaeNNy0m7P/IDuFXk91wMAsgFFi4BHEG1K4C6LSiNHXg4s4L
         RzTs2TBL7VxVlUCV+bIoAzvuNjPRAoI4xXhcg+/H9DqwOquGwMcwQSxSVPLE0rFLSr7Q
         XgpacyPTJVtjjCprnSBe3Y4FjGm+CQ+cBVSuA8LcXmxlQoIyLoaqdwiV6utdMSZJaIc/
         Hj0Q==
Received: by 10.182.216.99 with SMTP id op3mr23916641obc.85.1347485144337;
 Wed, 12 Sep 2012 14:25:44 -0700 (PDT)
Received: by 10.76.120.169 with HTTP; Wed, 12 Sep 2012 14:25:24 -0700 (PDT)
In-Reply-To: <1347483030.1961.13.camel@test.quest-ce.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205341>

On Wed, Sep 12, 2012 at 1:50 PM, Yann Droneaud <ydroneaud@opteya.com> wrote:
>> Both are correct.  Aren't ctx->w[lenW] and lenW[ctx-w] both correct,
>> even?
>>
>
> "correct" in my commit log message should be read as "the way it's used
> by most C developer".
>
> It's again a cosmetic fix.

It's a maintenance fix.  The fewer distractions, the easier it is to understand.
"lenW[ctx-w]" is distracting.
