From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] add DEVELOPER makefile knob to check for acknowledged
 warnings
Date: Thu, 25 Feb 2016 11:20:29 +0100
Message-ID: <56CED56D.5040202@alum.mit.edu>
References: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 11:27:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYt99-0003wq-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 11:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbcBYK1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 05:27:39 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60166 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111AbcBYK1g (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2016 05:27:36 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Feb 2016 05:27:36 EST
X-AuditID: 1207440d-6b7ff7000000068f-9d-56ced57146b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 78.3E.01679.175DEC65; Thu, 25 Feb 2016 05:20:33 -0500 (EST)
Received: from [192.168.69.130] (p548D63F1.dip0.t-ipconnect.de [84.141.99.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u1PAKUA4017874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 25 Feb 2016 05:20:31 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <1456389742-48052-1-git-send-email-larsxschneider@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqFt49VyYQdNhYYuuK91MFg29V5gt
	Hj9cwmrxo6WH2YHFY+esu+wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xpy5M5kK
	popUbP+6nL2BsU2gi5GDQ0LARGLipdAuRi4OIYGtjBIT/rUwQTjnmSSmvd7DDlIkLBAh8Wpv
	fRcjJ4eIgKHEgcvP2EFsIQEPiQ0P/jGC2MwCKhLHOiawgNhsAroSi3qamUBsCQE5id7uSWBx
	XgFtidnrJ7KB2CwCqhI31n5hBbFFBUIk3n99zgpRIyhxcuYTsHpOAU+JCeuXQs3Xk9hx/Rcr
	hC0vsf3tHOYJjAKzkLTMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6
	qSmlmxghwcy7g/H/OplDjAIcjEo8vBG/z4YJsSaWFVfmHmKU5GBSEuU9MO9cmBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3qDTQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpis
	DAeHkgSv2xWgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtNcX
	pJ23uCAxFygK0XqKUVFKnNcZJCEAksgozYMbC0tRrxjFgb4U5l0IUsUDTG9w3a+ABjMBDZ65
	AWxwSSJCSqqBkbMj5NwP58YZt66KfKkIF5kwP2tpuE16uPxhrSovwSshztv+zLg4oTxo1g+d
	RRzPdsy6rhdy9FHt4ar1U+t3NSvu57fyP8NfuDtp65M1c4q/VMVWC16dGf9t4Sfv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287361>

On 02/25/2016 09:42 AM, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> We assume Git developers have a reasonably modern compiler and recommend
> them to enable the DEVELOPER makefile knob to ensure their patches are
> clear of all compiler warnings the Git core project cares about.
> 
> Enable the DEVELOPER makefile knob in the Travis-CI build.
> 
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> This patch is the successor of "[PATCH v1] travis-ci: override CFLAGS properly,
> add -Wdeclaration-after-statement" [1] which enables compiler warnings for the
> Travis-CI build.
> 
> Peff suggested to codify the knowledge about the compiler warnings the Git
> project cares about [2] which I have done here.
> 
> The only problem is the "-Wold-style-declaration" compiler warning as this is
> only supported by GCC and not Clang. Should we ignore that warning or would you
> prefer to detect the GCC compiler and add the warning? The Linux kernel project
> does a similar thing [3].
> 
> 
> Thanks,
> Lars
> 
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/285752
> [2] http://article.gmane.org/gmane.comp.version-control.git/285761
> [3] https://github.com/torvalds/linux/blob/6dc390ad61ac8dfca5fa9b0823981fb6f7ec17a0/Makefile#L303-L306
> 
> 
>  .travis.yml                    |  2 +-
>  Documentation/CodingGuidelines |  4 ++++
>  Makefile                       | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> [...]
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c6e536f..1c676c2 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -171,6 +171,10 @@ For C programs:
> 
>   - We try to keep to at most 80 characters per line.
> 
> + - As a Git developer we assume you have a reasonably modern compiler
> +   and we recommend you to enable the DEVELOPER makefile knob to
> +   ensure your patch is clear of all compiler warnings we care about.
> +

Instead of saying "enable the DEVELOPER makefile knob" could you be more
explicit? Like maybe "create a file called `config.mak` and add the line
`DEVELOPER=1` to it"? (Or whatever is your preferred way to tweak this
setting.)

>   - We try to support a wide range of C compilers to compile Git with,
>     including old ones. That means that you should not use C99
>     initializers, even if a lot of compilers grok it.
> [...]

Michael
