Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 330E920401
	for <e@80x24.org>; Tue, 27 Jun 2017 20:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbdF0UfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 16:35:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35468 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753453AbdF0Uex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 16:34:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id 131so7872135wmq.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1RkjzhGCZFo+cuktTdojwIvFKG1XWQO30WACqbLEW90=;
        b=JFyMrCl7IG0vWKsQbhtfxMnkuEUbTJBwtm1ohRvHjAwArZoF65NCiiHseC90PhLQst
         yBflV1CZQx67OZUNlOl2tR65YKoYVwc7bRXUKNPcSR5mPyvuo84cubhzwQgSfXzXSGvp
         zGxG15PwneuRTusGs3Fmzl7xw/GU5LS6meqMP7h3pSvyJgdsZoI2ZmLD7+YC5+LGhiWk
         /QQ/smhxUcPIwHqO34N7RVtiC2LssINZLl1jkZi8du5N+EkHsdv2ElXJ3pRwibDOGpC8
         EdUi1YC5zmfnUWNEXSPUmGW5EpJ07dHRePbiEps2nlwbxP8BlxcF/vhdH8gC+DVPq+MX
         wX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1RkjzhGCZFo+cuktTdojwIvFKG1XWQO30WACqbLEW90=;
        b=IsM/qvC9leUssXH55hjWTXXUKoSebYCbserH8CvCmSQO15xGdWKDc8yQoi+F6OeO3y
         9hHb39R/hCwJ8JCd1DLcsmCD/SuSnOkdYk8dUGuTWpTD7676MGSY2uLa/dlTe3H3Pm8T
         oXJ47sA8nuNEKZvFSyHvoAlCRtoop1WmvKX60xSNXYqCKZirOcHm/jmDMWyJTCJVVvSY
         b3DURuqCDOV8mpV+egteYAKvYqESaI33mFanf2y45wj1k7MxQkEU5Uzp0H0SSfCn/uva
         /41C8Q38AeHI2QRPKZaNwCoXn73FFT7o1b3S1lKL9JSaHaQ6Df9WaTau+8nQF1i99ass
         j1ew==
X-Gm-Message-State: AKS2vOxV5pqDcuvr9su45T5upFPAm4m/lRnxB0KxCxuBjE2kfivvqiw5
        ecA1y9x3+g3nrQ==
