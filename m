Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF3301F6BD
	for <e@80x24.org>; Tue, 31 Jan 2017 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751219AbdAaU1s (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jan 2017 15:27:48 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36780 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdAaU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2017 15:27:46 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so29551695pfo.3
        for <git@vger.kernel.org>; Tue, 31 Jan 2017 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DQXmopgOBRohpRuLK76Ez2VEqexQySlheIrZ1+EMHWI=;
        b=Dvei/0DvZloh2e1X8N3ApT6tI7fyuIINY4m3lzNz49AcIqGUkdz/fac9zuREKrZotf
         UqfjGbMvx2I7h70AMGtzTVCj2genU/GE+w/tfgFc6MzwnSccwOIDYIMjzczLTnznIH8v
         jnH1Wp6dTo6+MfYYEDa4yC8emDHG//l65EN62g8QpOgPvopcjH6b44yZdurdR4yDxwct
         3lB7AqQoA+e49VzOjP3EBH4jRcAbysn5hvgO9eDLbHKj2nVt1oeJBGybC6EsLJ/4tOpY
         ETcRlHpEtzFf7BXOOIbsKnL1p2+PDE6tzuPlqk33rvCfTePnEsRJkkETzHDiTUtEiOaL
         xWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DQXmopgOBRohpRuLK76Ez2VEqexQySlheIrZ1+EMHWI=;
        b=CQ1cRmJttqJF5czjcqDIjDJaX8mR5mWPrDnaQ3gqdkAXJmgMvnZA1cJ06cclugzx5J
         5bulNcRdPZcGuWwWJUsJlL/FIhwq4ZfFFujyY0hfqSmC9XIXrAcUeiHAK56PdMpM/ET5
         v51AMk94dWnS4XfSG2VH6VRbwKhGDaocPSW6zTLecDV2GaeXaM1548FmbG6Rs1csBq0B
         DBXYmy4kgZL6AoN8UlzZ8JEOzW76OEtSj5sMfW+3p32Koi4YBYlpMxM0Ii6LIjXXGdUH
         APsoaRZF0J4EdVw3DgyRNW8hIRf3tqx/lTNRy2oj1mPHqUHk4OeC5wCK8xs1t0OiMP9j
         xcNQ==
X-Gm-Message-State: AIkVDXLu32oDaWArsRBxtQ0H9R0STVTBtmLycFeo8x2ZpxXWNcGsxXpAVaUKdiP6c11DtA==
X-Received: by 10.84.128.33 with SMTP id 30mr42282190pla.128.1485894466008;
        Tue, 31 Jan 2017 12:27:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a052:8a35:4bb5:b253])
        by smtp.gmail.com with ESMTPSA id 75sm43295414pfp.80.2017.01.31.12.27.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Jan 2017 12:27:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: vger not relaying some of Junio's messages today?
References: <20170127035753.GA2604@dcvr>
        <20170127040139.wz7xmizccjigz5ui@sigill.intra.peff.net>
Date:   Tue, 31 Jan 2017 12:27:44 -0800
In-Reply-To: <20170127040139.wz7xmizccjigz5ui@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 26 Jan 2017 23:01:39 -0500")
Message-ID: <xmqqpoj3q8jj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jan 27, 2017 at 03:57:53AM +0000, Eric Wong wrote:
>
>> I noticed both of these are are missing from my archives
>> (which rejects messages unless they come from vger):
>> 
>> <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
>> <xmqqefzp1d1x.fsf@gitster.mtv.corp.google.com>
>
> I don't have them either, so presumably vger ate them (I usually delete
> my cc copies after reading and keep the list ones, and I now have
> neither).
>
>> Not sure if there's something up with vger or Junio's setup because
>> other messages (even from Junio) are getting through fine.
>
> Sporadic failures, especially on a single topic, imply that something in
> the content may triggered the taboo filter (though often that takes out
> replies, too, which this doesn't seem to have done).

I think I figured this out yesterday.  

It was a dot somewhere in the name of a recipient on To:/Cc: line
that is NOT double-quoted.  For this thread, brian's human-readable
name "brian m. carlson" was double-quoted in the original I
responded to and it also was double-quoted in my response.
But there was another recipient with a dot after the middle initial,
which was NOT double-quoted in the original.  

My response seems to have been eaten because that name was not
double-quoted.  I saw that happen yesterday in another thread with
the same recipient, and resent with the only change to double-quote
that name and it went through.
