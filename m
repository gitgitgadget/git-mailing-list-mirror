Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8691F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753204AbdBAWZR (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 17:25:17 -0500
Received: from mout.gmx.net ([212.227.17.22]:58963 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752974AbdBAWYR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 17:24:17 -0500
Received: from virtualbox ([217.136.241.150]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1SLt-1cK0Xn2VxJ-00tVIr; Wed, 01
 Feb 2017 23:24:06 +0100
Date:   Wed, 1 Feb 2017 23:24:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and
 ssh.variant config
In-Reply-To: <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702012319460.3496@virtualbox>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de> <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de> <xmqq1svhpvm0.fsf@gitster.mtv.corp.google.com>
 <xmqqwpd9ofry.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:I+Oe4S3xrCRLMGJP6nwX6ZSZ2Id1nP/RXtWapFsxs69MHy2TNFO
 UDNgKnTQ3n88BGzFIerkq4WcjFs+aQoooarmDCWQRWLW0MRd7Mq7rnDHfLd0rW7xPz6Wc6y
 guTBqVTJG8kim10Z/8ey3EAn3YGXAgi94am6rrpaIKGGxZCy85OTls+91bLojUed4CHUK11
 bfCYQLqVbGgVSyzuFbUzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oCWC1WqpdwI=:5kb2AY8udG8BqI8SP+xz/F
 TJM95+YAiPDLRJM2YTPvqR6E6upN5+lIder2OdW/Sb/fZboEcUjPs2XLH4krtefsif3YwQCq8
 MUwOv/HiQ4oh4zJtckQMTbpo3XaHZvK1+lpikE98ba0Sq8Kh2AWKlzhxB7xIKx8u3sgqsKxlz
 5UGvOTWxrhCwdOhJQUlxT8h/Ow6iJb58BLAnWu0H/HCUblDlqWPIs2kKIykYiu7UY/DgGA273
 /KpYGvxD8OyoZ+KG7UCkcthN8JxvIj7UzllI49T7GQn3Jlnc95sgPdt+LMxbn4kVoOZCkI/Ed
 2Z2DKNTdzue3pVg9Nuu6F2pXPzL0DYPy0rkTj9se5wEj8wLTvSfBagM8ifXSLS4a5Tht16+Xr
 KBy4ApxIFZLQpNegatYDssWYOfAgDirklO6WVhrf7b7/sWptboYpLk6FZOlMlmxeXg3+80sqc
 vTbLcyq3ypaLb4cnit65K47jU3r/f9MMJYcpM9GO+cXbpX53G8NJVIEyS8wc/s+PjV/GS9dAF
 xZjsJCYzqvKv7LGl3OClyj0clm4Yr5nAT3dEBCrGjL0/lEfoeXxb3/8PcIXVabhA94QZYkKLM
 Y8BxC7Tk7DcsHCv+Ke19/SBbVAtCBd4PrLfd6jIrA6wnJf2r2QPtyAWG2zmUZZczq+G+FrHXA
 F4f1kirKf6KemJ9H1XJ31Jv3I0pPeQ/akhKj1KVc1ZTSObuY/gVDHRIaMmrMX+vL5M95f7+91
 Ni+ssMk5QfgAOGo3vyAwZZR71lta+Qo1HZX7hD56GnTVMud/63bqR/u/cST46ysyxffB6EXK6
 yJy2Hc7UxgSJVaXUfFFNO1/DmOBv4T1vjGpxskb2MtUP/3JM1f5dYzAxdK/GKhlHfMi/JUw80
 vQ3OqWL33F7bZzAKUgThDMS6O1hoCwEFpK3Pt6yvV/buwMtv77ZtUxu90oNBeyr1fWxXNA69s
 iQ5HIJgbYPcCQrbClYvx/GKl/Cz+ppnNAHK4yTM2H1796tRhfFBAY3yCO1l3PO3DXyWXaPZSy
 W/DeGnyMnmzOVY9wYzR5KooflxoEBKPqbNvprUC9d818et8ni+0rbIeWPSc37yLVFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Feb 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think restructuring along the line of 3/4 of this round is very
> > sensible in the longer term (if anything, handle_ssh_variant() now
> > really handles ssh variants in all cases, which makes it worthy of
> > its name, as opposed to the one in the previous round that only
> > reacts to the overrides).  But it seems that it will take longer to
> > get such a rewrite right, and my priority is seeing this topic to
> > add autodetection to GIT_SSH_COMMAND and other smaller topics in the
> > upcoming -rc0 in a serviceable and correct shape.
> >
> > The restructuring done by 3/4 can come later after the dust settles,
> > if somebody cares deeply enough about performance in the rare cases.
> 
> Having said all that, because I like the patch 3/4 so much, here is
> another way to fix this, and I think (of course I am biased, but...)
> the result is easier to grok.  Not only it makes it clear that the
> namespace for the actual command names on the command line and the
> namespace for the supported values of the configuration are distinct,
> it makes it clear that we do not do anything extra when the user
> explicitly tells us which variant to use.
> 
> This is designed to be squashed into [4/4] of this latest round (as
> opposed to the one in the message I am responding to, which is to be
> squashed into the previous round).
> 
>  connect.c | 42 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 7f1f802396..12ad8d4c8b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -691,17 +691,39 @@ static const char *get_ssh_command(void)
>  	return NULL;
>  }
>  
> -static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
> -			      int *port_option, int *needs_batch)
> +static int override_ssh_variant(int *port_option, int *needs_batch)
>  {
> -	const char *variant = getenv("GIT_SSH_VARIANT");
> +	char *variant;
> +
> +	variant = xstrdup_or_null(getenv("GIT_SSH_VARIANT"));
> +	if (!variant &&
> +	    git_config_get_string("ssh.variant", &variant))
> +		return 0;
> +
> +	if (!strcmp(variant, "plink") || !strcmp(variant, "putty")) {
> +		*port_option = 'P';
> +		*needs_batch = 0;
> +	} else if (!strcmp(variant, "tortoiseplink")) {
> +		*port_option = 'P';
> +		*needs_batch = 1;
> +	} else {
> +		*port_option = 'p';
> +		*needs_batch = 0;
> +	}
> +	free(variant);
> +	return 1;
> +}
> +
> +static void handle_ssh_variant(const char *ssh_command, int is_cmdline,
> +			       int *port_option, int *needs_batch)
> +{
> +	const char *variant;
>  	char *p = NULL;
>  
> -	if (variant)
> -		; /* okay, fall through */
> -	else if (!git_config_get_string("ssh.variant", &p))
> -		variant = p;
> -	else if (!is_cmdline) {
> +	if (override_ssh_variant(port_option, needs_batch))
> +		return;
> +
> +	if (!is_cmdline) {
>  		p = xstrdup(ssh_command);
>  		variant = basename(p);
>  	} else {
> @@ -717,7 +739,7 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
>  			 */
>  			free(ssh_argv);
>  		} else
> -			return 0;
> +			return;
>  	}
>  
>  	if (!strcasecmp(variant, "plink") ||
> @@ -730,8 +752,6 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
>  		*needs_batch = 1;
>  	}
>  	free(p);
> -
> -	return 1;
>  }
>  
>  /*

That leaves the "putty" case in handle_ssh_variant(), does it not? Was it
not your specific objection that that is the case?

No worries, I will let this simmer for a while. Your fixup has a lot of
duplicated code (so much for maintainability as an important goal... ;-))
and I will have to think about it. My immediate thinking is to *not*
duplicate code, strip the .exe extension directly after calling basename()
in the cases where we handle commands, and handle "putty" in the other
cases by replacing it with the string "plink".

But as I said, this will simmer for a while.

Ciao,
Johannes
