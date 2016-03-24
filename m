From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 09/33] refs: reduce the visibility of do_for_each_ref()
Date: Thu, 24 Mar 2016 08:07:56 +0100
Message-ID: <56F3924C.3040408@alum.mit.edu>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
 <1456793586-22082-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 24 08:15:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aizUI-0002OY-74
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 08:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbcCXHPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 03:15:18 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56183 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbcCXHPQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 03:15:16 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2016 03:15:15 EDT
X-AuditID: 12074411-fe7ff700000071cf-4a-56f3924f9bbb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id DF.3A.29135.F4293F65; Thu, 24 Mar 2016 03:07:59 -0400 (EDT)
Received: from [192.168.69.130] (p548D66F7.dip0.t-ipconnect.de [84.141.102.247])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2O77uq1011444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 24 Mar 2016 03:07:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1456793586-22082-10-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqOs/6XOYwZ5rahbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWjuweeycdZfd41nvHkaPi5eUPfYv3cbmseD5fXaPz5vkAtii
	uG2SEkvKgjPT8/TtErgzenZfYCt4xVvRfqKLpYHxOVcXIyeHhICJREvrO+YuRi4OIYGtjBIT
	d/9nBEkICVxgkuh9UgZiCwv4Sczct5MdxBYRyJaY8+kcK0RDB6PE1IfLWEESzALREtf2tzOD
	2GwCuhKLepqZQGxeAW2JyRMh4iwCqhJ7Fl1kAbFFBUIktq37xgpRIyhxcuYTsDingJfEzDs3
	2SBm6knsuP4Lar68xPa3c5gnMPLPQtIyC0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+bl
	pRbpmurlZpbopaaUbmKEhLfgDsYZJ+UOMQpwMCrx8N7k+hwmxJpYVlyZe4hRkoNJSZT3YyVQ
	iC8pP6UyI7E4I76oNCe1+BCjBAezkggvXx1QjjclsbIqtSgfJiXNwaIkzsu3RN1PSCA9sSQ1
	OzW1ILUIJivDwaEkwXtsIlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgm44uB
	UQmS4gHaOxGknbe4IDEXKArReopRUUqcNwAkIQCSyCjNgxsLS1qvGMWBvhTmZQap4gEmPLju
	V0CDmYAGL/T5BDK4JBEhJdXAGLZPafqpv/VJBVG3T25aHTLX8yavUvf2/8dchVcm/D4ikaJc
	vD/cnk1H9GK0h1uIgdY+d1V1hymHhPWO7XO6ud7R++vLqwYJHftXZ4TvZLqjHLWx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289716>

On 03/01/2016 01:52 AM, David Turner wrote:
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> 
> Now that we have moved do_for_each_ref into refs.c, it no longer needs
> to be public.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c               | 19 +++++++++++--------
>  refs/refs-internal.h |  6 ------
>  2 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index dc5682a..cea5997 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1142,6 +1142,17 @@ int head_ref(each_ref_fn fn, void *cb_data)
>  	return head_ref_submodule(NULL, fn, cb_data);
>  }
>  
> +/*
> + * The common backend for the for_each_*ref* functions
> + */
> +static int do_for_each_ref(const char *submodule, const char *base,
> +		    each_ref_fn fn, int trim, int flags,
> +		    void *cb_data)

The two lines above are indented incorrectly.

> +{
> +	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
> +						 flags, cb_data);
> +}
> +
>  int for_each_ref(each_ref_fn fn, void *cb_data)
>  {
>  	return do_for_each_ref(NULL, "", fn, 0, 0, cb_data);
> @@ -1342,11 +1353,3 @@ int resolve_gitlink_ref(const char *path, const char *refname,
>  {
>  	return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
>  }
> -
> -int do_for_each_ref(const char *submodule, const char *base,
> -		    each_ref_fn fn, int trim, int flags,
> -		    void *cb_data)
> -{
> -	return the_refs_backend->do_for_each_ref(submodule, base, fn, trim,
> -						 flags, cb_data);
> -}

Nit: in the previous patch, please put the function where you want it so
that you don't have to move it in this patch.

> [...]

Michael
