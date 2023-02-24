Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D8AC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 11:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjBXLUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 06:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBXLU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 06:20:28 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F10126ED
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=tFJvE+EWgdCkYqX6F9l7tmeiqrRTU19dB00sl2eaGEQ=; b=mvqXBF
        Mt2vianREwQ5OL1TUo63rrf/hpIb1Dm7yD7LlJPZBM0etBB+79JPki386fZRj10Iz64550gt7wJKT
        ZIpt2oV+L4J+OxQfpWCdnBEo85WvEg0/kYzp5CSo+QPjtUnXh05IJ5PQELCxxBqQqyq5d6uBArX2a
        b+2usdyY7SQ=;
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pVW7k-0007el-9p;
        Fri, 24 Feb 2023 11:20:24 +0000
Message-ID: <33f15034-4271-cc38-8162-1eadab392552@iee.email>
Date:   Fri, 24 Feb 2023 11:20:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [GSOC] [PATCH v2 3/3] t9700:delete whitespaces after redirect
 operators
Content-Language: en-GB
To:     Zhang Yi <18994118902@163.com>, git@vger.kernel.org
Cc:     v.garg.work@gmail.com
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
 <20230224013413.1969003-1-18994118902@163.com>
 <20230224013413.1969003-4-18994118902@163.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20230224013413.1969003-4-18994118902@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/02/2023 01:34, Zhang Yi wrote:
> There are whitespaces after redirect operators,which is a deprecated

micro-nit: space after comma, before "which".

Philip
> style.
>
> Delete whitespaces after redirect operators.
>
> Signed-off-by: Zhang Yi <18994118902@163.com>
> ---
>  t/t9700-perl-git.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
> index 671875a3fc..ccc8212d73 100755
> --- a/t/t9700-perl-git.sh
> +++ b/t/t9700-perl-git.sh
> @@ -14,20 +14,20 @@ skip_all_if_no_Test_More
>  # set up test repository
>  
>  test_expect_success 'set up test repository' '
> -	echo "test file 1" > file1 &&
> -	echo "test file 2" > file2 &&
> +	echo "test file 1" >file1 &&
> +	echo "test file 2" >file2 &&
>  	mkdir directory1 &&
> -	echo "in directory1" >> directory1/file &&
> +	echo "in directory1" >>directory1/file &&
>  	mkdir directory2 &&
> -	echo "in directory2" >> directory2/file &&
> +	echo "in directory2" >>directory2/file &&
>  	git add . &&
>  	git commit -m "first commit" &&
>  
> -	echo "new file in subdir 2" > directory2/file2 &&
> +	echo "new file in subdir 2" >directory2/file2 &&
>  	git add . &&
>  	git commit -m "commit in directory2" &&
>  
> -	echo "changed file 1" > file1 &&
> +	echo "changed file 1" >file1 &&
>  	git commit -a -m "second commit" &&
>  
>  	git config --add color.test.slot1 green &&

