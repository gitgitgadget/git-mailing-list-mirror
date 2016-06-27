Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33312018E
	for <e@80x24.org>; Mon, 27 Jun 2016 17:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcF0R20 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 13:28:26 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36233 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcF0R2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 13:28:24 -0400
Received: by mail-wm0-f47.google.com with SMTP id f126so109345486wma.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 10:28:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=HSrTc/0jQuuA59e/X5T/UmW/3nlyAEXzD3T81T2K0zw=;
        b=vTE9J4Tw+xHQ0q9jGrl7xO1C3qXOZA3G56rvJ79wFZlgisoTTt0yQErySAForrs68H
         nv5pLgjuDypD+8ZyDwHitvUjqtOmkr/5dwV2pWvzJlWz3p5qKQofk+/a0w1AhgWL9lxS
         w+o8lXLW+L+oyr05G5x+CVaGpkJs9KxjPaimQLCY5tcXvRFbj3/EO6B1j1aXYoSfU/FP
         LQZF46rCnmO+H/lCkCZtyeoDtIrZOUcn1Yn4359N7U3hhz1AoGSM/yM4QVzZ8PEcTl7r
         aeDjIm+UewBIS9QlnLpTEehKGE+peaNAqZXla0IbnZM5Cje8X5idUt8BQJKfnJMF4Wlu
         0rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=HSrTc/0jQuuA59e/X5T/UmW/3nlyAEXzD3T81T2K0zw=;
        b=bb2x0fc95/UbAMRFhPa+HWfNvw4/6jlxKDsrUUKEGVMLb+FSrs10qdgtehC+Q4bGOs
         RH2dog8BbnGRo+eOYaZZbvNVrEpSk1r6PEO5aDswh2qDsfm3zJyTM+oA6tjMQ+YDHTpj
         FH3JxCx5nBO5t38bgx2cZJKnumr8HQlJ28cR7VpnRg+9GttYcnMkminRm6cTqrgyNjQi
         GNkT+gqF/LUVIML+9q8TiBsTjBn9zfTDEaOCRO0Q11IQS8ZpkO9jX9BKCcxPchGhR8+r
         2jfcTmXZIrHdL1eJHvQ6NQSKYTYk3BO3aukgcHrfknoCyMydax7IakM/wlRI0CbSkqjR
         NgnA==
X-Gm-Message-State: ALyK8tIro3lOaSPAzo0EzVLTscOYvIQKkgXmWeyvqMZ0uhVRm5APdXjVNzk3qDv0IzRlNA==
X-Received: by 10.28.188.137 with SMTP id m131mr11458504wmf.4.1467048502288;
        Mon, 27 Jun 2016 10:28:22 -0700 (PDT)
Received: from [192.168.1.34] (afj108.neoplus.adsl.tpnet.pl. [83.25.139.108])
        by smtp.googlemail.com with ESMTPSA id c142sm4728818wme.18.2016.06.27.10.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jun 2016 10:28:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] Support for $FILENAMES in tool definitions
To:	Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org
References: <20160627132137.GC4194@pflmari>
Cc:	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57716227.1030104@gmail.com>
Date:	Mon, 27 Jun 2016 19:28:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160627132137.GC4194@pflmari>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-06-27, Alex Riesen wrote:

> This adds a FILENAMES environment variable, which contains the repository
> pathnames of all selected files the list.
> The variable contains the names separated by spaces.

Why not separate filenames with end-of-line character (LF)? It would still
be broken for some filenames, but only for unportable ones.  Filenames with
internal space (common on MS Windows) would work then.

  http://www.dwheeler.com/essays/filenames-in-shell.html
 
If Tcl allows it, you could separate filenames in FILENAMES environment
variable with NUL ("\0") character...

> Similar to the FILENAME it is broken yet, if the names contain spaces.

Could you clarify? Did you meant that FILENAMES environment variable is
similar to existing FILENAME variable, but broken for filenames which contain
spaces, or did you mean that both FILENAME (how?) and FILENAMES are broken
for filenames with spaces in them?

> 
> Note that the file marked and diffed immediately after starting the GUI up,
> is not actually selected. One must click on it once to really select it.

I'm not that familiar with git-gui / gitk; what do you mean by this sentence?
Could you summarize how FILENAME and FILENAMES work, please?

> 
> Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
> ---

