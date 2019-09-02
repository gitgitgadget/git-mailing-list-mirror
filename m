Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC4E1F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfIBST6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:19:58 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51953 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:19:58 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E07A5C0005;
        Mon,  2 Sep 2019 18:19:56 +0000 (UTC)
Date:   Mon, 2 Sep 2019 23:49:54 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
Message-ID: <20190902181954.zcxuyqrdzs3dzjtq@yadavpratyush.com>
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901193652.21086-1-birger.sp@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

Other than a minor change that I can do locally, this looks good. I'll 
test it a bit and then merge it. Thanks.

On 01/09/19 09:36PM, Birger Skogeng Pedersen wrote:
[snip]
> +proc select_path_in {widget} {
> +	global file_lists last_clicked selected_paths ui_workdir
> +	global file_lists_last_clicked
> +
> +	set _list_length [llength $file_lists($widget)]
> +	if {$_list_length > 0} {
> +

You missed removing this extra blank line. Will fix it up locally.

> +		set _index $file_lists_last_clicked($widget)
[snip]

-- 
Regards,
Pratyush Yadav
