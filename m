Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E37FC83F2C
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 03:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjICDnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 23:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjICDnY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 23:43:24 -0400
X-Greylist: delayed 34808 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Sep 2023 20:43:21 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9A1B1
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 20:43:21 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693712599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ndjdpDQ420m99aCA/5WJbWsTNo7ncPUGbG3Q9WJqSg=;
        b=C6fbsDTdTYE1eVqUr3cegfOqPcv8sDNZxdGoJ7jV1uLWCkW5XnC9g4wogazpLEVYJ/60OP
        1JS1SxMNWYnzdI68qJMVFEpfcrBmOqlCVzqqyQ654o9Zz9VB6p7k2+2+Y14MNiMpSM476N
        5DLNnNDAPtmniBH9Zs54AfScgsfdj+QBYTos85UiEz5uWJWVc/tmfXxSxBnc1Rn8EJk5v+
        KI+3pB2vAlvCfU/Dw8sZ/6ZkmudLSNuvA7M2c7QErfo1y9SUaaSSeeMHKJqlZI7H8BrWtu
        DbFjEymg9iX1WDu7/+FCtexSS0sAVmf8kD9a13G8N+camjlPOOubii14yEUi0w==
Date:   Sun, 03 Sep 2023 05:43:18 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <xmqq4jkcmdaw.fsf@gitster.g>
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
 <xmqq8r9ommyt.fsf@gitster.g> <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
 <xmqq4jkcmdaw.fsf@gitster.g>
Message-ID: <a879c9c7d3b9bdae9a49f67fbe6316fc@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-03 00:16, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Thank you very much for your thoughts and the time required to write
>> it all down.  I'll do my best to make my patch(es) irresistible. :)
> 
> Heh, I have to send the same from time to time, so it didn't take
> that much time.

Quite frankly, I suspected that to be a canned response, :) but anyway, 
preparing that response, and possibly refining it over a couple of 
iterations, surely already took a fair amount of time and effort.

> Having said all the above, once we start seeing the actual patches
> and its sales pitch (aka proposed commit log message), we do guide
> and help polishing the patch into a better shape, so it will not
> be like the contributor has to work in the dark without knowing
> what level of bar their contribution has to pass.

Thanks, everything sounds great and welcoming to the new contributors, 
who of course need to be willing to put in the required amount of skill 
and effort.
