Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E63ACD342E
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 01:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjISB1Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 21:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISB1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 21:27:15 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59B103
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 18:27:09 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1695086827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2hdl5BDbwgqGbaWzWhIduK83VJt6cWQPAqwZ5qXxFhs=;
        b=u1+aqdueTsj87H4XO6vxczuWh2c3W3m7BjOp4Wj6s1SzHt02xa6gk5w8YD+88F+UabOmOJ
        7m4XPVQTSqWwOf7Nrz6IfXdDqPOwG1P9G+/zbdRsmdCuFl0ZYUM6H3BoNTFIcvPvNRpJIt
        b1ibDGJ8DRrBJBfzDFhWuaWJc72XZqEHqfh15UjjutsnXo3USrCnGh85G+Ow7XIMxDzTK4
        z9E5yTrEs85VEW8fN4Vy2JCzsE4IcmXWhzqeYmiD+sJ9Lei1ycelEwE8G8XiGBpL62uDbM
        8kyJMc8EWMLiZXbLtAH3ueJErwqVSYV5kXnlTPbvmEKqJeM4aoXE0XQE4Ta3nA==
Date:   Tue, 19 Sep 2023 03:27:07 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <xmqqttrrl9m2.fsf@gitster.g>
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
 <xmqqil8gs3s0.fsf@gitster.g> <487bd30e5a4cdcea8697393eb36ce3f3@manjaro.org>
 <7aceb7db8d3f4b569564ffd9d1e2e368@manjaro.org> <xmqqttrrl9m2.fsf@gitster.g>
Message-ID: <7da6c725af777a4859a99a679ac6ac32@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-18 18:38, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Just checking, do you want me to perform any improvements to this
>> patch, so you can have it pulled into one of your trees?
> 
> I do not think of any outstanding issues I spotted on this change.
> Thanks for pinging.

Great, thanks.
