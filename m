Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5841FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbdBGR1V (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 12:27:21 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38816 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbdBGR1U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 12:27:20 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so84369248itd.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 09:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=81Wlfe8/jRhxr8LCfFVU67/8eFLzoEg6Rj26OOROj8s=;
        b=sU5Wjutl6rZDHP9NSAPMGt/Ed9M3IJMXDVh3hzpjcYqhHEtO3aRE8QhceiXk7yvwi5
         MWlyVyxZohactTRlclYaeqpxnXkBd16xeUSviS4IkDvxkRWvQzgA21xsusfCsDTF4fqs
         vSVIeEzPgkV0hYeVWzDepsvlFKLkK/AnAG8DgTvqj+1zsZ23d74dOcwbSXTAQTi0IH5b
         kjphFCKmLL2vOlZi1GzjraR1seeHF+0arZibRfNX+6ipt2v1fY5a6sqjzB8HnRX3PdpC
         6gHBHdxxWtocKVL1BV8XEAPyCc+woRuTbHLx768Gh5noW2XHEk03GysxwbwHEic1Qc85
         SUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=81Wlfe8/jRhxr8LCfFVU67/8eFLzoEg6Rj26OOROj8s=;
        b=gzQHrDrqQSrR6Z8CKIb6bmq+88Ux/LQWA+kbievtp9PwAR1RilKdmYK4OgfEXVH4AZ
         Tc4oh+7pUrN8EdO+ifPezr6pAk2i4Y7y0Hje76lSRLwR8M8z5isT/fiGtelIalav3kor
         HO/HPbGpAKoID+G1dsCmFuwiSYhIb6c42d4dL6CjJBfrozK/CqetiLbNnT5WpLSlo72D
         SPIRtgyQoM52DjKsfDf+1v4chCyINiSTMuXpqN/XazPYd+FQAi8THxalQgwnB1zy+Ozt
         GIN/hTlrQZhkjH9PkmYetVP/3ZzwIF/WiPC9o8HXfK9Mpa5nLN6stYqQKM/SZ3XNRaYT
         qhgQ==
X-Gm-Message-State: AIkVDXIiZh0ghPCCyx+Vl4Yu8oS7IPVMN8azGBvIShyExWZ/TGWbX6hlAlklFtGHRapIG4LCZa9aUCMiMnZCrDuu
X-Received: by 10.36.65.4 with SMTP id x4mr12989347ita.69.1486488439977; Tue,
 07 Feb 2017 09:27:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Tue, 7 Feb 2017 09:27:19 -0800 (PST)
In-Reply-To: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
References: <77c0182b-8c4f-9727-f56f-d8e2bad8146d@tngtech.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Feb 2017 09:27:19 -0800
Message-ID: <CAGZ79kZ=ikbYpuK6E=ui1ju=bRavcVcxb3AA_dvb2Jp6cRNmJQ@mail.gmail.com>
Subject: Re: [RFC] mailmap.blob overrides default .mailmap
To:     Cornelius Weig <cornelius.weig@tngtech.com>,
        Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 7, 2017 at 3:56 AM, Cornelius Weig
<cornelius.weig@tngtech.com> wrote:
> Hi,
>
>  I was reading into the mailmap handling today and I'm a bit puzzled by the overriding behavior.
>
> This is what the documentation says about precedence (emphasis mine):
> -------------
> mailmap.file
>     The location of an augmenting mailmap file. The default mailmap, located
>     in the root of the repository, is loaded first, then the mailmap file
>     pointed to by this variable. The location of the mailmap file may be in a
>     repository subdirectory, or somewhere outside of the repository itself.
>     See git-shortlog(1) and git-blame(1).
>
> mailmap.blob
>     Like mailmap.file, but consider the value as a reference to a blob in the
>     repository. If both mailmap.file and mailmap.blob are given, both are
> !!! parsed, with _entries from mailmap.file taking precedence_. In a bare
>     repository, this defaults to HEAD:.mailmap. In a non-bare repository, it
>     defaults to empty.
> ------------
>
> So from the doc I would have expected that files always get precedence over the blob. IOW entries from .mailmap override entries from mailmap.blob. However, this is not the case.
>
> The code shows why (mailmap.c):
>         err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
>         if (startup_info->have_repository)
>                 err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
>         err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
>
>
> Apparently this is not an oversight, because there is an explicit test for this overriding behavior (t4203 'mailmap.blob overrides .mailmap').

which is blamed to 08610900 (mailmap: support reading mailmap from
blobs, 2012-12-12),
cc'ing Jeff who may remember what he was doing back then, as the
commit message doesn't discuss the implications on ordering.

>
> So I wonder: what is the rationale behind this? I find this mixed overriding behavior hard to explain and difficult to understand.
>
