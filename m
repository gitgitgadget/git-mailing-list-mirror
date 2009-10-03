From: Johan Sageryd <j416@1616.se>
Subject: Re: [PATCH] Fix '--relative-date'
Date: Sat, 03 Oct 2009 20:18:39 +0900
Message-ID: <4AC7330F.3070502@1616.se>
References: <1254543618-3772-1-git-send-email-j416@1616.se> <20091003100615.GC17873@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 03 13:40:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu2yh-0007qZ-Sy
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 13:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270AbZJCLke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 07:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbZJCLke
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 07:40:34 -0400
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:29310 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219AbZJCLkd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 07:40:33 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Oct 2009 07:40:33 EDT
Received: from mail.1616.se (attsi1-src.asahi-net.or.jp [220.157.253.2])
	by mail1.asahi-net.or.jp (Postfix) with ESMTP id A12AF724F2;
	Sat,  3 Oct 2009 20:18:40 +0900 (JST)
Received: from j.local (unknown [10.0.1.1])
	by mail.1616.se (Postfix) with ESMTP id E9CD71A7BE20;
	Sat,  3 Oct 2009 20:18:40 +0900 (JST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
In-Reply-To: <20091003100615.GC17873@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129484>

> I've picked up your patch in my tree with the following test squashed
> in:
> 
> diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> index a4d8fa8..75b02af 100755
> --- a/t/t0006-date.sh
> +++ b/t/t0006-date.sh
> @@ -24,6 +24,7 @@ check_show 13000000 '5 months ago'
>  check_show 37500000 '1 year, 2 months ago'
>  check_show 55188000 '1 year, 9 months ago'
>  check_show 630000000 '20 years ago'
> +check_show 31449600 '12 months ago'
>  
>  check_parse() {
>  	echo "$1 -> $2" >expect

Thank you!

/Johan
