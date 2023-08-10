Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C19C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 15:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbjHJPOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 11:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjHJPOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 11:14:52 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F3926BA
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 08:14:46 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id AE2AF17803;
        Thu, 10 Aug 2023 17:14:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 3D76617748;
        Thu, 10 Aug 2023 17:14:44 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hgHWRMUBXVXV; Thu, 10 Aug 2023 17:14:43 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id B7C73177A0;
        Thu, 10 Aug 2023 17:14:42 +0200 (CEST)
Message-ID: <4839a610-89da-ae6c-efb0-5d638be5d1b0@opperschaap.net>
Date:   Thu, 10 Aug 2023 11:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230810004956.GA816605@coredump.intra.peff.net>
 <20230810011831.1423208-1-wesleys@opperschaap.net>
 <xmqqmsyzhsto.fsf@gitster.g>
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <xmqqmsyzhsto.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8
        a=TzQzWd3AoDTjpjW9HhYA:9 a=QEXdDO2ut3YA:10 a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/23 10:31, Junio C Hamano wrote:
> Wesley Schwengle <wesleys@opperschaap.net> writes:
> 
>> Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
> 
> Thanks.  Again, our convention is to make sure that, even only with
> the title, readers would know what the commit is about.  The above
> does not even hint which part of the system the bug was about.  By
> stealing from what Peff already has done, we can call this
> 
>      Subject: [PATCH v2] git-svn: avoid creating more than one Term::ReadLine object

Ok. I'll keep that in mind for next time.

> Once a commit is in 'next', its commit object name will generally be
> stable, hence, taken as a whole, something like:
> 
>      git-svn: avoid creating more than one than one Term::ReadLine object
> 
>      Newer (v1.46) Term::ReadLine::Gnu would not like us to ask it to
>      create multiple readline instances.  c016726c (send-email: avoid
>      creating more than one Term::ReadLine object, 2023-08-08)
>      adjusted git-send-email to this change.  Make the same
>      adjustment to git-svn.
> 
>      While at it, drop the same FakeTerm hack, just like dfd46bae
>      (send-email: drop FakeTerm hack, 2023-08-08) did, for exactly
>      the same reason.
> 
> I'll queue the patch with the above commit log message for tonight,
> so unless you have improvements over it, there is no need to resend.

Thank you for your patience and accepting the patch(es).

Cheers,
Wesley


-- 
Wesley

Why not both?

