From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 3/7] t2105 (gitfile): add missing &&
Date: Tue, 07 Sep 2010 08:57:18 -0400
Message-ID: <4C8636AE.7070104@kitware.com>
References: <4C85357A.8090000@web.de> <20100906190655.GG25426@burratino> <4C854B36.6010606@web.de> <20100907014135.GA1182@burratino> <20100907014910.GD1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 14:57:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osxjs-0000nl-RK
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 14:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab0IGM5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 08:57:24 -0400
Received: from public.kitware.com ([66.194.253.19]:39389 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198Ab0IGM5X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 08:57:23 -0400
Received: by public.kitware.com (Postfix, from userid 5001)
	id 230ED1B1CF; Tue,  7 Sep 2010 08:57:21 -0400 (EDT)
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 10A861B1CF;
	Tue,  7 Sep 2010 08:57:19 -0400 (EDT)
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id CA564E765C;
	Tue,  7 Sep 2010 08:57:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100805 Icedove/3.0.6
In-Reply-To: <20100907014910.GD1182@burratino>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155702>

On 09/06/2010 09:49 PM, Jonathan Nieder wrote:
> Make sure early failures are not masked by later successes.
> 
> Cc: Brad King <brad.king@kitware.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

An obvious oversight on my part.

Acked-by: Brad King <brad.king@kitware.com>

Thanks,
-Brad

>  t/t2105-update-index-gitfile.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/t/t2105-update-index-gitfile.sh b/t/t2105-update-index-gitfile.sh
> index 641607d..a7f3d47 100755
> --- a/t/t2105-update-index-gitfile.sh
> +++ b/t/t2105-update-index-gitfile.sh
> @@ -13,7 +13,7 @@ test_expect_success 'submodule with absolute .git file' '
>  	(cd sub1 &&
>  	 git init &&
>  	 REAL="$(pwd)/.real" &&
> -	 mv .git "$REAL"
> +	 mv .git "$REAL" &&
>  	 echo "gitdir: $REAL" >.git &&
>  	 test_commit first)
>  '
