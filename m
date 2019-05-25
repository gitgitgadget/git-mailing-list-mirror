Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B321F462
	for <e@80x24.org>; Sat, 25 May 2019 20:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfEYUsp (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 16:48:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50969 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfEYUso (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 16:48:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C0371534ED;
        Sat, 25 May 2019 16:48:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=zC0XpAGrZY84iGfYm3flIQs5+Hs=; b=XWRmpZP
        ETf+kDLd96UhlnArx6CIDQu5Fa7oOZhMoI/UdyyZ3y+ejQu2ymDiLhKs6SVFCXAa
        8GezUKwTFrAR3s0t2+kaDHj638+npZibifdEzKPMr6YJsOdsQqOSQv0/KNUcAYph
        pmN6hPqRgkuMFUWHPL4ZdODORaEJXAEEavSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=HpU6RhZMYZJUEdLBQ8trOkYe7zyhrUkCy
        3HPRiuXcpU2S8Knfjcwq7Z3LV01oXSMnazv809YhTQ61id7SX+YYeDE2Z6mN5QKE
        kIGSayJ/SYI5zeU1J6FXyFIgUvFyhww3qD5q71zsfauuhe/uppik3ZPN7ksK6vna
        flCtDvApNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64CB61534EC;
        Sat, 25 May 2019 16:48:42 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2A5D1534EB;
        Sat, 25 May 2019 16:48:41 -0400 (EDT)
Date:   Sat, 25 May 2019 16:48:40 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bryan Turner <bturner@atlassian.com>
Subject: Re: [PATCH 0/3] fix diff-parseopt regressions
Message-ID: <20190525204840.GT3654@pobox.com>
References: <20190524092442.701-1-pclouds@gmail.com>
 <20190524173642.GQ3654@pobox.com>
 <CACsJy8AgstSQKnAVf7Krg8yn03ewBw0mhOWq=CgYER-6tA8ptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AgstSQKnAVf7Krg8yn03ewBw0mhOWq=CgYER-6tA8ptw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 7AF8A9CC-7F2E-11E9-B9F3-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen wrote:
> On Sat, May 25, 2019 at 12:36 AM Todd Zullinger <tmz@pobox.com> wrote:
>> I applied this on top of master/2.22.0-rc1 and see a number
>> of compiler errors using gcc-9.1.1 with fedora's standard
>> compiler options for rpm builds.
> 
> That last patch 4/3 is not meant to be applied. Yes I've seen similar
> compiler errors too. We have some cleaning up to do in order to build
> with the last one.

D'oh!  Sorry for missing that rather obvious part of your
previous message.  The tests do indeed all pass on all the
architectures in the Fedora build system.

I'll go dig out my dunce cap from back in grade school. ;)

Thanks again,

-- 
Todd
