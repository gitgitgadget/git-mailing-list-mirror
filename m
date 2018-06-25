Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DCF01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 19:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755629AbeFYTp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 15:45:59 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55467 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754532AbeFYTp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 15:45:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id v16-v6so802179wmv.5
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pxFrVmW16B+o2KntpIsLNweyd+pZrrpmpiiYZr+AAUc=;
        b=BZfA+aeo4QoZ9yaSVkCYCPb2m6yA7gy1O10w10BSgZYXOL5DYcMCt94CgDPxYSBY2G
         4TCc4hlgVqY+EvvmhoOv9XJmrguGHEdoTVgDMhs3A5Y4GY5pz+WumO7ALQDtyM3sCBlp
         vXfDXGyTChmqXKSHG1Y/f637DiWNNcyiCUaal0ggp2W663EkcMHIj1Wvl9kgTjNIswkH
         Fqo9YN86VgW4aaH7AQ9emHTj3Ppn66rXejpRugP8sB3gHvWrizYq+F3MCjwqANlK+qJ/
         0Eaq/6anp2D02D/vtNr4LAhV0p4CcBUjPDyVTS0d5WD8rXQaUSIQUSQDvpn/t8bMhEuX
         xfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pxFrVmW16B+o2KntpIsLNweyd+pZrrpmpiiYZr+AAUc=;
        b=RahvYc+Hyep008YP5b4AyzDpT3QogeFr/pSpcv8QX5RJAq3TjfU4/6a7YW2+KUNAU0
         1Fc1lq7FmqkaqFAgHkU9Yd/tVXI9f8eR+r/ZSXnLvrOBnF0rGjBHVrJlP/ZX+XqaNyUH
         UAvc8pu+OjZzd30Ti6rKoacwm16oB3SNqLnxJH6wOjjTpTQJ/nPrFHcDmEE7DIechnvN
         o7O8P1EEp//Zdk1XIeb6f5K+xFicqbMG4tjLtxHQYfQ4h+nhIZON/33XPfAxC4nZdr74
         UJqRDYwPSvCPr7vbPvpLihbMerNYkv+lY1WikxnIBzDTmQlUEiszOlKELREQ22L4WT+l
         plGQ==
X-Gm-Message-State: APt69E36ORFJ+yw/D2N6kiMtWMyyF4JqT3bUvu/vVE9HJcF/u+tts1Sv
        0ElMI4MkFn0HxXdkEwulyvg=
X-Google-Smtp-Source: AAOMgpcHpGwUzFil7UtMRXrSCnNE3kwu+SgVhB+6NDW/4uhEvyNdOQoFby4BNdgUc+ziYe5AxjPBgw==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr1935676wme.159.1529955956966;
        Mon, 25 Jun 2018 12:45:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o3-v6sm6823651wrj.48.2018.06.25.12.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 12:45:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 07/24] multi-pack-index: expand test data
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180625143434.89044-1-dstolee@microsoft.com>
        <20180625143434.89044-8-dstolee@microsoft.com>
Date:   Mon, 25 Jun 2018 12:45:55 -0700
In-Reply-To: <20180625143434.89044-8-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 25 Jun 2018 10:34:17 -0400")
Message-ID: <xmqqbmbyodjg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>  test_expect_success 'write midx with no packs' '
> +	test_when_finished rm pack/multi-pack-index &&

It is generally a good idea to give "-f" to "rm" used in
test_when_finished.  The main command sequence may have failed
before it has a chance to create that file; even though an error
will be ignored by the when_finished handler, it is a good code
hygiene to mark expected condition (e.g. the file to be removed may
not exist at this point) to signal to future readers that the author
knew what s/he was writing.

>  	git multi-pack-index --object-dir=. write &&
>  	test_path_is_file pack/multi-pack-index &&
>  	midx_read_expect
>  '
>  
> +test_expect_success 'create objects' '
> +	for i in `test_seq 1 5`

Please write it as "$(test_seq 1 5)"

> +	do
> +		iii=$(printf '%03i' $i)
> +		test-tool genrandom "bar" 200 > wide_delta_$iii &&

	test-tool genrandom "bar" 200 >"wide_delta_$iii" &&

i.e. no SP between the redirection operator and the target file
name.  Also dq around target file name that depends on variable
substitution to tell bash that we know what we are doing (some
vintage of bash will throw warning at us unless we do so).

