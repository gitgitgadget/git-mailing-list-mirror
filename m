Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0B761F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 17:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbfJNRvl (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 13:51:41 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48033 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfJNRvk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 13:51:40 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 80054240008;
        Mon, 14 Oct 2019 17:51:38 +0000 (UTC)
Date:   Mon, 14 Oct 2019 23:21:36 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     kdnakt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        kdnakt <a.kid.1985@gmail.com>
Subject: Re: [PATCH 1/1] Improve Japanese translation
Message-ID: <20191014175135.mbrmwyydnnktkqap@yadavpratyush.com>
References: <pull.396.git.1571016698.gitgitgadget@gmail.com>
 <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dc8687d9f93a08cdb9e7de8d159df6aa0b05c02.1571016698.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi kdnakt,

I updated the commit message subject locally to "git-gui: improve 
Japanese translation" to match our commit message style.

On 14/10/19 01:31AM, kdnakt via GitGitGadget wrote:
> From: kdnakt <a.kid.1985@gmail.com>
> 
> Signed-off-by: kdnakt <a.kid.1985@gmail.com>
> ---
>  git-gui/po/ja.po | 9 +++++----

You based this patch on the git.git repo. For now, I munged the patch 
and applied to my tree, but for future contributions, please base your 
patches on the git-gui tree. That would mean your paths in the diff 
would look like: 'po/ja.po' instead of 'git-gui/po/ja.po/'. The 
instructions to do that in GitGitGadget can be found at [0].

>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/git-gui/po/ja.po b/git-gui/po/ja.po
> index 208651c1af..2f61153ab9 100644
> --- a/git-gui/po/ja.po
> +++ b/git-gui/po/ja.po
> @@ -4,14 +4,15 @@
>  #
>  # しらいし ななこ <nanako3@bluebottle.com>, 2007.
>  # Satoshi Yasushima <s.yasushima@gmail.com>, 2016.
> +# KIDANI Akito <a.kid.1985@gmail.com>, 2019.
>  #
>  msgid ""
>  msgstr ""
>  "Project-Id-Version: git-gui\n"
>  "Report-Msgid-Bugs-To: \n"
>  "POT-Creation-Date: 2016-05-27 17:52+0900\n"
> -"PO-Revision-Date: 2016-06-22 12:50+0900\n"
> -"Last-Translator: Satoshi Yasushima <s.yasushima@gmail.com>\n"
> +"PO-Revision-Date: 2019-10-13 23:20+0900\n"
> +"Last-Translator: KIDANI Akito <a.kid.1985@gmail.com>\n"
>  "Language-Team: Japanese\n"
>  "Language: ja\n"
>  "MIME-Version: 1.0\n"
> @@ -661,7 +662,7 @@ msgstr ""
>  #: lib/merge.tcl:108
>  #, tcl-format
>  msgid "%s of %s"
> -msgstr "%s の %s ブランチ"
> +msgstr "%2$s の %1$s ブランチ"
>  
>  #: lib/merge.tcl:122
>  #, tcl-format
> @@ -956,7 +957,7 @@ msgstr "エラー: コマンドが失敗しました"
>  #: lib/checkout_op.tcl:85
>  #, tcl-format
>  msgid "Fetching %s from %s"
> -msgstr "%s から %s をフェッチしています"
> +msgstr "%2$s から %1$s をフェッチしています"
>  
>  #: lib/checkout_op.tcl:133
>  #, tcl-format

Thanks for the translation update. Will queue.

[0] https://github.com/prati0100/git-gui#using-gitgitgadget

-- 
Regards,
Pratyush Yadav
