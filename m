Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53A3A20899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbdHKRuD (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:50:03 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34891 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752901AbdHKRuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:50:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id t86so18530162pfe.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r6YowjKDCfjUDa5K1czLiLSu6CLcSpqxbEVqfZmyqys=;
        b=r/T8oBb+ZF5K6i288hVERsZ5e/udiuxzXyh08jb4rngj4zQiWp5if41TYI2ud5iQi4
         /8/sPJ3C3GN8GezuDbUQJCdXCwcamwzV3zY2gqXJ7TMnPAg13NtUje+YIdJInw8mj4nt
         EOx8zdrOqofU/EGu7+2Q+8+CDsMGAKEldGb7kBdg+CUsc1/zpaiGqk23M5TlL/17kJpd
         KnNpv25U08NYyLVl+yY0tKudPv4+HmStJaoVnhgShXnxZJkZwxWK/c2uv7F74xMmaOqz
         av8y6q+Nl9Qwi94FITb4X/a0KFpoVf+HLdp1akT1ah2XLfWyaAXzz/NrCvb4qY8xHC0B
         uBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r6YowjKDCfjUDa5K1czLiLSu6CLcSpqxbEVqfZmyqys=;
        b=QyzlFNcjqTVgq1GotSzCTB/G99wrrNv2ETEFnBrE9trA2oqmEcGUs7swNfh9c9yt91
         ccKCHDly+VN6lQPvEVZ5H/WpfqLIPTDkqhIeL1TR/1iZhfnm07Fpolof2GCSg7ApL9f4
         vdV0OompT84S0vmikAwLLqpDx99pcAtQMcnG4gWvoI+fogiHC+EcZFUAoUO0GxqGBdei
         nfTN+lvnyVMKlPYzSvBlZ9KWXRxepCKUr/UeE4taK0M3gZUWHLds31GbEP3Iw+ihRYw4
         wB1+EPn2Y6yf2oc1EodKtRh1qhFXr0OAJou2HxFyRvTLbehpCd1V4Xz8tZyJGW2Wf+Yt
         jPdg==
X-Gm-Message-State: AHYfb5h5vjjmoNoIMEmSdZThKRHkeqd6ypkFzkauzBmzoEy/qu9H4Op2
        sx7Ne0afqMgZWQPbyHSgDA==
X-Received: by 10.98.76.201 with SMTP id e70mr17215823pfj.262.1502473801121;
        Fri, 11 Aug 2017 10:50:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bd89:8abb:3c45:bf8a])
        by smtp.gmail.com with ESMTPSA id q191sm3476173pfq.86.2017.08.11.10.49.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 10:49:59 -0700 (PDT)
Date:   Fri, 11 Aug 2017 10:49:58 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170811174958.GB59325@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <xmqq3792c5sb.fsf@gitster.mtv.corp.google.com>
 <20170808180317.GA73298@google.com>
 <xmqqy3qtc3x4.fsf@gitster.mtv.corp.google.com>
 <xmqqpoc56x27.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoc56x27.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>> > +# Insert a space after a cast
> >>> > +# x = (int32) y;    not    x = (int32)y;
> >>> > +SpaceAfterCStyleCast: true
> >>> 
> >>> Hmph, I thought we did the latter, i.e. cast sticks to the casted
> >>> expression without SP.
> >>
> >> I've seen both and I wasn't sure which was the correct form to use.
> >
> > We do the latter because checkpatch.pl from the kernel project tells
> > us to, I think.
> 
> Before I forget, there are some rules in checkpatch.pl that I
> deliberately ignore while accepting patches from the list.  
> 
> I appreciate the tool for pointing out overlong lines, but I often
> find them easier to read as-is than split into two lines, as the
> ones the people send in real life rarely excessively exceed the
> 80-col limit.  We also use things like SHA_CTX that trigger "avoid
> camelcase", which I also ignore.
> 
> One thing we probably should standardize is the way the width of
> bitfields in struct is specified.  I think checkpatch.pl wants to do
> 
> 	struct {
> 		unsigned int three_bits : 3;
> 	};
> 

I couldn't find a specific setting for this, but it seems like the
.clang-format file I made wants bit fields to be formatted with spaces
surrounding the ':'.

> with SP around the colon, but our codebase does not always have the
> spaces there, and I see no technical reason not to follow suit, as
> long as we are following most of what checkpatch.pl wants us to do.
> 
> By the way, I do not recall seeing a rule about this in your clang
> format rules.  Can we spell it out in there?
> 
> I also see this:
> 
>     WARNING: __printf(string-index, first-to-check) is preferred over
>     __attribute__((format(printf, string-index, first-to-check)))
> 
> but I think it is specific to the kernel source (the macro is
> defined in include/linux/compiler-gcc.h and expands to the latter),
> so I also ignore it.
> 
> checkpatch.pl also warns a SP immediately before HT, which I do pay

