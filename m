Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C568A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 22:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbeGXAA7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 20:00:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36478 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGXAA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 20:00:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9-v6so2239435wro.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E8pYvoXD6Gyv7TE+aviIoi+HfcqdqB7SD+hJALT4Fc4=;
        b=Oaka0ykmj5EhLQI0qm3+VuQylcZWx65cAXgSrIFlelakRp0efXoXmeANnzzxiItw2H
         L9Uz+9KPx381T+8L1X2yQTtGlqGuLhuJc7VAuv7EWQVeWCIlbavc9URuJiYlSBSWaKWD
         3aMv2lJhX14Qz+7sjEewAL8lRk0lhj+BwT1V7jFFWoArmkhSZRAitN3graTQAd309gWd
         Lg1vfWMK0Jl+w1/RT7Ll7VpMiUs7dI+HWldSkQnN0csD+yLENBVsxGEP/aBjj+Xr6WTT
         COuQJJFZFxoYEo6x78hou4SVJRYXTAEjRUDRApZNL9PrWtF91OhL0A7tRblxJ4JgA+01
         TvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E8pYvoXD6Gyv7TE+aviIoi+HfcqdqB7SD+hJALT4Fc4=;
        b=aUeRsIAJfgtPAMrqUga7sHbt+csandLjfKRV+TDNS9NxOfSy+xbDe4Hfn8BSDCldee
         y1zLxRiykGRY3bvtv6bbqtBzk7WnrQwDPgLVmuGjLntv8iZYtjSpKWMVl88/dQ7vr1GX
         5YXFUEg7hyRlmhPKdh+27qrPWQ+IJGP+fD6FfzobaVPFXJsgWtbMvw4yFQa/xAPRxYmM
         UJ3kTm7/V6L/lIPzrJQCiWqhdGsjYqWpWREVH1KvW1EKhPIhPvvOvVxx4nkfNpgxjoBg
         MIhw2hnusFt8TwfvjaL+0zxlCsuMKbOcSEA7ohLm2RpMF39jaYgLDGe4MD/ByaO4065Q
         SfpA==
X-Gm-Message-State: AOUpUlEwpDRoZggotT61JCjL/iitubCm+mMrS2TwVUpBH23ZEWSJ8k8K
        tKkOnmYwzJpminpYFy8f7eWHXkrl
X-Google-Smtp-Source: AAOMgpe6ZUvPws6av4CusU2OpUL8elk9HbN/uQAqDH1mPYEu7VRPq0Ob1yDNwDoB0bcczFNENmB6hg==
X-Received: by 2002:a5d:4147:: with SMTP id c7-v6mr10288705wrq.61.1532386650672;
        Mon, 23 Jul 2018 15:57:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 35-v6sm10144708wrh.52.2018.07.23.15.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 15:57:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: mark die strings for translation
References: <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
        <20180723175635.31323-1-bmwill@google.com>
Date:   Mon, 23 Jul 2018 15:57:29 -0700
In-Reply-To: <20180723175635.31323-1-bmwill@google.com> (Brandon Williams's
        message of "Mon, 23 Jul 2018 10:56:35 -0700")
Message-ID: <xmqqpnzd36hy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  fetch-pack.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

I do think this is a good idea, but what release does this target?
It does not seem to apply to master@{4.hours.ago}, and I do not
think a change as trivial like this wants to be taken of a hostage
of _all_ topics that are in 'next'.


> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0b4a9f288f..51abee6181 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1245,13 +1245,13 @@ static int process_section_header(struct packet_reader *reader,
>  	int ret;
>  
>  	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
> -		die("error reading section header '%s'", section);
> +		die(_("error reading section header '%s'"), section);
>  
>  	ret = !strcmp(reader->line, section);
>  
>  	if (!peek) {
>  		if (!ret)
> -			die("expected '%s', received '%s'",
> +			die(_("expected '%s', received '%s'"),
>  			    section, reader->line);
>  		packet_reader_read(reader);
>  	}
> @@ -1289,12 +1289,12 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
>  			continue;
>  		}
>  
> -		die("unexpected acknowledgment line: '%s'", reader->line);
> +		die(_("unexpected acknowledgment line: '%s'"), reader->line);
>  	}
>  
>  	if (reader->status != PACKET_READ_FLUSH &&
>  	    reader->status != PACKET_READ_DELIM)
> -		die("error processing acks: %d", reader->status);
> +		die(_("error processing acks: %d"), reader->status);
>  
>  	/* return 0 if no common, 1 if there are common, or 2 if ready */
>  	return received_ready ? 2 : (received_ack ? 1 : 0);
> @@ -1331,7 +1331,7 @@ static void receive_shallow_info(struct fetch_pack_args *args,
>  
>  	if (reader->status != PACKET_READ_FLUSH &&
>  	    reader->status != PACKET_READ_DELIM)
> -		die("error processing shallow info: %d", reader->status);
> +		die(_("error processing shallow info: %d"), reader->status);
>  
>  	setup_alternate_shallow(&shallow_lock, &alternate_shallow_file, NULL);
>  	args->deepen = 1;
> @@ -1346,7 +1346,7 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
>  		struct ref *r = NULL;
>  
>  		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> -			die("expected wanted-ref, got '%s'", reader->line);
> +			die(_("expected wanted-ref, got '%s'"), reader->line);
>  
>  		for (r = refs; r; r = r->next) {
>  			if (!strcmp(end, r->name)) {
> @@ -1356,11 +1356,11 @@ static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
>  		}
>  
>  		if (!r)
> -			die("unexpected wanted-ref: '%s'", reader->line);
> +			die(_("unexpected wanted-ref: '%s'"), reader->line);
>  	}
>  
>  	if (reader->status != PACKET_READ_DELIM)
> -		die("error processing wanted refs: %d", reader->status);
> +		die(_("error processing wanted refs: %d"), reader->status);
>  }
>  
>  enum fetch_state {
