From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Typofixes outside documentation area
Date: Thu, 4 Feb 2010 11:59:51 +0100
Message-ID: <201002041159.51543.trast@student.ethz.ch>
References: <7v636dr2hy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:00:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NczRX-0003G8-MS
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 12:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049Ab0BDLAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 06:00:10 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:57004 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756614Ab0BDLAI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 06:00:08 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 4 Feb
 2010 12:00:07 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 4 Feb
 2010 11:59:51 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.98; x86_64; ; )
In-Reply-To: <7v636dr2hy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138962>

On Thursday 04 February 2010 06:31:05 Junio C Hamano wrote:
> diff --git a/levenshtein.h b/levenshtein.h
> index 0173abe..4105bf3 100644
> --- a/levenshtein.h
> +++ b/levenshtein.h
> @@ -2,7 +2,7 @@
>  #define LEVENSHTEIN_H
>  
>  int levenshtein(const char *string1, const char *string2,
> -	int swap_penalty, int substition_penalty,
> +	int swap_penalty, int substitution_penalty,
>  	int insertion_penalty, int deletion_penalty);
>  
>  #endif

To save others the trouble of looking it up, too:

This does change the name of the parameter, but it's only the
declaration.  The actual definition of the function starts with

	int levenshtein(const char *string1, const char *string2,
			int w, int s, int a, int d)
	{

so it doesn't need a similar rename, and no uses of the parameter are
affected.

AFAICS all other changes are only in comments or strings and should be
safe.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
