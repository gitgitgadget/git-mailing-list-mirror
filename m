Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC011F403
	for <e@80x24.org>; Tue,  5 Jun 2018 20:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752310AbeFEUjL (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 16:39:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41975 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbeFEUjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 16:39:09 -0400
Received: by mail-pg0-f68.google.com with SMTP id l65-v6so1790544pgl.8
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PqIyg/c5uzMqQG+/5qJNiOimIO2UvF0JlbV3URoy5ec=;
        b=AfcV6pK4mw2UaxQui2lDJjxPYnQp/IDzjFD4utI+4bYWBDIVug7NkOjm8Vp8ICA5fV
         BOVksXjTB6cW7Mds2xDUZP/g6Rqp2bFZj0L4KVxtUjop2g6mqYfxVsUs5SZi6grvyZaK
         CQ1vDwshhPYIhmi6x4S0ngBRXYT6Oe00cyCUEWyF6FDhYdeBUFnofgtHwbOJ60ImtW6a
         KlfmCtpYSFUm2XnKFN3h3K4zb8cX5ceycMlZ0ap8xzez6MjMoZIYYARbWOWX7S143m2j
         92ZquzP9uHddOtqBPyAOkYRWUc0TyWA/kNLAuslphbemFspDSljyIC7nz607PHNrAKGS
         6G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PqIyg/c5uzMqQG+/5qJNiOimIO2UvF0JlbV3URoy5ec=;
        b=b9TM74FBM0Zw8am4vpY6vAJ3BlXKAQ5O1IZlhFsrFt78NCgHCDZ5nqGqxEf2mnx0J/
         9ApqRNsr1/GaIRMNy2mQAmjyKvODrt4IUOLT1hqB5/V8R0ZBpMabWtjfQtH12n1L0B19
         wPf4CzFBBNscJqPuOjdQ2wwsOxPCyuzgfONoUNJWCMPQwFz1miTWmJ00nMWT9w2rDMtM
         ly6F/z4EZTr8JK0dcb95h+0EXlaoa0OfkOxjiibYdHITZu3jbtdbkVPnNMPNKnbMd7Ju
         1bffo54oeETCnnXzaVpTfxmlWsK2qXknOOmKv12wrsEuAtd0CsltHfl1As7Jw7zZZOx1
         DXJg==
X-Gm-Message-State: APt69E0JN98+mU+49mONLmn7vk09n8r9GtzER6vxnINXOpP5pzpV7FZU
        UqVGoHifDuzm2bycTD02IU4oL/i/IGE=
X-Google-Smtp-Source: ADUXVKJyLriSSDaCF68ysVv4KZB4RKEVWzbx6gO7YfRqJAV1IhPqmVqxBzz5y+nW7e99IiwPanZwNA==
X-Received: by 2002:a65:50c7:: with SMTP id s7-v6mr107420pgp.359.1528231148752;
        Tue, 05 Jun 2018 13:39:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a22-v6sm12025363pfi.124.2018.06.05.13.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Jun 2018 13:39:07 -0700 (PDT)
Date:   Tue, 5 Jun 2018 13:39:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs: link to gitsubmodules
Message-ID: <20180605203906.GD158365@google.com>
References: <20180605202449.28810-1-bmwill@google.com>
 <87o9gpynsp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9gpynsp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/05, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jun 05 2018, Brandon Williams wrote:
> 
> > Add a link to gitsubmodules(7) under the `submodule.active` entry in
> > git-config(1).
> 
> Did you mean to change either the subject or content of this patch? Your
> subject says gitsubmodules(7), but you link to git-submodule(1).

Yep I meant for it to be to gitsubmodules(7), turns out I don't know how
our documentation is built :)

-- 
Brandon Williams
