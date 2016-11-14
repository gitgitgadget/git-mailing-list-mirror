Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006841F858
	for <e@80x24.org>; Mon, 14 Nov 2016 15:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbcKNPbM (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 10:31:12 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59006 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752399AbcKNPbK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Nov 2016 10:31:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A59C92091D;
        Mon, 14 Nov 2016 10:31:09 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 14 Nov 2016 10:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=F3Fj0NcFCxbuDfn
        eY64l2CaSDbQ=; b=NJ3qf8z9OkWrjKzXJnoHHwYS8owCfGU0WEWo63u4jwXPOy+
        qe8vQSqEn76FhwNpl7mb9Qni4q7jcW4JuV/jyfS2hHbKcrcaucMyskO99+kL+H+F
        r/TTKc5uZ6j20umhvGu12Zjr2Rshg7LCZ5PDJNdjGpwKCjP7hWWzXPTuUHdc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=F3Fj0NcFCxbuDfneY64l2CaSDbQ=; b=tZQuBlG952hcIZ2xNtJi
        vSZHo9t60Uz8AicWlfwcgqICRj6UrOL0m94UUH2N88QT9rXN6yzE9lyopseUqH6J
        ueoIbY3cJ6rI87w8quwBGiv5jk+CI/jHrseyVb6UgkX+h7nKCKrR1suiEDlRwFBA
        dng6LzZE11FaUSPzta6ws1I=
X-ME-Sender: <xms:vdgpWN8YCpC9nJAYD6a7h4H_AHi3cYYPgnYwFeQErgWNwhIJeBlqxQ>
X-Sasl-enc: 8Rv6D7MvU2nj7HhMt5CiEJv+vkZWFwmrIdZwO6qqqgqm 1479137469
Received: from UltraSam.fritz.box (ip29.236.mip.uni-hannover.de [130.75.236.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id D33877E046;
        Mon, 14 Nov 2016 10:31:07 -0500 (EST)
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
 <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xrFYj7sepdz1xrEEaqmXQWfRkBz3CsWjYK6OZsZRMLbUA@mail.gmail.com>
 <alpine.DEB.2.20.1611121106110.3746@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Git mailing list <git@vger.kernel.org>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <0c39be16-76f8-0800-41a2-b7b1dccdd652@drmicha.warpmail.net>
Date:   Mon, 14 Nov 2016 16:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1611121106110.3746@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 12.11.2016 11:08:
> Hi,
> 
> On Fri, 11 Nov 2016, Jacob Keller wrote:
> 
>> On Fri, Nov 11, 2016 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>>>
>>>> No tests or documentation updates yet, and I'm not sure whether
>>>> --follow-symlinks in other modes than --no-index should be supported, ignored
>>>> (as it is now) or cause an error, but I'm leaning towards the third option.
>>>
>>> My knee-jerk reaction is:
>>>
>>>  * The --no-index mode should default to your --follow-symlinks
>>>    behaviour, without any option to turn it on or off.
>>>
>>
>> I agree. We shouldn't have to specify this for no-index.
> 
> Ummm. *My* idea of --no-index was for it to behave as similar to the
> --index version as possible. For example when comparing directories
> containing symlinks. You seem intent on breaking this scenario.

*My* idea of --no-index was for it to behave as similar to the
--index-version as possible, regarding formatting etc., and to be a good
substitute for ordinary diff. The proposed patch achieves exactly that -
why should a *file* argument (which is not a pathspec in --no-index
mode) not be treated in the same way in which every other command treats
a file argument? The patch un-breaks the most natural expectation.

Michael

