Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803EE2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbdJ1RcL (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:32:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:59713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbdJ1RcK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:32:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mbxdm-1dqPc83PWw-00JMUh; Sat, 28
 Oct 2017 19:32:06 +0200
Date:   Sat, 28 Oct 2017 19:32:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] builtin/describe: describe blobs
In-Reply-To: <20171028004506.10253-3-sbeller@google.com>
Message-ID: <alpine.DEB.2.21.1.1710281926020.6482@virtualbox>
References: <20171028004419.10139-1-sbeller@google.com> <20171028004506.10253-1-sbeller@google.com> <20171028004506.10253-3-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OTpgQAc5bZROlRqsw4lV1cKi4mA3mzI1GBRBIzQxy2BSywoFN5o
 qGCPR5Kzb4nfFfu0WE7zhh/i+rEBmU/90U+SfZY3HGDc3HRg+cBd2aY14Dn7ldUtXyXl46A
 u+Q8z5Oo+fcD6QmDnPPSq2r4K6qXZD7kLh8n9amvw5LXbju9PBOlLc8Y19MYsPapUderokr
 lbz+/a7srAxbO+UARglmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7BB436wEkf0=:NKEDDGA4yglcxILPVvaci3
 1D3JH//aJTaEKsv00O6VPG+yf1WnOoTtYcnZtLI/Fo/uqGpXkp2/Lr7TBovBHN4Qe8OmSo95b
 BQglGwPbfm3iWCXKgrASIwQU571/Gm1SSlcTpYLCMnyJUZFXcgHIRU8EDsTnoDMJCC85rzPdu
 trA+ECZMb43I/m7CH7+SN3GhODG57kEr7kPdoC/ECsUqvoGXPiFNJQpAIrO3B8Q6bnSOMIRqd
 uPX0ZMrogwz4Aw3byN0Xqn8Ytl711lnFN2scKnldFqZr8AAWRF0ugIXhqX1Tjo1S/7daIVL77
 PCJVuC4wNNIiRrylE4b7gUVHYFZ2spI2Qv2U5+/m+i38iGvWsJcamXj7yeEVdaLUPhOGzMThY
 TSACh+3Ix4thGmy87E7Gq2T2GXfOEibyDOkluwCxVV/YxTnDnZeOjsKMeHwgiJWcNb6smy/1T
 MQdDR9JouHcA0YzHWi78MwM7kZTqXqeEsWebj70ZSPWopGXQTvRkhFHzcJhsKTSU16Q46n2jM
 TPNiImdkWcMTRWxKn250Na+XDW1krUbUI/LUJitQ1FqSCwcm6zSDdxVQ0Fx4WJjo5AsRZ3hhK
 Vyv3ar64/twLZGJD3TaVI+TglIN5Wb6hUbYvsCiPkNrtLABhmZanpi2zJ7gP4MXSRszMZbjbF
 79kh6clsICChsUBAGGbH0ql+CyscDS4iZIweN+0YOrg6wCW1QH5UDcYP9OXystsOH0fPcEjJZ
 k0vVeVh5p7VZjnvFggsjywtMv3PGVhQ8xNNuQrndMPN/VQ8nMV0hJbiIbSnVNr4uD9Ag6e3k2
 zuW/LR0+RrGN6G/6V7Qj21wBlkaLLPdKaoEPZuKv6cbdu+nY9trPYhSqibv1rOJL0T5TqiO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 27 Oct 2017, Stefan Beller wrote:

> Sometimes users are given a hash of an object and they want to identify
> it further (ex.: Use verify-pack to find the largest blobs, but what are
> these? or [1])
> 
> The best identification of a blob hash is done via a its path at a
> given commit, which this implements.
> 
> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob

I also came up with a script to do that:
https://github.com/msysgit/msysgit/blob/master/bin/what-made-this-repo-so-large.sh

Your method is much more elegant, of course (it describes the commit in the
same run as it finds the object, and it does not output tons of stuff only
to be filtered).

> @@ -282,6 +283,50 @@ static void show_suffix(int depth, const struct object_id *oid)
>  	printf("-%d-g%s", depth, find_unique_abbrev(oid->hash, abbrev));
>  }
>  
> +struct blob_descriptor {
> +	struct object_id current_commit;
> +	struct object_id looking_for;
> +};

Personally, I would call this process_commit_data, but I do not mind too
much about the name.

> +static void process_object(struct object *obj, const char *name, void *data)
> +{
> +	struct blob_descriptor *bd = data;
> +
> +	if (!oidcmp(&bd->looking_for, &obj->oid))
> +		printf(_("blob %s present at path %s in commit %s\n"),
> +			oid_to_hex(&bd->looking_for), name,
> +			oid_to_hex(&bd->current_commit));
> +}

s/name/path/

> @@ -295,9 +340,14 @@ static void describe(const char *arg, int last_one)
>  
>  	if (get_oid(arg, &oid))
>  		die(_("Not a valid object name %s"), arg);
> -	cmit = lookup_commit_reference(&oid);
> -	if (!cmit)
> -		die(_("%s is not a valid '%s' object"), arg, commit_type);
> +	cmit = lookup_commit_reference_gently(&oid, 1);
> +	if (!cmit) {
> +		if (lookup_blob(&oid))
> +			describe_blob(oid);
> +		else
> +			die(_("%s is not a commit nor blob"), arg);

s/not/neither/

Nicely done, sir!

I wonder whether it would make sense to extend this to tree objects while
we are at it, but maybe that's an easy up-for-grabs.

Thank you very much!
Dscho
