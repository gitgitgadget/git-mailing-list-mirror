Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE761F794
	for <e@80x24.org>; Wed, 25 Jan 2017 22:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdAYWyb (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:54:31 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35342 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdAYWya (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:54:30 -0500
Received: by mail-lf0-f51.google.com with SMTP id n124so136661564lfd.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ONiL/j7KLDyzXMbmf/vIv7r0+2NHq6ee7ZzJ30om2Ro=;
        b=EV9LvK/PjBjXQcDOHWYU7vj7fCeqrA1amS/1bilA+A/WzbEWcJZ03wmjup8ahV3vx7
         LAFD14ihwkL80yE3amQ7xBwRB3kFFm7TLhBvnmdDFHK9pLZbGthccxWsua4wTl3PveDE
         Lvd1e1TZrmsViblaL6MQC3JpZ/8ia2pLD4pV2UtQzPtkYAglpKgIgyGvd1OCWTV8HkSw
         VdMOQASnEv9GRZanOC/VrkJ7q935q8Akc07cBpnRrnIRb06K3A7C3S6zrV9qYbZrZude
         5+ChOU8Rc74F4sHBDbBxvQn3DfUcFK0xty8ixpo9XXmBA6y6DYl3Y+93AxWu6s8jBia3
         oPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ONiL/j7KLDyzXMbmf/vIv7r0+2NHq6ee7ZzJ30om2Ro=;
        b=df+k9VJ6CNkOxBgfZMNL5FoIw8HivXDrls0prdEuPOfm1sehsbIW/njsBOUhFq6Qjc
         zrMLFj9XXr5gXb3rfICBw2r0CafF6x4VN6qggz6RP/KFyX3Qe9zRyWEpc2TodUjjZiqh
         CIi/q/3HvOik5rQG7Fzo2TxjASeNaZrtw3GoY+SsEl+JG6g+ZJXef9qgdqQkOLyMy+he
         cFWP3BnZPluBQhXPjrt6ZMwc5HyVO36vu5xbKl7z+x5xNhGFCubHLYYTXzMsXJ11Nki6
         DJMKjZtx2DVZHt83bSdyxZPgFm2K84Eepvu43HsKW0bnnes5fBBPOVQT7XYdA1sW5CsU
         dZhQ==
X-Gm-Message-State: AIkVDXL4Qf+GKBmPAO7Pd5zppEir+tLc84voZTLMs/EC2XLJkIzJ+cyASq3ubqTbG+o11v56Ibuyz1aXzyc7/A==
X-Received: by 10.25.74.72 with SMTP id x69mr13528230lfa.66.1485384868814;
 Wed, 25 Jan 2017 14:54:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 25 Jan 2017 14:54:08 -0800 (PST)
In-Reply-To: <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
References: <CAE1pOi2YZayEfKxxh3gsTds1mQ9L1E9AW=wPnmW=Dg=-EMj=tw@mail.gmail.com>
 <CA+P7+xrupLuYAj7tn_1EaUiN6eaCmtgX-_d4mnByDq95cuqiWQ@mail.gmail.com> <CAE1pOi3eh7ao3NocV=PRFDby8y5ttjFR=-_VB0FoJv4MpjExaA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 25 Jan 2017 14:54:08 -0800
Message-ID: <CA+P7+xo9WBwHjAXeUTn4bh=F6hvw1gA-79h-GmwQoeRpeLj2jQ@mail.gmail.com>
Subject: Re: Force Confirmation for Dropping Changed Lines
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:51 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> On 25 January 2017 at 14:24, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Wed, Jan 25, 2017 at 2:16 PM, Hilco Wijbenga
>> <hilco.wijbenga@gmail.com> wrote:
>>> How can I force Git to not assume my change to the first line is "redundant"?
>>>
>>
>> My guess is that you probably want a custom merge driver for your file
>> types. That's where I would look initially.
>
> Mmm, that sounds complex. The "my-code.x" is made up so I could keep
> my example as simple as possible. In reality, it's Maven's POM files
> (pom.xml).
>
> So there is no setting for any of this? There is no way to switch off
> auto merging for certain files?

Not really sure, but a quick google search revealed
https://github.com/ralfth/pom-merge-driver

Maybe that will help you?

Thanks,
Jake