I'm sorry what's 'HT'?

> attention to, as well as trailing whitespaces.  If clang-format can
> be told to check that, I think we would want to have such a rule.

Clang-format by default removes trailing whitespace.

> 
> For a reference, here is a sample set of changes to cache.h to
> squelch most of the warnings and errors checkpatch.pl points out
> that I do not ignore.
> 
>  cache.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 4e390e6af8..dec807b3b0 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -25,7 +25,7 @@
>  #define platform_SHA_CTX	SHA_CTX
>  #define platform_SHA1_Init	SHA1_Init
>  #define platform_SHA1_Update	SHA1_Update
> -#define platform_SHA1_Final    	SHA1_Final
> +#define platform_SHA1_Final	SHA1_Final
>  #endif
>  
>  #define git_SHA_CTX		platform_SHA_CTX
> @@ -260,7 +260,7 @@ static inline void copy_cache_entry(struct cache_entry *dst,
>  
>  static inline unsigned create_ce_flags(unsigned stage)
>  {
> -	return (stage << CE_STAGESHIFT);
> +	return stage << CE_STAGESHIFT;
>  }
>  
>  #define ce_namelen(ce) ((ce)->ce_namelen)
> @@ -317,7 +317,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  	return S_IFGITLINK;
>  }
>  
> -#define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
> +#define cache_entry_size(len) (offsetof(struct cache_entry, name) + (len) + 1)
>  
>  #define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
>  #define CE_ENTRY_CHANGED	(1 << 1)
> @@ -373,7 +373,7 @@ extern void free_name_hash(struct index_state *istate);
>  #define read_cache_unmerged() read_index_unmerged(&the_index)
>  #define discard_cache() discard_index(&the_index)
>  #define unmerged_cache() unmerged_index(&the_index)
> -#define cache_name_pos(name, namelen) index_name_pos(&the_index,(name),(namelen))
> +#define cache_name_pos(name, namelen) index_name_pos(&the_index, (name), (namelen))
>  #define add_cache_entry(ce, option) add_index_entry(&the_index, (ce), (option))
>  #define rename_cache_entry_at(pos, new_name) rename_index_entry_at(&the_index, (pos), (new_name))
>  #define remove_cache_entry_at(pos) remove_index_entry_at(&the_index, (pos))
> @@ -1483,10 +1483,10 @@ struct checkout {
>  	const char *base_dir;
>  	int base_dir_len;
>  	struct delayed_checkout *delayed_checkout;
> -	unsigned force:1,
> -		 quiet:1,
> -		 not_new:1,
> -		 refresh_cache:1;
> +	unsigned force : 1,
> +		 quiet : 1,
> +		 not_new : 1,
> +		 refresh_cache : 1;
>  };
>  #define CHECKOUT_INIT { NULL, "" }
>  
> @@ -1534,7 +1534,7 @@ extern struct alternate_object_database {
>  	char path[FLEX_ARRAY];
>  } *alt_odb_list;
>  extern void prepare_alt_odb(void);
> -extern void read_info_alternates(const char * relative_base, int depth);
> +extern void read_info_alternates(const char *relative_base, int depth);
>  extern char *compute_alternate_path(const char *path, struct strbuf *err);
>  typedef int alt_odb_fn(struct alternate_object_database *, void *);
>  extern int foreach_alt_odb(alt_odb_fn, void*);
> @@ -1587,10 +1587,10 @@ extern struct packed_git {
>  	int index_version;
>  	time_t mtime;
>  	int pack_fd;
> -	unsigned pack_local:1,
> -		 pack_keep:1,
> -		 freshened:1,
> -		 do_not_close:1;
> +	unsigned pack_local : 1,
> +		 pack_keep : 1,
> +		 freshened : 1,
> +		 do_not_close : 1;
>  	unsigned char sha1[20];
>  	struct revindex_entry *revindex;
>  	/* something like ".git/objects/pack/xxxxx.pack" */
> @@ -1767,10 +1767,10 @@ struct object_info {
>  	union {
>  		/*
>  		 * struct {
> -		 * 	... Nothing to expose in this case
> +		 *	... Nothing to expose in this case
>  		 * } cached;
>  		 * struct {
> -		 * 	... Nothing to expose in this case
> +		 *	... Nothing to expose in this case
>  		 * } loose;
>  		 */
>  		struct {

-- 
Brandon Williams
