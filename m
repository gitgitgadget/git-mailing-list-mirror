Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFA31F97E
	for <e@80x24.org>; Tue, 20 Nov 2018 01:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeKTLpP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 06:45:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44705 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbeKTLpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 06:45:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so112946pgr.11
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MGksPiEJnsrdIcWnficey8VtM7t+xfHwZ5XNgDF9PPo=;
        b=rblI+IUX6sF7vLDuaAdkXw0d1BXp02T9/kOZIOyMSYOQAbGTotn+WM5ioEgq+Oyiav
         YLlYSFIyXiBxq8lhYNOL/55QEAkZF/DIBqHBjhtk++8Mg5Koy+6rbdzgjMaRWz/C0MvV
         7WMs4vbDW++TpkR54IS3Lx6NKGsUUdiPrgY7Em0nRbK9JC8TpDvdKFieeaUUrz7ssKq+
         F1/2eeaTMmGDtBHDPTPIl1piC7LUpeDGypCUZZRzj+mVyXwh3fjVIrLDwf2B1aDtg9C1
         dq3m9aTgOF8OwCOg7lBIda+2nWzTmnQTV8kI4TQdYnnDSbJ9HpdYKWNLpmXiYv0w6X4e
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MGksPiEJnsrdIcWnficey8VtM7t+xfHwZ5XNgDF9PPo=;
        b=D3BOcj3qZVt2/hAs7mu6XKGHELKhj1u815ztPL7KYbyEL+/f9D3CqfoMFIcHrn1J57
         th5U+QM0KJ8+LhG9vdji2vfbPO1pbN5/frzYC6RBLWVdjWsjIdaV4BXWfq82rcRdF/Bc
         1Kw0NII1JUmLj3nwsaN/9UaF57955vnhT1flR7gXGyx3rjSf/VFn3xRm9gbO5aC79WWN
         vrjCPgA2SZF9tf6woWsQr0ZHnfPBWoEuHhn/1LvaBs7Yg2IpFDja9tt2igB2qREdMZbF
         BY4FtUYqwxCENV1NrUvi6u8ZkHcubiebdIpzD45OF35MYd8wzjRxnILNtvUdQA0yis7r
         ggow==
X-Gm-Message-State: AGRZ1gIz/0nAv1t8M/tZNUSLLZqN9onTujUXXT9uHCF0ErtVq68CTWEB
        TiQ8TDkN6JZ/eEz/GrHd6IU=
X-Google-Smtp-Source: AJdET5cU8JrPLowDMwTlc4FzxbBR3sLab0oH9YP4THo+bN10f9in1EfyBb/rwyp9ZtaJmG06j6iUdw==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr22304769pgj.341.1542676723882;
        Mon, 19 Nov 2018 17:18:43 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k129sm48590727pgk.29.2018.11.19.17.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 17:18:43 -0800 (PST)
Date:   Mon, 19 Nov 2018 17:18:41 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     sxenos@google.com, git@vger.kernel.org, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com, stolee@gmail.com,
        carl@ecbaldwin.net, dborowitz@google.com
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181120011841.GB62243@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <87r2fm1hey.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r2fm1hey.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Thu, Nov 15 2018, sxenos@google.com wrote:

>> +Parent-type
>> +-----------
>> +The “parent-type” field in the commit header identifies a commit as a
>> +meta-commit and indicates the meaning for each of its parents. It is never
>> +present for normal commits.
[...]
> I think it's worth pointing out for those that are rusty on commit
> object details (but I checked) is that the reason for it not being:
>
>     tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>     parent aa7ce55545bf2c14bef48db91af1a74e2347539a
>     parent-type content
>     parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
>     parent-type obsolete
>     parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
>     parent-type origin
>     author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
>     committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
>
> Which would be easier to read, is that we're very sensitive to the order
> of the first few fields (tree -> parent -> author -> committer) and fsck
> will error out if we interjected a new field.

By the way, in the spirit of limiting the initial scope, I wonder
whether the parent-type fields can be stored in the commit message
initially.

Elsewhere in this thread it was mentioned that the parent-type is a
field to allow tools like "git fsck" to understand the meaning of
these parent relationships (for example, to forbid a commit
referencing a meta-commit).  The same could be done using special
commit message text, though.

The advantage of such an approach would be that we could experiment
without changing the official object format at all.  If experiments
revealed a different set of information to store, we could update the
format without having to maintain the memory of the older format in
"git fsck"'s understanding of commit object fields.  So even though I
think that in the end we would want to put this information in the
commit object header, I'm tempted to suspect that the benefits of
putting it in the commit message to start outweigh the costs (in
particular, of having to migrate to another format later).

Thanks,
Jonathan
