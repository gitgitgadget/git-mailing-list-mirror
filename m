Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16681F453
	for <e@80x24.org>; Fri, 25 Jan 2019 11:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfAYLBc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 06:01:32 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:40884 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYLBc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 06:01:32 -0500
Received: from [192.168.2.201] ([92.22.10.179])
        by smtp.talktalk.net with SMTP
        id mzElg0nXxAGVrmzElgQnZv; Fri, 25 Jan 2019 11:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1548414088;
        bh=rdNDoYXtIQxr7rhRWZvTNtUiLFlf4pg8EMJsR7wcycY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GiqhoKli0mwGzyM0T+QKGELGrGb224jy/I6JZtMAQE4tZoB5BZP4DjH/fAiiarMqL
         WKmaYdRR+/EiKowwwuiR5u0mgZk8siJiA6UVuuc2v8wQPEK5VXAytmYBcAMNOweF4j
         aiPv1HPAnWyNL8cDQW3va7whGsYuAtdymK0b7Jdg=
X-Originating-IP: [92.22.10.179]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=mkNhoPUTAQk2E0+XPqG3BA==:117
 a=mkNhoPUTAQk2E0+XPqG3BA==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=pqPM5ixsjOAf_y4SMDIA:9 a=QEXdDO2ut3YA:10 a=hC3hSVyoFnMA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/7] t3701-add-interactive: test add_i_show_help()
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.v2.git.gitgitgadget@gmail.com>
 <pull.103.v3.git.gitgitgadget@gmail.com>
 <aede733318bb6fccc1c3d16adf442135d3cb0692.1548062019.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4a830716-f627-85e0-39bb-f61d7185ea2b@talktalk.net>
Date:   Fri, 25 Jan 2019 11:01:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <aede733318bb6fccc1c3d16adf442135d3cb0692.1548062019.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB3xeBvzAh8G3D8G6Nj3EXfzutsOoDe7hAI0UnTTSWPICm6AaGzglL1HABo+eCRRMJw6xr8YR2/b7ssP3P//o8tKluxO+5iOIp1YjdEfBw/NvJ3DU76H
 RsS8hmVfyf0Lv9bOP470m8/dQjbT4/46qT6jH9IFTty5yNN6E7i8zNf1gR2EMOVDaPsvJEjLYKlw6ubl6mNYbEvjSolJrs8LpVa/sYSJiKdWUxkTr6wxWwHz
 WpOzo4+EprflUze1jPg/0Z2PcTpDS4781+3GgYFo20k5rgERHOYBn2VmZYG0lj0Rws8OzN/zykhve9Pqo3tEzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

Having suggested that you move this patch up the series, I thought I
should check that it does actually pass before the rewrite.
Unfortunately when I run it it fails, but it is due to a missing
trailing space in the expected file. I get

--- expect	2019-01-25 10:42:06.794251740 +0000
+++ actual	2019-01-25 10:42:07.044127788 +0000
@@ -11,5 +11,5 @@
 <BOLD>*** Commands ***<RESET>
   1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3:
<BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
   5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7:
<BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
-<BOLD;BLUE>What now<RESET>>
+<BOLD;BLUE>What now<RESET>>
 Bye.

There should be a space after '<BOLD;BLUE>What now<RESET>>' as the
prompt has a space after it. The space is actually in the patch but it
got eaten by 'git am' (I have core.whitespace set but I think cleaning
up trailing whitespace is on by default anyway). I think the best way to
make this patch easier to apply would be to use '$SP' which is already
set up in earlier tests to avoid trailing whitespace in here documents.
You'll need to change
cat >expect <<-\EOF
to
cat >expect <<-EOF
to enable variable interpolation in the here document as well.

Best Wishes

Phillip


On 21/01/2019 09:13, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> Add test to t3701-add-interactive to verify that add_i_show_help()
> outputs expected content.
> Also, add it before changing git-add--interactive.perl's help_cmd
> to demonstrate that there are no changes introduced by the
> conversion to C.
> Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
> to force colored output on Windows.
> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 65dfbc033a..14e3286995 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
>  	test_cmp expected-2 actual
>  '
>  
> +test_expect_success 'show help from add--helper' '
> +	git reset --hard &&
> +	cat >expect <<-\EOF &&
> +
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
> +	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
> +	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
> +	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
> +	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
> +	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
> +	<BOLD>*** Commands ***<RESET>
> +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
> +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
> +	<BOLD;BLUE>What now<RESET>> 
> +	Bye.
> +	EOF
> +	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
> +	test_decode_color <actual.colored >actual &&
> +	test_i18ncmp expect actual
> +'
> +
>  test_done
> 

