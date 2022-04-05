Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA272C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 02:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiDECtt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 Apr 2022 22:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiDECto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 22:49:44 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CCC123410
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 18:56:11 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2351u7FH008258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Apr 2022 21:56:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?iso-8859-1?Q?'Carlo_Marcelo_Arenas_Bel=F3n'?=" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com> <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com> <034701d84875$030bfb40$0923f1c0$@nexbridge.com> <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
In-Reply-To: <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Mon, 4 Apr 2022 21:56:02 -0400
Organization: Nexbridge Inc.
Message-ID: <035301d84890$51449810$f3cdc830$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE87yXqDmaysdJkpyH6/spM26GbOgJ005kMAt5RIzwA5EjRSq3lhqjg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 4, 2022 8:26 PM, Carlo Marcelo Arenas Belón wrote:
>On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
>> On April 4, 2022 6:33 PM, Junio C Hamano wrote:
>> >To: Randall S. Becker <rsbecker@nexbridge.com>
>> >Cc: Git Mailing List <git@vger.kernel.org>;
git-packagers@googlegroups.com
>> >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
>> >
>> >CSPRNG_METHOD?
>>
>> We already have
>>
>>         CSPRNG_METHOD = openssl
>>
>> In the config for NonStop. Should that not have worked?
>
>only if you are not telling your openssl to hide that function[1]

There is nothing in our code that causes that.

