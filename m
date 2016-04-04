From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for
 multiple options
Date: Mon, 4 Apr 2016 18:44:14 -0400
Message-ID: <CAPig+cT2w_t68w5qr-bYxrgOdXcO=RhuazCnoHuF4J7n+AQi5A@mail.gmail.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
	<xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRMti0ayBMS2TTUc-Og=X-Pu2yeHxHOS74fw=X8BTsjhQ@mail.gmail.com>
	<xmqqr3el3zox.fsf@gitster.mtv.corp.google.com>
	<CAPig+cR1mmx+2D7U8ejx8HTWbFtxbmi-85D0hgm9J48bkai6CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Brodsky <corax26@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 00:44:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anDEK-0007SU-HY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbcDDWoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:44:16 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34317 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbcDDWoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:44:15 -0400
Received: by mail-io0-f175.google.com with SMTP id 2so210637ioy.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=xRTZsjd7scewFdohuwhayIEpBoQmz2nyAhrtB6ywQ1U=;
        b=ylcOcV20QWqHtBgcnIUdNX3WSaL47PmoPbQnbc3OZ3tjSg3650Tiblels1s1gAd72a
         nypyJ+HeOjYpMwAiP4UJq2rDNLCxV49OX41W0sZw+b3XECw51NqB9U+eh5QfB3dWSp9e
         vZd7HeXE07tbg7CEw6ZuroBoLKfLjBPI24UYr06nPxk1UkUd8BnfjzxIMy7KDnMyWJAN
         Up5BStzEd4MDhep9AKbQtUByCu3w6XBmiGSa/TI432mv3XFRGqG9smT6s4zSW3Q9FYLy
         343vkCHLWT3wu2HZAIuoOvzctZ4DI8dlmhlAXm33xOzIuoJFOjnzw2/kbA+dIhoD5tT6
         x5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=xRTZsjd7scewFdohuwhayIEpBoQmz2nyAhrtB6ywQ1U=;
        b=VNJy1z6f3ARLtKzQQbm9/e/ke+Ddd7jdT9jl2+4tdVXlu2bgXa6rVhbUNzEF54OYcy
         7FCJvk9jqb4w2YvoZCXrZVSdCcMkikMx6og3vqE/pUSzCoj/od+O94r2LmPt+5eH8TBH
         eOp04cq3bF5S5pVZhRBLjYB996Uc7u4JCl1ud1CM59K0Sw4Ofk/Zn98oxrGNIVhnXr72
         EHZ8xqX5F/aylQLXaYW+Fdn7AJq5dM260g2wEFKeGS52hMNPr24x/1wDWiO0QNexoaEp
         wcu00tLxmITnGR5zxi3E10S1uwRaNG79Wd0qek9FOwS21kkZbznhkHEtCVhurCFSkgnG
         rA1A==
X-Gm-Message-State: AD7BkJJREmDyY1Gc6ziUExXmeWKugQ+Ll90f7jDSQosYviFsvnQhYOq2JzxR7HPJUZlZqhAK7mhCSXTsFQaFPw==
X-Received: by 10.107.9.28 with SMTP id j28mr9259496ioi.104.1459809854471;
 Mon, 04 Apr 2016 15:44:14 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 15:44:14 -0700 (PDT)
In-Reply-To: <CAPig+cR1mmx+2D7U8ejx8HTWbFtxbmi-85D0hgm9J48bkai6CA@mail.gmail.com>
X-Google-Sender-Auth: KoIA7NxR6Wa5hvsfN0SEmPcLbBE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290737>

On Mon, Apr 4, 2016 at 6:38 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Apr 4, 2016 at 4:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>>> Given that the ifndef/endif block immediately before this part is
>>>> also about excluding -p/-u/--patch when formatting the documentation
>>>> for format-patch, perhaps the attached may be a smaller equivalent?
>>>
>>> Perhaps. I kept self-contained to make it easier to add new options
>>> between the two if need be, but I don't feel strongly about it.
>>
>> I don't either, but the reason why I thought it would make sense to
>> have them in the same block is because hiding --no-patch and --patch
>> are about the same theme: format-patch is about presenting the diff,
>> and neither disabling diff output nor explicitly asking for diff
>> output makes sense.
>
> That's reasonable. Should I re-roll, or would you like to amend it locally?

Okay, I just pulled upon seeing "What's Cooking" and see that you
amended it locally. Thanks.
