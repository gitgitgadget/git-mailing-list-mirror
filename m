Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A2711F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 08:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbeKMSrK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 13:47:10 -0500
Received: from mout.gmx.net ([212.227.15.18]:47699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730736AbeKMSrK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 13:47:10 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpsIh-1fsMy722VT-00fkUC; Tue, 13
 Nov 2018 09:49:52 +0100
Date:   Tue, 13 Nov 2018 09:49:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
In-Reply-To: <20181113074017.17292-1-carenas@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811130948420.39@tvgsbejvaqbjf.bet>
References: <xmqq7ehi1gpb.fsf@gitster-ct.c.googlers.com> <20181113074017.17292-1-carenas@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-351835352-1542098992=:39"
X-Provags-ID: V03:K1:9b1kqnInk9LYmApYETSkMaEmlfltnf1yvHZzNtAbA67vsBP0s1i
 fWJpBXX0D4xn0idFs2X4UbniRP+mBtrMoQe1tYzrtwI3nPG+wsjcQiSsxC3qEngw2+PNXoI
 bC8z5EM5tF+Ke1f8Gu02xbOEF4ojivKjeAuBSPpivOrKwbUIoKgl6r5lIdWw5YpkV+91ZwQ
 0FU5Tm3lFxKLXG9kYKVFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:t6cA7iSdBrU=:h7PqErlrUxqGaH4ZfZbJTQ
 TORxZjfD0Ryw2eA83jGrYrRbryTYPaV2XrzCtz7+BKyRCP7xkR5g2GxkkldOS+Icv7xHCAoS4
 mbcu5qLxpZhUuVr9GGWfW8KRmyBibVofPn/O3njJ60VeHktbhqpe8RpjTdHEsqSUoxrneZCYg
 ZNOZgWTIJ0Q+Iw8eC36bPzXnWxNq8p377nnU/hywOthUhWHVqV1Wvr4cAdVcZ761lpIGuNGpb
 tQ2BpeJj48ZyRiOHg//FRl3HKb4LxG9liNMj4lZEVFlrnMtPuLRoFijsx8J7OlpjgSW0D5Gi/
 31Pd2qIZx9RaAIa6nbw82MnsSASvfs8fREHkDhWRmDeqmQoyx1uEBNWjIoiBrha2kWujiwIcO
 XKbO3gMkLPfLww2NTu4KK7yu4/4SypAPv4hOG2tULL+cvegFmrpmsjNDR6mRQ+6MxjRmWFEM1
 0EKrmqkLry5yzw4VRHki+z2DntB3HxkcF4224X5El7LoNUnQ52pYDW8mjdSGqPjKTAARp/MI2
 ui+XWup9AkUY4ewtvlIimvQ2bP4MdKsPqmbwBZNjQ/nTx2pj/owBJL+EgHGYcOIr6epn1toXQ
 vMXyXEeMfv1HWiXB9i6Ef/wxcJNg+w6qOic6AQvN0xDjfscLnuouGrNs+qh4vVT1IbSvgOkoF
 um3CGDUzu6iQZ7E3zJlYK9jPjRdHZUXrc61Ph/QvHX8CiDEoebK70oTkzTexlEMPy1ZUxX5Qf
 NUb7ePEbxkHTcdn1fxnKchCNLi6NQjTcti8BR9Ww7fwPgmUon+YI1UZwfR+rCGVWcIRxnH6BH
 I7o04KYrjHZu2lwzsMZRMDtgERGfhE4NCKInOZgoWnQ070R9rPA3Jqe8FO//l+YAcDJ7k42Z1
 irmhMWGLiUPfiq6GgRNhP2Axhi+OBNA0r+Na10mnxvdKn7LfwGC0QlEdNWo47jTa1qnOxisIv
 HDV76D/z8lA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-351835352-1542098992=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 12 Nov 2018, Carlo Marcelo Arenas Belón wrote:

> There are still some more possible improvements around this code but
> they are orthogonal to this change :
> 
> * migrate to approxidate_careful or parse_expiry_date
> * maybe make sure only approxidate are used for expiration
> 
> Changes in v2:
> * improved commit message as suggested by Eric
> * failsafe against time_t truncation as suggested by Junio
> 
> -- >8 --
> Subject: [PATCH v2 2/2] read-cache: use time specific types instead of
>  unsigned long
> 
> b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
> introduced get_shared_index_expire_date using unsigned long to track
> the modification times of a shared index.
> 
> dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
> shows why that might be problematic so move to timestamp_t/time_t.
> 
> if time_t can't represent a valid time keep the indexes for failsafe

Is this sentence incomplete? What are those "indexes"?

Thanks,
Johannes

> 
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  read-cache.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..7d322f11c8 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *istate,
>  
>  static const char *shared_index_expire = "2.weeks.ago";
>  
> -static unsigned long get_shared_index_expire_date(void)
> +static timestamp_t get_shared_index_expire_date(void)
>  {
> -	static unsigned long shared_index_expire_date;
> +	static timestamp_t shared_index_expire_date;
>  	static int shared_index_expire_date_prepared;
>  
>  	if (!shared_index_expire_date_prepared) {
> @@ -2643,12 +2643,12 @@ static unsigned long get_shared_index_expire_date(void)
>  static int should_delete_shared_index(const char *shared_index_path)
>  {
>  	struct stat st;
> -	unsigned long expiration;
> +	time_t expiration;
> +	timestamp_t t = get_shared_index_expire_date();
>  
> -	/* Check timestamp */
> -	expiration = get_shared_index_expire_date();
> -	if (!expiration)
> +	if (!t || date_overflows(t))
>  		return 0;
> +	expiration = t;
>  	if (stat(shared_index_path, &st))
>  		return error_errno(_("could not stat '%s'"), shared_index_path);
>  	if (st.st_mtime > expiration)
> -- 
> 2.19.1.856.g8858448bb
> 
> 
--8323328-351835352-1542098992=:39--
