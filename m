From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Tue, 16 Jun 2015 10:57:16 -0700
Message-ID: <CAPc5daXuJWyi2Zc-Su9w1Rn38wjTkZNo4zML8m3Hq_EwoBjnfg@mail.gmail.com>
References: <1434440167-1046-1-git-send-email-pastith@gmail.com>
 <xmqqr3pb5zl1.fsf@gitster.dls.corp.google.com> <CACvVhd6j_zWpvfXti1=U8iOaXE+oTUtmjrHu39VR12UNBxkY4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Panagiotis Astithas <pastith@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:58:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4v7M-0003Aj-FQ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227AbbFPR5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:57:39 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34048 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbbFPR5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:57:37 -0400
Received: by oigx81 with SMTP id x81so17068404oig.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=DNpVqxuyQJ8zmhABT1qog/z8Kjl4v9sl7LLgyoTrV4E=;
        b=dzM8iz9zMWVjKk/WPg1o8Wv+yKFFrUc/1N9GyROiZoygBdM3ikQ24RieyAC0SF47yb
         jC8w1VsyyszYYrBWMOiXPaKIBNOj2L1pKhtZoAj3hDNhPnPgjrjHWWfcoCiopjAE/kPQ
         wVRJbcr6yCbFekqS8GaJkxmyjKUcz8N1kczstnLXFLm09PXOBgGL08F5vur+d31ff48E
         PEJq1gnTRnNbZKOU8hrgwkmHhQQBHLyoSvIuKqWHzaBgaoyMJ2ePi3JH9tYrkSrrXYlp
         qGyVz+4YGXz814PLLC7aUu1iaTtlEjLtp6T/F+DuPeGjP8v5IGeZ5a78oplQQDKoh0sk
         mprA==
X-Received: by 10.202.200.131 with SMTP id y125mr1213883oif.20.1434477457308;
 Tue, 16 Jun 2015 10:57:37 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Tue, 16 Jun 2015 10:57:16 -0700 (PDT)
In-Reply-To: <CACvVhd6j_zWpvfXti1=U8iOaXE+oTUtmjrHu39VR12UNBxkY4A@mail.gmail.com>
X-Google-Sender-Auth: C6Vi9mwvmfaMBwj4Mk2wpJPMupw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271787>

Ah, thanks.  Not many people do that, so I was wondering what was going on ;-).

On Tue, Jun 16, 2015 at 10:35 AM, Panagiotis Astithas <pastith@gmail.com> wrote:
> On Tue, Jun 16, 2015 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Panagiotis Astithas <pastith@gmail.com> writes:
>>
>>> The output of "pmset -g batt" changed at some point from
>>> "Currently drawing from 'AC Power'" to the slightly different
>>> "Now drawing from 'AC Power'". Starting the match from "drawing"
>>> makes the check work in both old and new versions of OS X.
>>>
>>> Signed-off-by: Panagiotis Astithas <pastith@gmail.com>
>>> ---
>>
>> Hmph, is there any difference between this one and the original one
>> that I already queued several days ago?
>
> None, I was just following the process outlined in SubmittingPatches
> that mentions a separate email after the discussion is over.
