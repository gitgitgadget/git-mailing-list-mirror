From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 03/11] sha1_object_info_extended(): hint about objects
 in delta-base cache
Date: Sat, 21 May 2011 01:05:18 +0200
Message-ID: <4DD6F3AE.6070007@lsrfire.ath.cx>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com> <1305840826-7783-1-git-send-email-gitster@pobox.com> <1305840826-7783-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 01:05:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNYlX-0001HY-ME
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 01:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab1ETXFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 19:05:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:45830 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762Ab1ETXFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 19:05:50 -0400
Received: from [192.168.2.106] (p4FFDA965.dip.t-dialin.net [79.253.169.101])
	by india601.server4you.de (Postfix) with ESMTPSA id 1DC7D2F8086;
	Sat, 21 May 2011 01:05:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <1305840826-7783-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174083>

Am 19.05.2011 23:33, schrieb Junio C Hamano:
> --- a/cache.h
> +++ b/cache.h
> @@ -1030,7 +1030,8 @@ struct object_info {
>  	enum {
>  		OI_CACHED,
>  		OI_LOOSE,
> -		OI_PACKED
> +		OI_PACKED,
> +		OI_DBCACHED,
>  	} whence;

Some compilers don't like trailing commas in enums.
