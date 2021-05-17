Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35E5C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF4761209
	for <git@archiver.kernel.org>; Mon, 17 May 2021 22:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhEQW4W convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 May 2021 18:56:22 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29546 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbhEQW4W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 18:56:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14HMt01V075448
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 May 2021 18:55:00 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Felipe Contreras'" <felipe.contreras@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <60a046bd83001_f4b0f20861@natae.notmuch> <87tun1qp91.fsf@evledraar.gmail.com> <xmqqlf8d6ty5.fsf@gitster.g> <60a2f1c4cab0d_13c3702083a@natae.notmuch>
In-Reply-To: <60a2f1c4cab0d_13c3702083a@natae.notmuch>
Subject: RE: Man pages have colors? A deep dive into groff
Date:   Mon, 17 May 2021 18:54:54 -0400
Message-ID: <00b701d74b6f$aa295ed0$fe7c1c70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQG8szg0z7u7XUi8vhGaqVAqgYqVBAHrRCynAMrlZaQChqFQYarzkSvQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 17, 2021 6:44 PM, Felipe Contreras wrote:
>Junio C Hamano wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>> > This looks much better.
>> >
>> > I wonder a good follow-up (hint, hint! :) would be to have
>> > exec_man_man() and exec_man_cmd() in builtin/help.c set this
>> > depending on color.ui (so we'd do it by default with "auto").
>> >
>> > Then e.g. "git help git" would look prettier than "man git".
>>
>> As long as color.man.ui can be used to override the blanket color.ui,
>> I think it is a good idea.
>
>Why not use color.pager?

I think there is a lesson to be learned from git checkout; specifically not to overload semantics. Manual representation is a presentation world unto itself that has should not be blended with programs like less. More than that, being someone who loves automated documentation generation, manual representation has a broader semantic that should not be dismissed. There are probably a whole class of colours that ultimately might be requested - might be me - so I'd rather not blend these into color.pager.

Just my tuppence. 

-Randall

