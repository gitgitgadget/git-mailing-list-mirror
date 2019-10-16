Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2041F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbfJPPPT (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 11:15:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50243 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPPPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 11:15:19 -0400
Received: from localhost (unknown [1.186.12.12])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id D5647240006;
        Wed, 16 Oct 2019 15:15:16 +0000 (UTC)
Date:   Wed, 16 Oct 2019 20:45:14 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     kdnakt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, kdnakt <a.kid.1985@gmail.com>
Subject: Re: [PATCH 1/1] Improve Japanese translation
Message-ID: <20191016151514.fbjziwhko7szh3wm@yadavpratyush.com>
References: <pull.396.git.1571016698.gitgitgadget@gmail.com>
 <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
 <xmqqmue2db0n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqmue2db0n.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/10/19 10:59AM, Junio C Hamano wrote:
> "kdnakt via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > @@ -661,7 +662,7 @@ msgstr ""
> >  #: lib/merge.tcl:108
> >  #, tcl-format
> >  msgid "%s of %s"
> > -msgstr "%s の %s ブランチ"
> > +msgstr "%2$s の %1$s ブランチ"
> >  
> >  #: lib/merge.tcl:122
> >  #, tcl-format
> > @@ -956,7 +957,7 @@ msgstr "エラー: コマンドが失敗しました"
> >  #: lib/checkout_op.tcl:85
> >  #, tcl-format
> >  msgid "Fetching %s from %s"
> > -msgstr "%s から %s をフェッチしています"
> > +msgstr "%2$s から %1$s をフェッチしています"
> 
> Both of these changes to word order make sense.
> 
> It's a bit surprising that these haven't been noticed/fixed for
> quite some time ;-).

Thanks for the review.

-- 
Regards,
Pratyush Yadav
