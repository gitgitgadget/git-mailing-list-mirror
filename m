From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Teach mailinfo to ignore everything before -- >8 -- mark
Date: Mon, 24 Aug 2009 14:16:23 +0900
Message-ID: <20090824141623.6117@nanako3.lavabit.com>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
	<1250999357-10827-3-git-send-email-git@tbfowler.name>
	<7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
	<20090823171819.6117@nanako3.lavabit.com>
	<7v1vn2yklo.fsf@alter.siamese.dyndns.org>
	<20090824060708.6117@nanako3.lavabit.com>
	<alpine.DEB.2.00.0908231705200.29625@GWPortableVCS>
	<7v7hwurwmu.fsf@alter.siamese.dyndns.org>
	<20090824041608.GC3526@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thell Fowler <git@tbfowler.name>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Mon Aug 24 07:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfRxg-00009S-1h
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 07:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbZHXFTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 01:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZHXFTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 01:19:09 -0400
Received: from karen.lavabit.com ([72.249.41.33]:45713 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375AbZHXFTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 01:19:08 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 452D311B8BD;
	Mon, 24 Aug 2009 00:19:10 -0500 (CDT)
Received: from 4130.lavabit.com (200.223.181.44)
	by lavabit.com with ESMTP id UAMEDSKEW6MU; Mon, 24 Aug 2009 00:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=tbSdFIpCMXNoAuSk7l26HAbYEVWc9mJmHHHBoVAhzq0tRRm/izeEfzq4HtVZAUhDCMnpoIaYQKSfBJCMtmp3kXQjfKw8SWuDuXjnEhOfHUEd8GpGT4UoTAEjXSa/FI2HD+TyPb5NSwOtp3WOafWVjJB47R/kBDyZ4mYzEuWva4M=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090824041608.GC3526@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126906>

Quoting Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index fcacc94..0c9a791 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -138,6 +138,9 @@ The commit message is formed by the title taken from
> the
>  where the patch begins.  Excess whitespace at the end of each
>  line is automatically stripped.
>  
> +If a line starts with a "-- >8 --" mark in the body of the message,
> +everything before (and the line itself) will be ignored.

Looking at the way other people use the mark in their messages, I think this explanation isn't correct.

A scissors mark doesn't have to be at the beginning. The line has to contain the mark, and it has to consist of only the mark, '-' minus, the phrase "cut here", and whitespaces.

I am not familiar enough with the code to comment on the bug you are reporting.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
