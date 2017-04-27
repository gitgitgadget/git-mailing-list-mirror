Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255BD207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423355AbdD0WNw (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:13:52 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34702 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423349AbdD0WNk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:13:40 -0400
Received: by mail-pf0-f170.google.com with SMTP id e64so1818096pfd.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pYZ93G+ymOmOet0zN0kmnKkLeNEeLyodQAvogULcFtE=;
        b=kUTe31274Q/l9TvrXdXgeO03TcxHfnqm4aO6c8TGgFcRaOA+vLOekuLLhcoQEqdNua
         aygMSDXow4OHdFQGFqSE6f/oLh9wPssSDEBufHHl/a1PyeO/S6lX/esXivIhE8IzrPwL
         otqMf+5IXkaTX0AxFrTX5fYVtQG8mBpFECm1U7uRpzXqK7tLTaCe91w0+X4Sh7sj5yq1
         d4IN4GCgMlqKdP4+b7wItwjXXlpM+huqMmS1aJVB7Ftv9ufvVh91WfefQmmWYyoyO7wI
         2b94oTHfOGrs4uwNxpLAFQBuSjKMAXVOo94o4XTHMRmfDLBVfZNPFUCF5CHaD5aYLK+w
         aL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pYZ93G+ymOmOet0zN0kmnKkLeNEeLyodQAvogULcFtE=;
        b=sj5xruc8ZiYR8VdzWLmcSo2y+YssgvIEeCZZyYDHaSjt0ydxU3wx1QOeUr44oZnsb/
         /6Bu4SvLaR5CjDLDtBcBeHcWOZGCtkLQRHQN+qUaOmBPgb8rwR3lYmVuQUdiuR4wb/d5
         nNn/x0Qqqk3z5iv7defU+8uEziUyNetUy1Hp6mmBmi4gs2C2eO7mBVaxDWlw0rCEVYGw
         INgNnfd1ToyVuymCCAjcmm7o2gSp2SDUuPlgintsUG+de6RVp5xgJbtoKPq2ZTTflcCw
         ydeyswbLdfIbHdjmCzAa2PpxKz+Me2ODGwxDroBJf+49DrR4uiVotaGX+C35JgEmtnRH
         cS4A==
X-Gm-Message-State: AN3rC/5j/+46BJ+NHH7ID8K5Hc+AHqpmXCM3Scwr0Q2I+bkkA/fsCSfA
        nKttgFDhbL6TasHa
X-Received: by 10.98.212.68 with SMTP id u4mr8378224pfl.73.1493331219610;
        Thu, 27 Apr 2017 15:13:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6199:b109:ce03:97f2])
        by smtp.gmail.com with ESMTPSA id p2sm6450371pfj.93.2017.04.27.15.13.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 15:13:38 -0700 (PDT)
Date:   Thu, 27 Apr 2017 15:13:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 3/5] tests: rename a test having to do with shallow
 submodules
Message-ID: <20170427221337.GB146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com>
 <20170426231236.27219-4-avarab@gmail.com>
 <CAGZ79ka1_eJEa56TU5v++1FKsGY=nvZ4rWBK1begKvqecH17mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGZ79ka1_eJEa56TU5v++1FKsGY=nvZ4rWBK1begKvqecH17mQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/27, Stefan Beller wrote:
> On Wed, Apr 26, 2017 at 4:12 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > Rename the t5614-clone-submodules.sh test to
> > t5614-clone-submodules-shallow.sh. It's not a general test of
> > submodules, but of shallow cloning in relation to submodules. Move it
> > to create another similar t56*-clone-submodules-*.sh test.
> >
> > Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> > ---
> >  t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename t/{t5614-clone-submodules.sh => t5614-clone-submodules-shallow.sh} (100%)
> >
> > diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules-shallow.sh
> > similarity index 100%
> > rename from t/t5614-clone-submodules.sh
> > rename to t/t5614-clone-submodules-shallow.sh
> 
> Thanks for formatting the patches with rename detection. :)
> The rename looks good.

Do you have to turn that on or is that on by default?

-- 
Brandon Williams
