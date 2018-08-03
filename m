Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A561F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeHCTUj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:20:39 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:34777 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbeHCTUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:20:39 -0400
Received: by mail-lj1-f172.google.com with SMTP id f8-v6so5561779ljk.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLsle3SQLkZ0FX2LtZvE/WxlltszuvfV3LySOJONKsQ=;
        b=nchekPnupIiuWHWlDjkLjQQd8z6IsJZ1FGmrwh2fLScXkgIAB8Kjr2TWonNW0PGzLP
         /XbxjxfLSr3JBd2hBMtz6T8ijN6MqA90dG2IueNBI0MBEircnrPVho2ekdnGoZrQVfFz
         KCXQ0/8KaT1r83+k2AGpTmGiq22aF7GgfmBGLEwWSlEq0XfmTShHWz1qNcEn5TaxCGpb
         EPqCfTRCdZsebOQExksjGwpviu9U63z7VrIcpRx5DdjB77tS0BNw7jpRHNtfpT7cQufg
         mLgZDWQ1NkZ76mISusGazsNoAM1wPmIsilO7kzoBrviSFtlw+a/A1cqpPTO1UQdEd4tK
         hyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLsle3SQLkZ0FX2LtZvE/WxlltszuvfV3LySOJONKsQ=;
        b=pu3PcqAihMvXYpgT4GBBVZX6e4wJ5M+C2CjNAgTdAFuxvyr9PhlYD/rjR3ogOYEgN0
         kaU0PM12pSHnQZJtPnLCVVORSGCwZzRR0/eWoLYTD3QdZ4xNPrtlUCuzpfyFgvnE4lKy
         ZPy0gRAOHBM6/TyIv/bk1NLKPvcuJtbYpHDp0TD7qA7TSYa4oQh76jaKHmN1uAZJ038j
         nxi+O5UTaG9uxXiFzJlmiTbvH3+0o+cWQmxTPh5GqO+UxxwpgYPX+D+f2jCRjy2eg1z9
         hfSb1bp7grt9+7+w3G7IlS87Z05AZIw6tP/tIdCnEjCP7LEBcsR0xL1AYuSuQciLI1CT
         b4VQ==
X-Gm-Message-State: AOUpUlFgWSj1VlsueWFM0Dim3U0BUu7INj9elbkbyVEiuwQperlGhyGK
        R7G3NoI0Y+dWMUhJ+VvjbWKhhIWzIyoZodrfRIIRUdIA
X-Google-Smtp-Source: AAOMgpeRywJpue0SMSVghlQBAKUGLYZsUAjDcPRjzSFk3QLOLudIxBbaDevYH/xoyI7KH0xVuChH0nvPH8/T4R9lmCE=
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr6490639ljk.19.1533317004327;
 Fri, 03 Aug 2018 10:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALr1GiFBm9zJ1v-UWuVLWJJ+zFh-iTKOv=T4KETLN8qkW_0pAg@mail.gmail.com>
 <20180803134901.GC28939@sigill.intra.peff.net>
In-Reply-To: <20180803134901.GC28939@sigill.intra.peff.net>
From:   Vadim Belov <vadim.belov@gmail.com>
Date:   Fri, 3 Aug 2018 20:23:13 +0300
Message-ID: <CALr1GiFjqR+dyP6vCah7H3bhurbcwp2zfrxRfBkd1wnkSQDZCQ@mail.gmail.com>
Subject: Re: Squash & Merge Implementation
To:     peff@peff.net
Cc:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000005f02c905728b2f63"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000005f02c905728b2f63
Content-Type: text/plain; charset="UTF-8"

Thanks, Peff!

I'm just doing the CI and the status check is for testing each commit to
the PR-Branch.
I'll try to get response from github on this as you suggested.

Thanks again,
Vadim

On Fri, Aug 3, 2018 at 4:49 PM Jeff King <peff@peff.net> wrote:

