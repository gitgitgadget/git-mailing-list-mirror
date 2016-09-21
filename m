Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9732C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935961AbcIUS2q (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:28:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35842 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935898AbcIUS2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:28:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id b184so10057308wma.3
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pcKBeuKBGvhtxMmljsjyW0S6HtXvet7hWgnllwQH7mY=;
        b=aPb+oMqdVRXbY+f5jAW37RGGDMxiWp+5/rVNjq8PYZu7MFwkKQscqYjT6x4lVBu/kt
         Xnm6b/L0n7nbMWuPLHMmZtnD1yeogtQNxGl3OUiLto3PhimnJJYALow4O/T/ukgBrstm
         Fprp1LuroqiDYiHeaV6xqOrkB83FZ8Se1nCQJwX93wpVUL7CFgrScfh5LnzqnlgwIfxk
         qWfrtFaFARWcLBM7bRredWCEuNgyHzAFmyKePt3Fc8D1bn3LjPlOWa9YPN7Wr3jn8Paw
         yaaIZA00CcD9fOYes+KyQulvj2QOYip3H7pilPHSfHyA7vhlq7WlOuNFHUdbxeU5ltxX
         MKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=pcKBeuKBGvhtxMmljsjyW0S6HtXvet7hWgnllwQH7mY=;
        b=hIXOqBrz+K2jlKehyZ/x+zDrbEg30Ho2qZsTHTsecajA/7QD+AuiLwl4hrvGzJyyPQ
         /kTQVzGqzW/TP3WgY9BVw5szHZVhc4gO+Di+w+UvsFo6FPdpf2sZz9Jffjgb01dvRTHS
         KVL/VYfKvqDKlnZ6VjGuFk51//tsgpvN/Ae7tgwx5FsiQZUbIiHT7r0ID8vRU7DX+DyH
         WidaUDq/EVhaw0cilFUj0C9sVKyfLHg4Kefphe8WkX1+V/chtR9mP/Tb2NRjAwP1mQAj
         ouTSDs8EH0yiZmL3V5TI3i6mjQ0ZPAOUTEQXvrNBWDBjLSEhGOp1SYZtlsOXXaaPYzJ2
         CUbw==
X-Gm-Message-State: AE9vXwMZ9iP1fpAk9CpNreuefDlyOuhs5VdlqBr5nmt1Tkf0equh+PqLjo+FVp5WTNP6og==
X-Received: by 10.28.97.69 with SMTP id v66mr4307411wmb.12.1474482523590;
        Wed, 21 Sep 2016 11:28:43 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id 4sm33647963wmu.2.2016.09.21.11.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 11:28:42 -0700 (PDT)
Subject: Re: [PATCH 2/3] gitweb: Link to 7-character SHA1SUMS in commit
 messages
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
 <20160921114428.28664-2-avarab@gmail.com>
 <64389bcb-c6e4-1d19-54a1-650868b9acb5@gmail.com>
 <CACBZZX5mYuDUMHfurKEbCqodZkhYygQz+-G6VmKW+AMnCycm9g@mail.gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <88635d93-5288-c933-273a-003e5df824af@gmail.com>
Date:   Wed, 21 Sep 2016 20:28:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CACBZZX5mYuDUMHfurKEbCqodZkhYygQz+-G6VmKW+AMnCycm9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 20:04, Ævar Arnfjörð Bjarmason pisze:
> On Wed, Sep 21, 2016 at 6:26 PM, Jakub Narębski <jnareb@gmail.com> wrote:
> 
>> P.S. I have reworking of commit message parsing and enhancement in my
>> long, long and dated gitweb TODO list :-(
> 
> Anything specific you could share?

Some of TODO I would have to bring from backups, as the computer on
which I did majority of gitweb development has since died (from old
age).

The list includes:
- implement caching of gitweb output
- revamp handling of encoding (UTF-8 with fallback encoding)
- split gitweb into modules, while maintaining ease of install
- refactor handling of diffs
- better handling of config files
- document URI structure, perhaps revamp URI parsing and generation
- make commit message transformation generic
  (see below)

> 
> One thing that would be a lot faster in Perl is if we didn't have to
> pass the log around as split-up lines and could just operate on it as
> one big string.

Well, there are a few transformations that commit message undergoes
in gitweb, including linking SHA1, optional linking of bug numbers
to bug tracker, and syntax highlighting of signoff lines (trailer
lines).  

I would like to have this cleaned up, and refactored.  With all
those transformations we would need to keep account which parts
are HTML, and which not and need escaping (note: URI escape !=
HTML escape).

> 
> It would make some code like git_print_log() a bit more complex /
> fragile, since it would have to work on multi-line strings, but
> anything that needed to do a regex match / replacement would be much
> faster.

Would it?  Did you perform any synthetic micro-benchmark?

> 
> But OTOH I think perhaps we're worrying about nothing when it comes to
> the performance. I haven't been able to make gitweb display more than
> a 100 or so commits at a time (haven't found where exactly in the code
> these limits are), any munging we do on the log messages would have to
> be pretty damn slow to matter.

sub git_log_generic {

	# [...]

	my @commitlist =
		parse_commits($commit_hash, 101, (100 * $page),
		              defined $file_name ? ($file_name, "--full-history") : ());

Here you have it (it probably should be a constant; this number can be
found in a few other places).

Best,
-- 
Jakub Narębski

