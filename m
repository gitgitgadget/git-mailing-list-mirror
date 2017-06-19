Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B511FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 18:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdFSSKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 14:10:21 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34130 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdFSSKU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:10:20 -0400
Received: by mail-pf0-f169.google.com with SMTP id s66so57293326pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EejLh9PfkEjvng8I/SidEnEXwXdn66XK+TD/u0Rn9qI=;
        b=JA8ln1UGR8LmT8vEWivoV8Ai0f3TiVUa3G9Zu15qPqcKNr8EuOHqLVf2A2Pm0+yO4M
         +RkLZaLrXREgsPrwPfGvzOHNTLnVKuTmZzoSq7g0/0S+rFumqBZexLbetsHcJcuDlQnW
         0PUkA4WkyAdHUXXNO9WVy2wPXEVeqXzuuJfZDscXk/HLQVZ7IQwK+LN95rG57p7JIspx
         ob7iO7oCubqRpHPzfrSpn4FR/oi9fYU4neQNOT6WZ4/26aM90BZd7liruLJlBRzTrjl2
         dVDoE9jhyYnpvvrdVMeazWR33biqPsRxomaJJBupq/+HDKPtSDTdj1z1lOPGveb0ec5S
         wxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EejLh9PfkEjvng8I/SidEnEXwXdn66XK+TD/u0Rn9qI=;
        b=tRgPtmKHAarCaSVrQ8JPlEU53uG9pxs5TWpDIbQakhSl77llpnnGYYaMGcuQdmyQ6T
         PjHXSuLcQOv+s88dalydfwPdTTMil9zeJpDql9oHy9ooEXE2xXjvfUQ/mmmoqzASkMnX
         E94oYR3sOmSm4RRnlZukPged7wufZb0tZQfdGS2dcR+7khUmpQEPZBFW27yVQKF/QHPl
         Di1DQX9UAiix2fnS0nxGXK+1gf+b4apOuAoaaabeTSoUpIW9ToM7xvMhPtpw/3vfHvse
         cVwy/297rQeyii/Pq/VVwZeV6zvenrgwej/DsQnoAsX00guopy/QrWwcfElhV0V+keTp
         ojsg==
X-Gm-Message-State: AKS2vOzoJVdUIYaUnZ5btSmXwn978gsYnvvthkS1KMZNHMBxTvFCk6kD
        x69LSqynVbqkPf5U
X-Received: by 10.99.177.78 with SMTP id g14mr692537pgp.131.1497895820091;
        Mon, 19 Jun 2017 11:10:20 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:a192:f5d5:865:c29d])
        by smtp.gmail.com with ESMTPSA id d185sm21187329pgc.39.2017.06.19.11.10.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 11:10:19 -0700 (PDT)
Date:   Mon, 19 Jun 2017 11:10:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] submodules: overhaul documentation
Message-ID: <20170619181017.GA194323@google.com>
References: <20170607185354.10050-1-sbeller@google.com>
 <xmqqo9tr660x.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdUARvhO=UwexFGkWQzsYSnyyiXJMX69W9ofhz13zjHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZdUARvhO=UwexFGkWQzsYSnyyiXJMX69W9ofhz13zjHQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Stefan Beller wrote:
> Adding two native speakers as we start word smithing.
> 
> On Tue, Jun 13, 2017 at 12:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> >> +
> >> +A submodule is another Git repository tracked in a subdirectory of your
> >> +repository. The tracked repository has its own history, which does not
> >> +interfere with the history of the current repository.
> >
> > "tracked in a subdirectory" sounds as if your top-level superproject
> > has a dedicated submodules/ directory and in it there live a bunch
> > of submodules.  Which obviously is not what you meant.  If phrased
> > "tracked as a subdirectory", I think the sentence makes sense.
> 
> Given this explanation "as a" also sounds wrong[1], maybe we need to
> separate (1) where it is put/mounted and (2) the fact that is tracked,
> i.e. the superproject has an idea of what should be there at a given
> revision. (I shortly thought about /s/as a/using/ in the above, but):
> 
>   A submodule is another Git repository at an arbitrary place inside
>   the working tree, and also tracked. The tracked repository has its
>   own history, which does not interfere with the history of the current
>   repository.

I would probably change the first sentence to:

  A submodule is another Git repository tracked at an arbitrary place
  inside the working tree.

> 
> [1] http://www.thesaurus.com/browse/as
> 
> >
> > While "which does not interfere" may be technically correct, I am
> > not sure what the value of saying that is.
> 
> I think we can drop it here. When writing I wanted to separate it from
> subtrees, but this is the wrong place for that.
> 
> >
> >> +Submodules are composed from a so-called `gitlink` tree entry
> >> +in the main repository that refers to a particular commit object
> >> +within the inner repository.
> >
> > Correct, but it may be unclear to the readers why we do so.  Perhaps
> >
> >         ... and this way, the tree of each commit in the main repository
> >         "knows" which commit from the submodule's history is "tied" to it.
> >
> > or something like that?
> 
> sounds good to me.
> 
> >
> >> +Additionally to the gitlink entry the `.gitmodules` file (see
> >> +linkgit:gitmodules[5]) at the root of the source tree contains
> >> +information needed for submodules.
> >
> > Is that really true?  Each submodule do not *need* what is in
> > .gitmodules; the top-level superproject needs to learn about
> > its submodules from the contents of that file, though.
> 
> Ha! The ediled words in my mind were:
> 
>  ... information needed for submodules [to work in the superproject].
> 
> But maybe we need to reword that as
> 
>   Additionally to the gitlink entry the `.gitmodules` file (see
>   linkgit:gitmodules[5]) at the root of the source tree contains
>   information on how to handle submodules.

This sounds slightly awkward.  Maybe:

    In addition to the gitlink entry, the `.gitmodules` file (see
    linkgit:gitmodules[5]) at the root of the source tree contains
    information on how to handle submodules.


-- 
Brandon Williams