X-Received: by 10.28.0.78 with SMTP id 75mr1536576wma.58.1498595692078;
        Tue, 27 Jun 2017 13:34:52 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4DFA.dip0.t-ipconnect.de. [93.219.77.250])
        by smtp.gmail.com with ESMTPSA id i22sm224001wrb.30.2017.06.27.13.34.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 13:34:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 6/6] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 22:34:50 +0200
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <77DBCB49-2A44-42BB-9060-23FA79C1CF57@gmail.com>
References: <20170627121027.99209-1-larsxschneider@gmail.com> <20170627121027.99209-7-larsxschneider@gmail.com> <xmqqbmp91cjk.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Jun 2017, at 21:00, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>> 	if (err)
>> 		goto done;
>>=20
>> -	err =3D packet_writel(process->in, "capability=3Dclean", =
"capability=3Dsmudge", NULL);
>> +	err =3D packet_writel(process->in,
>> +		"capability=3Dclean", "capability=3Dsmudge", =
"capability=3Ddelay", NULL);
>>=20
>> 	for (;;) {
>> 		cap_buf =3D packet_read_line(process->out, NULL);
>> @@ -549,6 +551,8 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>> 			entry->supported_capabilities |=3D CAP_CLEAN;
>> 		} else if (!strcmp(cap_name, "smudge")) {
>> 			entry->supported_capabilities |=3D CAP_SMUDGE;
>> +		} else if (!strcmp(cap_name, "delay")) {
>> +			entry->supported_capabilities |=3D CAP_DELAY;
>> 		} else {
>> 			warning(
>> 				"external filter '%s' requested =
unsupported filter capability '%s'",
>=20
> I thought you said something about attempting to make this more
> table-driven; did the attempt produce a better result?  Just being
> curious.

I treated that as low-prio as I got the impression that you are =
generally OK with
the current implementation. I promise to send a patch with this change.=20=

Either as part of this series or as a follow up patch.


> ...
>=20
>> +struct delayed_checkout {
>> +	/* State of the currently processed cache entry. If the state is
>> +	 * CE_CAN_DELAY, then the filter can change the 'is_delayed' =
flag
>> +	 * to signal that the current cache entry was delayed. If the =
state is
>> +	 * CE_RETRY, then this signals the filter that the cache entry =
was
>> +	 * requested before.
>> +	 */
>=20
>        /*
>         * Our multi-line comment look like this; slash-aster=20
>         * and aster-slash that opens and closes the block are
>         * on their own lines.
>         */

Oops. Lesson learned.


>> +	enum ce_delay_state state;
>> +	int is_delayed;
>=20
> Hmph, I do not terribly mind but is this thing really needed?
>=20
> Wouldn't filters and paths being non-empty be a good enough sign
> that the backend said "ok, I am allowed to give a delayed response
> so I acknowledge this path but would not give a result right away"?

Yes. I guess that was a premature optimization on my end.
This is how "write_entry()" in entry.c would change:

-                               dco->is_delayed =3D 0;
                                ret =3D async_convert_to_working_tree(
                                        ce->name, new, size, &buf, dco);
-                               if (ret && dco->is_delayed) {
+                               if (ret && =
string_list_has_string(&dco->paths, ce->name)) {
                                        free(new);
                                        goto finish;
                                }

OK?


>> +int finish_delayed_checkout(struct checkout *state)
>> +{
>> +	int errs =3D 0;
>> +	struct string_list_item *filter, *path;
>> +	struct delayed_checkout *dco =3D state->delayed_checkout;
>> +
>> +	if (!state->delayed_checkout)
>> +		return errs;
>> +
>> +	dco->state =3D CE_RETRY;
>> +	while (dco->filters.nr > 0) {
>> +		for_each_string_list_item(filter, &dco->filters) {
>> +			struct string_list available_paths =3D =
STRING_LIST_INIT_NODUP;
>> +
>> +			if (!async_query_available_blobs(filter->string, =
&available_paths)) {
>> +				/* Filter reported an error */
>> +				errs =3D 1;
>> +				filter->string =3D "";
>> +				continue;
>> +			}
>> +			if (available_paths.nr <=3D 0) {
>> +				/* Filter responded with no entries. =
That means
>> +				 * the filter is done and we can remove =
the
>> +				 * filter from the list (see
>> +				 * "string_list_remove_empty_items" call =
below).
>> +				 */
>> +				filter->string =3D "";
>> +				continue;
>> +			}
>> +
>> +			/* In dco->paths we store a list of all delayed =
paths.
>> +			 * The filter just send us a list of available =
paths.
>> +			 * Remove them from the list.
>> +			 */
>> +			filter_string_list(&dco->paths, 0,
>> +				&remove_available_paths, =
&available_paths);
>> +
>> +			for_each_string_list_item(path, =
&available_paths) {
>> +				struct cache_entry* ce;
>> +
>> +				if (!path->util) {
>> +					error("external filter '%s' =
signaled that '%s' "
>> +					      "is now available although =
it has not been "
>> +					      "delayed earlier",
>> +					      filter->string, =
path->string);
>> +					errs |=3D 1;
>> +
>> +					/* Do not ask the filter for =
available blobs,
>> +					 * again, as the filter is =
likely buggy.
>> +					 */
>> +					filter->string =3D "";
>> +					continue;
>> +				}
>> +				ce =3D index_file_exists(state->istate, =
path->string,
>> +						       =
strlen(path->string), 0);
>> +				assert(dco->state =3D=3D CE_RETRY);
>=20
> Can anything futz with dco->state at this late in the game?  You
> entered into CE_RETRY state at the beginning of this function, and
> this loop is going through each delayed ones. At this point, you are
> going to make , but not yet have made, a request to the backend via
> another call to checkout_entry() again.
>=20
> Just wondering what kind of programming errors you are protecting
> yourself against.  I briefly wondered perhaps you are afraid of a
> bug in checkout_entry() that may flip the state back, but it that
> is the case then the assert() would be after checkout_entry().

At this point I want to ensure that checkout_entry() is called
with the CE_RETRY state. Because checkout_entry() needs to pass=20
that flag to the convert machinery.

This assert was useful when checkout_entry() changed dco->state
between CAN_DELAY and DELAYED. In the current implementation the
state should not be changed anymore.

Would you prefer if I remove it? (with or without is both fine with me)


Thanks,
Lars=
