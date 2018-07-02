Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4711F516
	for <e@80x24.org>; Mon,  2 Jul 2018 20:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeGBUcO (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 16:32:14 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36283 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeGBUcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 16:32:13 -0400
Received: by mail-qk0-f195.google.com with SMTP id a132-v6so9370578qkg.3
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 13:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jz/3akt4PkuzIfQ7XureLbifWM77C7rNHImrJ4m/J0M=;
        b=B489Hl3Xr1XNReKWEOUyzNlI6uNcwI4UCUG4ovwDl6sngfEc2eoAY++SmWPzUmBkZc
         LIfb++QtYhJ8VclqleA5u923lzqP/ztLnk4yI5wUjD3fniBgjFFHPr+8ZqYIV6yXgz8o
         Umid49bL6tWOgXQ4NOE2BKxh49r5bxl4dgbMTNjKLAoS0B6QeWoDD66H2gffrIx6tyE+
         Pbzs2/L6DsiWDYIsIW0Z3Y842Xta+qhJ3obBT9btG38krT3tRcEl0HmvJwW42EOkmNUi
         Xo9GBN7yHsbnJYn06RzHizKZcMBk8pHrSrnmagrEkhb47Nw2vaCfA5m9zN4sld9xiC9b
         JKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jz/3akt4PkuzIfQ7XureLbifWM77C7rNHImrJ4m/J0M=;
        b=hEFsptX40mCrvjHifLxyextoZnG6FNcj+rUJV3rP2W+Hj7gwg/47ysd6lisqFpEoWe
         GWAcHCKlzsRYNIKTs2HUeXjsXFMKGTzf8hnV1UxmTG57gzXFX6lmEZd9bovcbhpanBKf
         iR4WQezu4fa2dVxOvwGIimK7yAn6Kbtoa2cOtv06eLbvBUdwNR645Cs/9cBjF0J+fBR6
         QgJpUz++zbwt+3VQoaXcVqt7JU/g3ybz2SGUUoWEGjbwGL5DqM4Coeu0n35ONVr1FwZ+
         y857jIyA4+Jo5YMOT63rja+Lc6IPXF58IAiEVv6JA2f9Mh+G8DS5GnO0dhv3ZmiRENYl
         18Lg==
X-Gm-Message-State: APt69E0gIrafrshrqPge/vFUuLPuqdv/jvRraDZ36raie9EysZP/VzGO
        xvHJkDLJSUV1ufHwktEeyec=
X-Google-Smtp-Source: AAOMgpcx5pKjCEZkce5b5Sg1Aw+9EJD7Vb1dqU4318ux4cBzEs8guy/2cvre8pX3WH+W6b+RZqmMTA==
X-Received: by 2002:a37:b001:: with SMTP id z1-v6mr12048167qke.156.1530563533134;
        Mon, 02 Jul 2018 13:32:13 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q49-v6sm13671365qtc.33.2018.07.02.13.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 13:32:12 -0700 (PDT)
Subject: Re: [PATCH 08/23] commit-graph.c: mark more strings for translation
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180630090818.28937-1-pclouds@gmail.com>
 <20180630090818.28937-9-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bf4c5872-aca8-899d-2175-ae3f4eea7fad@gmail.com>
Date:   Mon, 2 Jul 2018 16:32:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180630090818.28937-9-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/30/2018 5:08 AM, Nguyễn Thái Ngọc Duy wrote:
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   commit-graph.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b63a1fc85e..c8d521923c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -77,28 +77,28 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>   
>   	if (graph_size < GRAPH_MIN_SIZE) {
>   		close(fd);
> -		die("graph file %s is too small", graph_file);
> +		die(_("graph file %s is too small"), graph_file);
>   	}
>   	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
>   	data = (const unsigned char *)graph_map;
>   
>   	graph_signature = get_be32(data);
>   	if (graph_signature != GRAPH_SIGNATURE) {
> -		error("graph signature %X does not match signature %X",
> +		error(_("graph signature %X does not match signature %X"),
>   		      graph_signature, GRAPH_SIGNATURE);
>   		goto cleanup_fail;
>   	}
>   
>   	graph_version = *(unsigned char*)(data + 4);
>   	if (graph_version != GRAPH_VERSION) {
> -		error("graph version %X does not match version %X",
> +		error(_("graph version %X does not match version %X"),
>   		      graph_version, GRAPH_VERSION);
>   		goto cleanup_fail;
>   	}
>   
>   	hash_version = *(unsigned char*)(data + 5);
>   	if (hash_version != GRAPH_OID_VERSION) {
> -		error("hash version %X does not match version %X",
> +		error(_("hash version %X does not match version %X"),
>   		      hash_version, GRAPH_OID_VERSION);
>   		goto cleanup_fail;
>   	}
> @@ -122,7 +122,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>   		chunk_lookup += GRAPH_CHUNKLOOKUP_WIDTH;
>   
>   		if (chunk_offset > graph_size - GIT_MAX_RAWSZ) {
> -			error("improper chunk offset %08x%08x", (uint32_t)(chunk_offset >> 32),
> +			error(_("improper chunk offset %08x%08x"), (uint32_t)(chunk_offset >> 32),
>   			      (uint32_t)chunk_offset);
>   			goto cleanup_fail;
>   		}
> @@ -158,7 +158,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>   		}
>   
>   		if (chunk_repeated) {
> -			error("chunk id %08x appears multiple times", chunk_id);
> +			error(_("chunk id %08x appears multiple times"), chunk_id);
>   			goto cleanup_fail;
>   		}
>   
> @@ -244,7 +244,7 @@ static struct commit_list **insert_parent_or_die(struct commit_graph *g,
>   	hashcpy(oid.hash, g->chunk_oid_lookup + g->hash_len * pos);
>   	c = lookup_commit(&oid);
>   	if (!c)
> -		die("could not find commit %s", oid_to_hex(&oid));
> +		die(_("could not find commit %s"), oid_to_hex(&oid));
>   	c->graph_pos = pos;
>   	return &commit_list_insert(c, pptr)->next;
>   }
> @@ -537,7 +537,7 @@ static int add_packed_commits(const struct object_id *oid,
>   
>   	oi.typep = &type;
>   	if (packed_object_info(the_repository, pack, offset, &oi) < 0)
> -		die("unable to get type of object %s", oid_to_hex(oid));
> +		die(_("unable to get type of object %s"), oid_to_hex(oid));
>   
>   	if (type != OBJ_COMMIT)
>   		return 0;
> @@ -683,9 +683,9 @@ void write_commit_graph(const char *obj_dir,
>   			strbuf_addstr(&packname, pack_indexes[i]);
>   			p = add_packed_git(packname.buf, packname.len, 1);
>   			if (!p)
> -				die("error adding pack %s", packname.buf);
> +				die(_("error adding pack %s"), packname.buf);
>   			if (open_pack_index(p))
> -				die("error opening index for %s", packname.buf);
> +				die(_("error opening index for %s"), packname.buf);
>   			for_each_object_in_pack(p, add_packed_commits, &oids);
>   			close_pack(p);
>   		}

These all look good to me. Thanks!
