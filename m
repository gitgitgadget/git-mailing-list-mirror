From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/10] update-index: use enum for untracked cache
 options
Date: Thu, 17 Dec 2015 13:06:15 +0100
Message-ID: <5672A537.2060408@web.de>
References: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
 <1450196907-17805-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 13:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9XKi-0005cw-E3
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 13:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225AbbLQMGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 07:06:50 -0500
Received: from mout.web.de ([212.227.17.11]:51934 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbbLQMGt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 07:06:49 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Lpf3q-1aelKv1Ys2-00fRs0; Thu, 17 Dec 2015 13:06:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <1450196907-17805-2-git-send-email-chriscool@tuxfamily.org>
X-Provags-ID: V03:K0:nPyLHxN4uZibAar5r5H1N5is5jJTQh+lRIwHjGGcjkNoiu0PWf3
 VOLwgRt+XBARwoqAu+2eoI1PCBtsbDa92bmroZWeUR/KPQHuNS33aTHhpRZM/5ioUNhn8W0
 5k4hQn410h29ao78jSMC0D8Pyh23zxKXae6THL9/4VaFr0S3zjZB9BtElSoR2Osm6D0I4PQ
 w0ccrKPey8mICBIYy+d6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dl4MZmR5Ct8=:nTgK2poq/RbGLKKQs+zths
 p1oLuLEgP8HLUgUO0v1Wod3aJixRj0JBjc3HXkw0N5kau0vvChEJz4aG/69bk1Lh+Y83gyJxA
 JudxEGYepIkVx5iQHkbANztI0y8nIFExVz3K+PU56D2YLefz+6tQkzoLDrTXooPu0gIyDSfg/
 4IRj4xPK+Bh89+RoIGWwAj1H9muTTZwBKfbRdYdm2LJgcYCW8Wn2U2NZYwL3ozGmCaOvycxgJ
 BZM3RC30GqaYC/CNUndw59/AuA656hteHLsT6ORVdXUCiMEggK3C5mDZYh5A0JXI/KaiAC2OL
 qHffBxoNtN3WmbDKQVx1pt3s1gKU9Lz3xfjiQHO6k712NcXMIdcyBKCq/LG6z2T64Rn7y6UGu
 urrkLWId8vEbFJgKxpVtd0Qgv0YB+bQFIGaGXmbxCH3Mprh4rkBSK8QmaNNvgMqeD1pb90gfH
 GobiOMuqTqZ3+xy/zfcMI/lqjYaDVoDtyA+IQeGEqSGCpw0UdyKJuZwdz85TUbjzbQVKLSUGq
 uSL8ScFLygzqXPDQD1+sWsgTHpEmcXWomhuVDiFg6+ns/I36Cg6QwWMWJ+kLepauQdqiqJt8o
 mB9WP/bGNjIUolmuFWDDikt5RIBBDAlsKH4RWPz7ikLSUy6LdFbpxsUswJoKBLA30jjrCZ+wa
 ahKSho8w40gETe8BgdyBwKupHYvbTkpIDAOCvcrQJjDPDt/V8bZkSX9tMBlM2KoQnQ25JezmU
 cpXAK3lNhi63vMDN+9OcY0ShyS/15rhyrlFZM/fI1mr77SD3vBESuWk1Z0+OcBEi8p/ntq/g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282649>

On 15.12.15 17:28, Christian Couder wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..2430a68 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
>  #define UNMARK_FLAG 2
>  static struct strbuf mtime_dir = STRBUF_INIT;
>  
> +/* Untracked cache mode */
> +enum uc_mode {
> +	UC_UNSPECIFIED = -1,
> +	UC_DISABLE = 0,
> +	UC_ENABLE,
> +	UC_FORCE
> +};
> +
>  __attribute__((format (printf, 1, 2)))
>  static void report(const char *fmt, ...)
>  {
> @@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
>  int cmd_update_index(int argc, const char **argv, const char *prefix)
>  {
>  	int newfd, entries, has_errors = 0, line_termination = '\n';
> -	int untracked_cache = -1;
> +	enum uc_mode untracked_cache = UC_UNSPECIFIED;
>  	int read_from_stdin = 0;
>  	int prefix_length = prefix ? strlen(prefix) : 0;
>  	int preferred_index_format = 0;
> @@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "untracked-cache", &untracked_cache,
>  			N_("enable/disable untracked cache")),
>  		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
> -			    N_("enable untracked cache without testing the filesystem"), 2),
> +			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
>  		OPT_END()
>  	};
>  
> @@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		the_index.split_index = NULL;
>  		the_index.cache_changed |= SOMETHING_CHANGED;
>  	}
> -	if (untracked_cache > 0) {
> +	if (untracked_cache > UC_DISABLE) {
I think the "correct way" for a comparison between an enum and an int is to cast the enum
into an int.
But, if we have an enum, these kind of comparision should go away, and replaced
with a switch-case (or if) statemant.
>  		struct untracked_cache *uc;
>  
> -		if (untracked_cache < 2) {
> +		if (untracked_cache < UC_FORCE) {

Same here