> On Fri, Aug 03, 2018 at 03:01:15PM +0300, Vadim Belov wrote:
>
> > 1. This merges successfully without squash:
> > git checkout origin/master
> > git merge ${PR-Branch}
> > git push origin HEAD:master
> > git push origin --delete ${PR-Branch}
>
> Right, this is a normal merge.
>
> > 2. This closes the PR, but there is no update seen on master:
> > git checkout origin/master
> > git merge --squash --commit ${PR-Branch}
> > git push origin HEAD:master
> > git push origin --delete ${PR-Branch}
>
> Doing "merge --squash --commit" doesn't do what you expect; namely
> "--commit" does not override the non-committing nature of "--squash". It
> only override a "--no-commit" found elsewhere.
>
> IMHO this is something that could be improved in Git (i.e., telling the
> difference between "the user did not say --no-commit" and "the user said
> --commit" and respecting it for --squash).
>
> But that explains what you see. The push to master is a noop, since you
> didn't make a new commit. And then deleting the PR branch on GitHub
> auto-closes the PR.
>
> > 3. This fails to push to master with the error "GH006: Protected branch
> > update failed"  (despite that the PR is set to SUCCESS):
> > git checkout origin/master
> > git merge --squash ${PR-Branch}
> > git commit -am"comment"
> > git push origin HEAD:${m_mainBranch}
> > git push origin --delete ${m_prBranch}
>
> So here you _do_ make an actual commit. But that commit doesn't look
> like a merge to the receiver; it just looks like a single commit that
> has all the changes there were on PR-Branch.
>
> The tree of that commit should be the same tree that would result from a
> real merge. So in theory things like protected-branch status checks
> could handle that, but I suspect they use the actual commit id (the tree
> id is fine if you're just doing CI, but if you wanted to have a status
> check for commit messages, say, you'd obviously want that to be tied to
> the actual commit object).
>
> I don't offhand recall how that is implemented (and you could also be
> falling afoul of other checks, like required reviews). But this is a
> GitHub-specific question, and you should probably ask GitHub support to
> go further.
>
> -Peff
>

--0000000000005f02c905728b2f63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks, Peff!=C2=A0<br><div><br></div><div>I&#39;m just do=
ing the CI and the status check is for testing each commit to the PR-Branch=
.</div><div>I&#39;ll try to get response from github on this as you suggest=
ed.</div><div><br></div><div>Thanks again,</div><div>Vadim</div></div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, Aug 3, 2018 at 4:49 PM J=
eff King &lt;<a href=3D"mailto:peff@peff.net">peff@peff.net</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">On Fri, Aug 03, 2018 at 03:01:15PM =
+0300, Vadim Belov wrote:<br>
<br>
&gt; 1. This merges successfully without squash:<br>
&gt; git checkout origin/master<br>
&gt; git merge ${PR-Branch}<br>
&gt; git push origin HEAD:master<br>
&gt; git push origin --delete ${PR-Branch}<br>
<br>
Right, this is a normal merge.<br>
<br>
&gt; 2. This closes the PR, but there is no update seen on master:<br>
&gt; git checkout origin/master<br>
&gt; git merge --squash --commit ${PR-Branch}<br>
&gt; git push origin HEAD:master<br>
&gt; git push origin --delete ${PR-Branch}<br>
<br>
Doing &quot;merge --squash --commit&quot; doesn&#39;t do what you expect; n=
amely<br>
&quot;--commit&quot; does not override the non-committing nature of &quot;-=
-squash&quot;. It<br>
only override a &quot;--no-commit&quot; found elsewhere.<br>
<br>
IMHO this is something that could be improved in Git (i.e., telling the<br>
difference between &quot;the user did not say --no-commit&quot; and &quot;t=
he user said<br>
--commit&quot; and respecting it for --squash).<br>
<br>
But that explains what you see. The push to master is a noop, since you<br>
didn&#39;t make a new commit. And then deleting the PR branch on GitHub<br>
auto-closes the PR.<br>
<br>
&gt; 3. This fails to push to master with the error &quot;GH006: Protected =
branch<br>
&gt; update failed&quot;=C2=A0 (despite that the PR is set to SUCCESS):<br>
&gt; git checkout origin/master<br>
&gt; git merge --squash ${PR-Branch}<br>
&gt; git commit -am&quot;comment&quot;<br>
&gt; git push origin HEAD:${m_mainBranch}<br>
&gt; git push origin --delete ${m_prBranch}<br>
<br>
So here you _do_ make an actual commit. But that commit doesn&#39;t look<br=
>
like a merge to the receiver; it just looks like a single commit that<br>
has all the changes there were on PR-Branch.<br>
<br>
The tree of that commit should be the same tree that would result from a<br=
>
real merge. So in theory things like protected-branch status checks<br>
could handle that, but I suspect they use the actual commit id (the tree<br=
>
id is fine if you&#39;re just doing CI, but if you wanted to have a status<=
br>
check for commit messages, say, you&#39;d obviously want that to be tied to=
<br>
the actual commit object).<br>
<br>
I don&#39;t offhand recall how that is implemented (and you could also be<b=
r>
falling afoul of other checks, like required reviews). But this is a<br>
GitHub-specific question, and you should probably ask GitHub support to<br>
go further.<br>
<br>
-Peff<br>
</blockquote></div>

--0000000000005f02c905728b2f63--
