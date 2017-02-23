Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30372022D
	for <e@80x24.org>; Thu, 23 Feb 2017 17:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbdBWRKW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 12:10:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:62536 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbdBWRKT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 12:10:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lrw2c-1cCwbD0rTK-013bNF; Thu, 23
 Feb 2017 18:08:53 +0100
Date:   Thu, 23 Feb 2017 18:08:49 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
In-Reply-To: <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702231806340.3767@virtualbox>
References: <20170222173936.25016-1-dturner@twosigma.com> <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com> <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com> <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
 <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v9K5DDbR8UmzKp82ZnFO4AbfFsezUcEfcfK/hv26rrF6r0aHuez
 VnON8VVWNycVqsW5BClAhp/sxy64GzB39dp8tbetmX4keZ+juZtjj9ftiYepcQbGMMnsPeO
 7R7wENLDURTjMQGGdRTu3AqPgw5mhDD+bySMNO/l932gUk0WVwG/+qSR1s1PKO+hw4W/9uJ
 RQ1Vhddgo4JIwI7twJi1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XHFtSW1l+Yc=:2MESoVTwx3oEST2Dqs35WZ
 S6DLnPWKACpRo+lfWz2riKc4E6lNAXO6lDQr/6Gs4GTnpd9P9VfVUcsYPFQF7l25tCjrcAtBB
 B1opj6xRUS3njb42QDjgYkLhJLvPy3I2wpgiMdL6Q2jJOmFI/U8hPvNP720cUsPURLpV3/bBO
 RwVhJkSXh+XrwmzaTZT9n+NEYYdv0oTkUUh1NBApxdu+SLyvCuUsog/TfrqZxX2jqJlStcyOn
 AB5K8Uh8aCbVHyyWA43a4Ozr8T8kFQ09YMbSDKoh4NrfBtv9cS9skuyTjCewBEj1V8FAyvK//
 U4v7V/ZgxSQj6vrwHqxFOAtH/TZY1aOExt+s4L6LoM41ht2pHpSVzYH9eLxcwwuEVkKgpt+5p
 /6hmRNJm7oibO4ZBaKPsbEEEw2ri/Z2BT0Bz+q6P5IVc0jofDYiSxKVpza4PXedQnf165yNMG
 sbW/IqEkekczrbNCrNBN1q8aR2jVvzBoNGZ0CSgNVM89YCa2LawwD60XlnlE26FNbXn38sHEJ
 Tf/YSGRagKO9DpFFm92hbju1JC0jIN9Hs/gy6kasJISHcEbkceudUPcrduVRSJZq+4FKRm2wb
 D4g02nMc6OFADexnia5561M9biap5QVq8vQ/kDbsPNgc2+OyZiJCHe8mGhDg11L6bIO4H5DIQ
 vbZwwWa7HYUqWJWhbRnLIXc0s+DZZNG7LcNjwrd4H6NUOBjuJxmFkFKoQALDo7PDn1RnJ1iVk
 pV629oQHP0VN6XrWKOEDxIdKR3YOoz5i+icr3YO7WnqzdtH4oxMvLiy3XO3KFSkj+SXAj8eoS
 f66Hb2K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 22 Feb 2017, Jeff King wrote:

> On Wed, Feb 22, 2017 at 01:16:33PM -0800, Junio C Hamano wrote:
> 
> > David Turner <David.Turner@twosigma.com> writes:
> > 
> > > Always, no.  For failed authentication (or authorization),
> > > apparently, yes.  I tested this by  setting the variable to false
> > > and then true, and trying to Push to a github repository which I
> > > didn't have write access to, with both an empty username
> > > (https://@:github.com/...) and no username (http://github.com/...).
> > > I ran this under GIT_CURL_VERBOSE=1 and I saw two 401 responses in
> > > the "http.emptyauth=true" case and one in the false case.  I also
> > > tried with a repo that I did have access to (first configuring the
> > > necessary tokens for HTTPS push access), and saw two 401 responses
> > > in *both* cases.  
> > 
> > Thanks; that matches my observation.  I do not think we care about
> > an extra roundtrip for the failure case, but as long as we do not
> > increase the number of roundtrip in the normal case, we can declare
> > that this is an improvement.  I am not quite sure where that extra
> > 401 comes from in the normal case, and that might be an indication
> > that we already are doing something wrong, though.
> 
> This patch drops the useless probe request:
> 
> diff --git a/http.c b/http.c
> index 943e630ea..7b4c2db86 100644
> --- a/http.c
> +++ b/http.c
> @@ -1663,6 +1663,9 @@ static int http_request(const char *url,
>  		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
>  				options->effective_url);
>  
> +	if (results.auth_avail == CURLAUTH_BASIC)
> +		http_auth_methods = CURLAUTH_BASIC;
> +
>  	curl_slist_free_all(headers);
>  	strbuf_release(&buf);
>  
> 
> but setting http.emptyauth adds back in the useless request. I think
> that could be fixed by skipping the empty-auth thing when
> http_auth_methods does not have CURLAUTH_NEGOTIATE in it (or perhaps
> other methods need it to, so maybe skip it if _just_ BASIC is set).
> 
> I suspect the patch above could probably be generalized as:
> 
>   /* cut out methods we know the server doesn't support */
>   http_auth_methods &= results.auth_avail;
> 
> and let curl figure it out from there.

Maybe this patch (or a variation thereof) would also be able to fix this
problem with the patch:

	https://github.com/git-for-windows/git/issues/1034

Short version: for certain servers (that do *not* advertise Negotiate),
setting emptyauth to true will result in a failed fetch, without letting
the user type in their credentials.

Ciao,
Johannes
