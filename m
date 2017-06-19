Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559581FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751012AbdFSReC (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:34:02 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36712 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdFSReB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:34:01 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so18341463pfd.3
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=BTfFfjaddCK2HLzPMsyWqofgpzhdLSzI0zoxxphAV5Y=;
        b=P6ItUloNMEPCU55J/emJdUO+8UTYwW+eqG5YehgV7BxItEaYa4kyHuX9q+bL0qE953
         4azUL3vljBDZYpp2+09nUG9YZQykyW5MfCnEJwgIyh3yutOFzt0Zv4wA6FyZHI7nWg3X
         38fFLeHE+fWERruthfg6lhip2lzOaiNN2Q4sEK76qUhGXZFgcMLYvrsm21izjJUlQrXi
         7TliR4hf5GouWTf6IT7buRTUmCBRYmBZj977nGfDm8YE8n+Ud73VLAG1wVCkQ94euj6s
         d2u3m0FL4Jm3slBWin8eo49auE+ntSvaBarry1Dp3ybWcMf+i2vm3fsAzLDFpaWf0/jb
         zSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=BTfFfjaddCK2HLzPMsyWqofgpzhdLSzI0zoxxphAV5Y=;
        b=jiDD9bCZ5R/oa8tH5nSnSM8RdfqjlrbOdeMxAZ9QyTbwfW241XmxDNfwwA7+TRINjp
         jALCGh0w3e40ZpC+QmMMYwOWkn/Hp/ReG195Uwj1iKydOXN8ZmslPs9TK0PA6ZDGyN1d
         Dkbk4NSI5NSnzT6qxB/CJ6V38GH5pOHfzq+ZXjHM7jv/CZs1MPXlKwUwX/PnrPKxXB3l
         EH1IxO92uufRpwHi9vyc1H/wTGRXv87Fhr8mTMlNXKg6iMVkZr7B6azCU5bIwv34WeFO
         Gix8sIO6jmWrbi7WW9CbCWq1VtR0fWvuHilhVct1DgTxsxbPdyA6SsMxD7hLkPosuuD5
         WSlA==
X-Gm-Message-State: AKS2vOwyceOF55UIm87pWHBa3xucaP/pMcc5yGgoeF60Q8OM0rELqYW3
        hlsZ9hrcYCZkfA==
X-Received: by 10.84.224.200 with SMTP id k8mr23614010pln.215.1497893640564;
        Mon, 19 Jun 2017 10:34:00 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id q76sm22788040pfg.117.2017.06.19.10.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:33:59 -0700 (PDT)
Message-ID: <1497893625.18850.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] Cleanup Documentation
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, mlevedahl@gmail.com
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Date:   Mon, 19 Jun 2017 23:03:45 +0530
In-Reply-To: <CAGZ79kbqBXZ5S2TBk6B5gRk+Y-ev2rdgkQZrF-MmHQc0Thj7EQ@mail.gmail.com>
References: <20170619030518.6712-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sqgv9ax.fsf@gitster.mtv.corp.google.com>
         <CAGZ79kbqBXZ5S2TBk6B5gRk+Y-ev2rdgkQZrF-MmHQc0Thj7EQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-06-18 at 22:50 -0700, Stefan Beller wrote:
> > > diff --git a/Documentation/git-submodule.txt b/Documentation/git-
> > > submodule.txt
> > > index 74bc6200d..9812b0655 100644
> > > --- a/Documentation/git-submodule.txt
> > > +++ b/Documentation/git-submodule.txt
> > > @@ -63,13 +63,7 @@ add [-b <branch>] [-f|--force] [--name <name>]
> > > [--reference <repository>] [--dep
> > >       to the changeset to be committed next to the current
> > >       project: the current project is termed the "superproject".
> > >  +
> > > -This requires at least one argument: <repository>. The optional
> > > -argument <path> is the relative location for the cloned
> > > submodule
> > > -to exist in the superproject. If <path> is not given, the
> > > -"humanish" part of the source repository is used ("repo" for
> > > -"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> > > -The <path> is also used as the submodule's logical name in its
> > > -configuration entries unless `--name` is used to specify a
> > > logical name.
> > > +This requires at least one argument: <repository>.
> > >  +
> 
> So we're losing the information how the submodule name is chosen.
I just moved it. I don't think we're losing anything related to how the
name is chosen. Please let me know if I misinterpreted your statement.

> This may be fine as I plan (long term) to make the name an arbitrary
> random
> string (IMHO that reduces confusion as there will be less 'nearly the
> same'
> things)
> 
> On the other hand the newly added line
>   'This requires at least one argument: <repository'
> (actually moved, but) is sort of redundant. The notation in the
> argument line
> should make that clear, already?
> 
Makes clear sense. Removed it.

> This sounds good, it consolidates all information about [<path>]
> in one paragraph. While at it, maybe let's find another (better)
> substitute for "humanish" as that can be anything(?).
> 
> Maybe "the last part of the URL" (without any .git)
> 
How about "meaningful"? Put in place it reads like,

If <path> is not given, the meaningful part of the source repository
...

> Please markup the '.gitmodules' either via single quotes or `.
> (or even link to 'gitmodules(5)' )
> 
Marked it up using `. Help needed to link to 'gitmodules(5)', as I'm
not sure how to provide alternative text to 'linkgit:'.

> I am undecided if this is really removing (2) unclearness, but the
> (1) redundancy seems fine to me.
> 
Sorry about that. The commit message should have been,

...
2. Removed unclear back reference
...

by which I intend to denote the following removal,
> -In either case, the given URL is recorded into .gitmodules for
> -use by subsequent users cloning the superproject.

Note: Will follow up with a patch, soon.
-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
