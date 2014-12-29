From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs.c: remove extern keyword from function definition
Date: Mon, 29 Dec 2014 02:41:08 +0100
Message-ID: <54A0B134.2010708@alum.mit.edu>
References: <54945F68.9000807@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Dec 29 02:41:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5PKn-0006Cz-8w
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 02:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbaL2BlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2014 20:41:21 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63069 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751529AbaL2BlU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Dec 2014 20:41:20 -0500
X-AuditID: 12074411-f79fa6d000006b8a-cf-54a0b1377ea1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 41.44.27530.731B0A45; Sun, 28 Dec 2014 20:41:11 -0500 (EST)
Received: from [192.168.69.130] (p5DDB08D1.dip0.t-ipconnect.de [93.219.8.209])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBT1f9Np023625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 28 Dec 2014 20:41:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <54945F68.9000807@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqGu+cUGIwYvtbBZdV7qZLBp6rzBb
	7J62gM2B2ePiJWWPxxNPsHp83iQXwBzFbZOUWFIWnJmep2+XwJ1xcdF8poIG/orL/1pYGxhb
	eLoYOTkkBEwk9u87yAJhi0lcuLeerYuRi0NI4DKjxJTpjawQzjkmiRt3HoBV8QpoS2w/9JcZ
	xGYRUJV4N+EKmM0moCuxqKeZCcQWFQiSuNKymRmiXlDi5MwnYL0iQDWL550EizML+Emc39LH
	DmILC3hLzHpzixHEFhIwklj0aC8biM0pYCzRfPQFE0S9usSfeZegeuUltr+dwzyBUWAWkhWz
	kJTNQlK2gJF5FaNcYk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZI8AruYJxxUu4Q
	owAHoxIP74Rj80OEWBPLiitzDzFKcjApifLKrl8QIsSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	16gMKMebklhZlVqUD5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuBtAhkqWJSanlqR
	lplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rV+GJgtIKkeID27gBp5y0uSMwFikK0nmLU5dh3
	cfdMJiGWvPy8VClx3sMgRQIgRRmleXArYKnqFaM40MfCvM9AqniAaQ5u0iugJUxAS2YdnA+y
	pCQRISXVwOjHfmj5q/clHQVCKbf3LeNUMZdao2UzVevFhazGK3aLqtWseKzdv6SLPirYPNNM
	47xGz4XKcCMfn8W2nFXiPVW7G17082hHzNz5zKREdPO6HwZRoss++JUlBih+kGdl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261858>

On 12/19/2014 06:24 PM, Ramsay Jones wrote:
> 
> Commit 5ed85684 ("reflog_expire(): new function in the reference
> API", 12-12-2014) added a new function definition which included
> the extern keyword.
> 
> While this is not an illegal use of the keyword, it is somewhat
> unusual to include it in a function definition. (It would be
> unique in the git codebase). Also, it triggers a warning from
> sparse. In order to suppress the warning, simply remove the
> extern keyword from reflog_expire() definition.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Michael,
> 
> If you need to re-roll your 'mh/reflog-expire' series, could you
> please squash this into the relevant patch.

Thanks for spotting this! It looks like Junio has already squashed this
commit into place in the "pu" version of my branch. So thanks Junio, too!

Michael

>  refs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 3bd686c..fdef36d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4020,12 +4020,12 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	return 0;
>  }
>  
> -extern int reflog_expire(const char *refname, const unsigned char *sha1,
> -			 unsigned int flags,
> -			 reflog_expiry_prepare_fn prepare_fn,
> -			 reflog_expiry_should_prune_fn should_prune_fn,
> -			 reflog_expiry_cleanup_fn cleanup_fn,
> -			 void *policy_cb_data)
> +int reflog_expire(const char *refname, const unsigned char *sha1,
> +		 unsigned int flags,
> +		 reflog_expiry_prepare_fn prepare_fn,
> +		 reflog_expiry_should_prune_fn should_prune_fn,
> +		 reflog_expiry_cleanup_fn cleanup_fn,
> +		 void *policy_cb_data)
>  {
>  	static struct lock_file reflog_lock;
>  	struct expire_reflog_cb cb;
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
