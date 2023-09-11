Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3B0CA0EC0
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349352AbjIKVdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjIKS4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 14:56:50 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813741B6
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 11:56:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694458603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unLIv+ZFW5tSzcuodNe26g4bTinctrNQAp4vry+/5/Y=;
        b=dybe3RmxIYFQajS2SS+4fXnsTR12WjW/DFeMOUajE1EIEaUXqtJ9D98bqV4Yv085Xb4NZ4
        Pc6uwcGTv8bjokAM22Tibq3dfdWJh3R3zN78956Rfhfw6vVF/ZH2ETCpvVPwsZiRyUVB7s
        vM0LRhZHVwzzeJ8l6TyvuYe6ppncaifpKLx3Ic23lv+6cN5hI39m78XaSi4djYWsHGZDVt
        kkpLKqZC9L+rEaDVkOIrI3GCQcJjHvOOKC0Alq9lakmNLhFzc19RNiq0miDZtDY15jUiqB
        iNRfcQgn3GBEqlSCANMM9GAeOX5tBHPjXhCHGDSqwty5MkPkfy1HMwh3TrAzsg==
Date:   Mon, 11 Sep 2023 20:56:43 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <a879c9c7d3b9bdae9a49f67fbe6316fc@manjaro.org>
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
 <xmqq8r9ommyt.fsf@gitster.g> <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
 <xmqq4jkcmdaw.fsf@gitster.g> <a879c9c7d3b9bdae9a49f67fbe6316fc@manjaro.org>
Message-ID: <261907dbfafc8d7b3b048854b663e82d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-03 05:43, Dragan Simic wrote:
> On 2023-09-03 00:16, Junio C Hamano wrote:
>> Having said all the above, once we start seeing the actual patches
>> and its sales pitch (aka proposed commit log message), we do guide
>> and help polishing the patch into a better shape, so it will not
>> be like the contributor has to work in the dark without knowing
>> what level of bar their contribution has to pass.
> 
> Thanks, everything sounds great and welcoming to the new contributors,
> who of course need to be willing to put in the required amount of
> skill and effort.

I sent a patch to the git mailing list today, about five hours ago, but 
it hasn't appeared on the list yet.  Could something be wrong with the 
mail server(s), as I also received no other messages from the list in 
the last six hours or so?
