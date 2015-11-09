From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 01/11] refs: make is_branch public
Date: Mon, 9 Nov 2015 18:54:11 +0000
Message-ID: <5640EBD3.8040505@ramsayjones.plus.com>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
 <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1447085798.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 19:54:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvraN-0000wJ-Ft
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 19:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbbKISyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 13:54:25 -0500
Received: from avasout04.plus.net ([212.159.14.19]:55784 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbbKISyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 13:54:23 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout04 with smtp
	id fWuH1r0022GQ2gJ01WuJos; Mon, 09 Nov 2015 18:54:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=CvRCCSMD c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=6NG_XSeZAAAA:8 a=1XWaLZrsAAAA:8
 a=ybZZDoGAAAAA:8 a=XN2BdGY3kv36p1UZWZcA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <39e0a2a708fb1a42b69e45bc5c0b17d565d3662e.1447085798.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281076>



On 09/11/15 17:03, Michael Haggerty wrote:
> From: David Turner <dturner@twopensource.com>
> 
> is_branch was already non-static, but this patch declares it in the
> header.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/refs.h b/refs.h
> index 6d30c98..39b8edc 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -217,6 +217,8 @@ extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct st
>   */
>  int pack_refs(unsigned int flags);
>  
> +int is_branch(const char *refname);
> +
>  /*
>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
> 

I don't understand, is_branch() is already declared in refs.h, see line 67.

This is true in master, next and pu now appears to have two declarations.

ATB,
Ramsay Jones
