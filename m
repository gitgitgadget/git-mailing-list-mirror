From: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
Subject: Re: [PATCH v2] t7012: Implement test for git-checkout
Date: Sat, 26 Mar 2016 05:09:38 +0530
Message-ID: <56F5CC3A.90500@gmail.com>
References: <56F5CAEF.9070906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 00:40:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajbLZ-0001ae-Jd
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbcCYXkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:40:49 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34131 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbcCYXks (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:40:48 -0400
Received: by mail-pa0-f65.google.com with SMTP id hj7so7888650pac.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=1GSBWmdl7FyvB5IuqkuT5xhEmt4MYUHauqY53gdHQVM=;
        b=w0pIupIOr7YSSqKGbPqRz+JuJ/lwIJENJC56C4Cp/es/bvSKFsjAyIqSV8JrSiqiK1
         KrsQgxIRUpBTdjjByx2qwrvMLLJEBDlb6gPYoc6oPi1zKHgyGFbzR59hLSOfWg2ZbFSt
         biqP1BB1PTrwEtVJ+irJv9p3YNGIQi++8ZyK0OUfCMVBMNCIB4NwWVKXL/djO64MbRKy
         msf8/E2Z3SzBZ1eA8w+8cX9Wxwk1otrcduzA+k6o1VJT9GBDxeHLyH4sHqvs0UmcyEwL
         KsEFZNYIrOzUd7cTFaG04U/MYPBy3LI3LfNwCJZ2DRtXJnNJw1Bnsxi68jHrZRZNTdPA
         gvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1GSBWmdl7FyvB5IuqkuT5xhEmt4MYUHauqY53gdHQVM=;
        b=RzcCqvcXB1Kc7Bvh8J9bZ6X2WBoB7AXrBBlR3KqGLUVjJG4Fvd1DGRlI2NbPwgZtzW
         TRJn+B5mCw8TEz2oWVusPEMC/GymkApTZFggNrVINsjnlvZAl8rzCBrH5s0fyM4ld7zG
         7wpZzq54JmoMehFI7uEEVFKnn6W3EDpfLk3R/vYSEPxa48ygOLDMMdzeRScREf3fGVLu
         4HAf5PCkFThjZLatim9RdRJUtnb9rD+VDIRkcpmrb9wGZEHiE773Bm9/I3XaLIKty//F
         GgvoY+6cMSVrZnbLzCTXayzdU8iTWHFzE7NUHiwttFiTdNJgV/TJ4qpyFKpP6R885b3l
         o46g==
X-Gm-Message-State: AD7BkJIQqq0dVEIMRIW5t4uBpVAoZSSActln1L32Gj5ffL+1S0WJunNqXkFeqztVW4vSIw==
X-Received: by 10.66.141.134 with SMTP id ro6mr24193899pab.111.1458949247869;
        Fri, 25 Mar 2016 16:40:47 -0700 (PDT)
Received: from [0.0.0.0] ([128.199.85.127])
        by smtp.gmail.com with ESMTPSA id n66sm18718855pfj.39.2016.03.25.16.40.46
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 16:40:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <56F5CAEF.9070906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289972>



On 03/26/2016 05:04 AM, Chhatoi Pritam Baral wrote:
> Previously a TODO; add a test for git-checkout skipping a
> file with the skip-worktree bit set.
>
> Signed-off-by: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
> ---
>
> This is a microproject for my GSoC '16 application.
>
> Thanks, Torsten, for pointing out my mistakes. :)
> It was my first time sending patches in mail (and not as attachments).
>
>  t/t7012-skip-worktree-writing.sh | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7012-skip-worktree-writing.sh
> b/t/t7012-skip-worktree-writing.sh
> index 9ceaa40..276f076 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
>  #TODO test_expect_failure 'git-apply removes file' false
>  #TODO test_expect_failure 'git-mv to skip-worktree' false
>  #TODO test_expect_failure 'git-mv from skip-worktree' false
> -#TODO test_expect_failure 'git-checkout' false
> +
> +test_expect_success 'git-checkout ignores skip-worktree file' '
> +	echo >1 &&
> +	git commit -m "Add files" &&
> +	echo dirty >1 &&
> +	echo dirty >2 &&
> +	git update-index --skip-worktree 1 &&
> +	git checkout -- . &&
> +	grep -q dirty 1 &&
> +	test_must_fail grep -q dirty 2
As Eric mentioned on another thread, test_must_fail needs replacing with
'!'.

I'll just wait a while, let the two thread collect responses before I
begin a v3 thread.
> +'
>   test_done
