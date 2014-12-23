From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 21:31:10 +0100
Message-ID: <5499D10E.5050704@kdbg.org>
References: <20141223084536.GA25190@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 21:31:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3W71-0006kE-MT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 21:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbaLWUbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 15:31:16 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:9572 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751415AbaLWUbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 15:31:16 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3k6Thw32CHz5tlV;
	Tue, 23 Dec 2014 21:31:11 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3B02519F7C8;
	Tue, 23 Dec 2014 21:31:11 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20141223084536.GA25190@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261772>

Am 23.12.2014 um 09:45 schrieb Jeff King:
> @@ -606,7 +606,7 @@ static ucs_char_t next_hfs_char(const char **in)
>  		 * but this is enough to catch anything that will convert
>  		 * to ".git"
>  		 */
> -		return tolower(out);
> +		return out;

Did you consider changing the comment that we see in the pre-context here?

-- Hannes
