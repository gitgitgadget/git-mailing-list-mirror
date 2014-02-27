From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] GSoC 2014 Microproject 1 rewrite skip_prefix() as loop
Date: Thu, 27 Feb 2014 12:32:08 +0100
Message-ID: <530F2238.4090303@alum.mit.edu>
References: <1393433195.4629.4.camel@dj-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:39:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzJD-0002eJ-EP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbaB0LjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:39:14 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:44051 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752495AbaB0LjN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 06:39:13 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 06:39:12 EST
X-AuditID: 1207440c-f79656d000003eba-25-530f223a8b0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D3.F3.16058.A322F035; Thu, 27 Feb 2014 06:32:10 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RBW87e028515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 06:32:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393433195.4629.4.camel@dj-pc>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqGulxB9s8PqfrMX9ja9YLLqudDM5
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7ozWc/+YC2YKVjx78pG1gfEabxcjJ4eEgInE
	+9eP2CFsMYkL99azdTFycQgJXGaUODNhOSuEc55J4vnHmcwgVbwC2hKff61k6WLk4GARUJWY
	ezUcJMwmoCuxqKeZCcQWFQiWWH35AQtEuaDEyZlPwGwRAXWJOT/egLUyC4hL9P8DCwsLeEuc
	nDQbzBYCmr619z/YGE4BHYmvU6YxgpRLAJX3NAZBdKpLrJ8nBFLBLCAvsf3tHOYJjIKzkOya
	hVA1C0nVAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghgcuzg/HbOplD
	jAIcjEo8vCeY+YKFWBPLiitzDzFKcjApifJ2yfMHC/El5adUZiQWZ8QXleakFh9ilOBgVhLh
	Xc8ElONNSaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfCWKAI1ChalpqdW
	pGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMiN74YGLsgKR6gvZkg7bzFBYm5QFGI1lOMuhy3
	2359YhRiycvPS5US55UFKRIAKcoozYNbAUtTrxjFgT4W5q0HqeIBpji4Sa+AljABLTkqzQOy
	pCQRISXVwOi/NnSi56F/ayRklp45sruSw/BcYtXZ3t6ATRnCel1eLsuZ5s633/H79sYrv6W2
	7xept7i0ZlfQxburtJN2d8atlXyy9lxk8mr9DJ+8zpA36q8zBZQKw09Jn+S6K+Ua 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242808>

On 02/26/2014 05:46 PM, Faiz Kothari wrote:
> I am Faiz Kothari, I am a GSoC aspirant and want to contribute to git.
> I am submitting the patch in reponse to Microproject 1,
> rewrite git-compat-util.h:skip_prefix() as a loop.
> 
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>

The subject of your email plus the part above the "---" line will be
taken directly to be used as the commit message.  So it should not
include information that is inappropriate for a commit message.

You can put such information directly below the "---" line.

Please also see my comments below.

> ---
>  git-compat-util.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index cbd86c3..bb2582a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -357,8 +357,11 @@ extern int suffixcmp(const char *str, const char
> *suffix);
>  
>  static inline const char *skip_prefix(const char *str, const char
> *prefix)

The line above seems to have been broken by your email program.  It is
important for efficiency reasons that patches be readable directly out
of emails (e.g., by using "git am").  Please practice by sending the
patch to yourself different ways until "git am" works on it correctly.

>  {
> -	size_t len = strlen(prefix);
> -	return strncmp(str, prefix, len) ? NULL : str + len;
> +	for (; ; str++, prefix++)
> +		if (!*prefix)
> +			return str;//code same as strbuf.c:starts_with()

We don't use "//" for comments, and please space things out the way
other code does it.  But actually, IMO this particular comment doesn't
really belong permanently in the code.  It rather belongs in the commit
message, or in the discussion (under the "---"), or maybe it should be
taken as an indication of a deeper problem (see below).

> +		else if (*str != *prefix)
> +			return NULL;
>  }
>  
>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
> 

The code itself looks correct.

But, considering your comment, would it be appropriate for one of the
functions to call the other?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
