Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52181F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbeKMAs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:48:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:59797 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbeKMAs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:48:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3sy-1fsMVC2p3U-00ev65; Mon, 12
 Nov 2018 15:54:42 +0100
Date:   Mon, 12 Nov 2018 15:54:41 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
In-Reply-To: <xmqqftw61sa0.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1811121554060.39@tvgsbejvaqbjf.bet>
References: <20181112084031.11769-1-carenas@gmail.com> <20181112084031.11769-3-carenas@gmail.com> <xmqqftw61sa0.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1183049641-1542034482=:39"
X-Provags-ID: V03:K1:FnQ8sHfqePe9UXmHS99feE4mzZm9uwFuy8/PYASvn7bZEM2bLlN
 2V2kjdt7P+2SbKzCfDKDLKW+aSZuiylvDkjR5SY5vesV7BhY92t5T/c88OmyBs//0ojMN6G
 zm/2YLzJDCX5Hrw2uvqzKtkm+2HWrzOE/Tn51ur2kNMUmOcKvc0BYKGaMQTnkTrqWtTb748
 kH3RjeiCj5XhStHWsgHfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gj/aZ3/vNbQ=:KCBYpLPWXnhbV57lIOVDYR
 Fl1a1FFJHWYJC4H+2nVZFBIaaqbwge2MWCEQFZ2cAlsG/6kcEp2Yf0jNjCZ4dkrt6TthH68Oj
 l1QFa5oinnytHKj/7/qQTXAmcE941wWA2bj1k//crm2/IRoTxVh99VC3PEHeIYHOi9N/SZSHm
 x8aQBDMMSqpZ9URekgrh8x5oxDPqkb7Xt7jLAs6qeFih2OWBnkEHIcrS1WfwSoZeFvhGKdRqb
 gtm9/T86Mxj+l6kiOJLpdsu9fLFoiM2cTkf0gKEwY56o1sWLt5KRSOItRGHGVjtk5PY5OP/oa
 BUGsTJ7TcgcsJ5W/mDArikjgCI0xBiqnDBYMqdVS67FCGy86pv4dYlbDAu6R2zzVkH7oJMUUQ
 qBRaZOf88g0NR3p1Iw4yYB8eJJdndz50NxhyBI9nLpd1Z3nJEcLJeUkXZjwtUuhBLMyjqgWGx
 hlctD21f74r7Yv2dW9SFyY6mSnkfiQC9sSAmeut3xew6a3RqpkkHle78E6fzlHjsd4xxC0u5M
 43dYNmFR/bF8/ZTdW14K2vB3TfN1QDP1k6P10oZS3CEC4M0o4Rxe12WH8TXLrulvt2PRafiOr
 y75h/2iPqfX2oVkv5Luu0HUnzjjXMU4TXMNIJnfgt5tAt/vIBlyiL5zaWlGk2Hei8+VGScjWd
 5DSbmk+xFCRphTDWrM1jKrjNX6cZZj3osd/wbQvl2vP77Gw1u7eZbO/9k5z1IVe+TiwPDuio6
 ryjNaDCr2hwWTD7UPiC0/chfxkycFQr7DLwuNERjdw/2jHHUyT/R8LMU86q73dijR9S3y8ZCS
 EXaLYuhpj0Hm1EiepksnHfJlGwAHU4crr7nkhrgYj2Pg2kwD029pKYn7FAcyCNJhK3FusKP5X
 mrMVvubiKHIxr+i593KkBeOPVywIVw8ow4BiMpUsYrvFLkIxfnggsSbPwXem83dUZIqSNSuSy
 gk2+4MVNmng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1183049641-1542034482=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 12 Nov 2018, Junio C Hamano wrote:

> Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:
> 
> > b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
> > introduced get_shared_index_expire_date using unsigned long to track
> > the modification times of a shared index.
> >
> > dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
> > shows why that might problematic so move to time_t instead.
> >
> > Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> > ---
> >  read-cache.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/read-cache.c b/read-cache.c
> > index 7b1354d759..5525d8e679 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *istate,
> >  
> >  static const char *shared_index_expire = "2.weeks.ago";
> >  
> > -static unsigned long get_shared_index_expire_date(void)
> > +static time_t get_shared_index_expire_date(void)
> >  {
> > -	static unsigned long shared_index_expire_date;
> > +	static time_t shared_index_expire_date;
> >  	static int shared_index_expire_date_prepared;
> >  
> >  	if (!shared_index_expire_date_prepared) {
> 
> After this line, the post-context reads like this:
> 
> 		git_config_get_expiry("splitindex.sharedindexexpire",
> 				      &shared_index_expire);
> 		shared_index_expire_date = approxidate(shared_index_expire);
> 		shared_index_expire_date_prepared = 1;
> 	}
> 
> 	return shared_index_expire_date;
> 
> Given that the function returns the value obtained from
> approxidate(), which is approxidate_careful() in disguise, time_t is
> not as appropriate as timestamp_t, no?
> 
> IOW, what if time_t were narrower than timestamp_t?

Riiiight. From the patch, I had assumed that the return type of
`approxidate()` is `time_t`, but it is `timestamp_t`.

Ciao,
Johannes

> 
> 
> > @@ -2643,7 +2643,7 @@ static unsigned long get_shared_index_expire_date(void)
> >  static int should_delete_shared_index(const char *shared_index_path)
> >  {
> >  	struct stat st;
> > -	unsigned long expiration;
> > +	time_t expiration;
> >  
> >  	/* Check timestamp */
> >  	expiration = get_shared_index_expire_date();
> 
--8323328-1183049641-1542034482=:39--
