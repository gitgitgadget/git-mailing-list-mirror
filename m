Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9B820958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbdCWSTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:19:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34637 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933773AbdCWSTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:19:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so817330wmg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8luw/xr9zSROQZ+adkFZ3arFayJkZoeCMqd0/d0aIsI=;
        b=eSpowuoqHSyEOcAVEIJW0/CONBZyfVRvoYlp4LZ8jYoY/aC2mxHHwRbi6L0gt6MCbt
         VeYJAsuE//8W59crHuTiRBnfyN1EplrdKbUYbfJjqXCB6AweXHGA3gBKaOrpDalAmbZm
         drDR/THcKqxyZ/2svpxtYiuN9va+ZBr6VwQ5ty3OhJ5B5jZo7KEkQnJTO0kddkRH95ld
         T1Kk5xFlPtubhoRRTXXTPZv0A0y5UDJOIAZo8JrKwpWvfeWMct0RY21O3CRMne3yLVYq
         18X+80F7U977tldkzu/d36qsn+vxlEFu12CsowMWAwK1F1/0NPH6PtFsm6dWWX3Arwrb
         ggcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8luw/xr9zSROQZ+adkFZ3arFayJkZoeCMqd0/d0aIsI=;
        b=gLkFYCinp7frGg3ZQFB/ayUfDdhRgd+SagDuqiQeFZN7QcN5GiGYdOGVS6kVk0vKJt
         fpmu7a5Srrhq2x6XIgGmpOPgYba1D8MxEypVI+QxT3fSofXglmRkmNTcLWDCMz+O9VmX
         78f8gu3hcwU9uNxYge7OXSmrt5JQZaMhkPfsazYx8X9x2OOmOgj3WA2Zp8w0oxJgSyUM
         WtnrDl7XAh2XK9Sspcf4RF0xiwmnpTU6ir4IAYeeWY3cKnXAQmF3Ce3KsC1NXsAFmBQP
         ZOQbymp0q5mgi+1lSkYxdhvhnDy0WQa0YoGZIQBVY+NuwKnw1YGca/NDp+6gGDm/fIIW
         WuKw==
X-Gm-Message-State: AFeK/H2D7lc0YNpObt6YtbgpavgE/Q6QgLJa7SpHRAgfOx8SgyFOV85Ar+ORYgWylU4Atw==
X-Received: by 10.28.31.139 with SMTP id f133mr14520118wmf.25.1490293155536;
        Thu, 23 Mar 2017 11:19:15 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 81sm5310650wmj.9.2017.03.23.11.19.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 11:19:14 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: build and test Git on Windows
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1703221641070.3767@virtualbox>
Date:   Thu, 23 Mar 2017 19:19:14 +0100
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <281F3580-6FC4-40C2-95A6-D8AD2CCF2E54@gmail.com>
References: <20170322065612.18797-1-larsxschneider@gmail.com> <alpine.DEB.2.20.1703221641070.3767@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Mar 2017, at 16:49, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Lars,
>=20
> On Wed, 22 Mar 2017, Lars Schneider wrote:
...
>> +
>> +gfwci () {
>> +	curl \
>> +		-H "Authentication: Bearer $TOKEN" \
>> +		--silent --retry 5 \
>> +		=
"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" |
>> +	sed "$(printf '1s/^\xef\xbb\xbf//')"  # Remove the Byte Order =
Mark
>> +}
>> +
>> +# Trigger build job
>> +BUILD_ID=3D$(gfwci =
"action=3Dtrigger&branch=3D$BRANCH&commit=3D$COMMIT&skipTests=3Dfalse")
>> +
>> +# Check if the $BUILD_ID contains a number
>> +case $BUILD_ID in
>> +	''|*[!0-9]*) echo $BUILD_ID && exit 1
>=20
> Error messages are delivered that way, and they do not start with =
digits,
> true. But maybe there is an exit status to indicate to Travis that we
> cannot decide whether the build failed or succeeded in that case? The =
most
> common cause for an error here is that the VM I use for testing is =
down
> (which happens every once in a while to save on resources, and I have =
to
> manually restart it)...

Curl can return the HTTP code... I'll try to find a way to check for =
this.

>=20
>> +echo "Visual Studio Team Services Build #${BUILD_ID}"
>=20
> Nice plug, thanks! ;-)
>=20
>> +# Wait until build job finished
>> +STATUS=3D
>> +RESULT=3D
>> +while true
>> +do
>> +	LAST_STATUS=3D$STATUS
>> +	STATUS=3D$(gfwci "action=3Dstatus&buildId=3D$BUILD_ID")
>> +	[ "$STATUS" =3D=3D "$LAST_STATUS" ] || printf "\nStatus: $STATUS =
"
>> +	printf "."
>> +
>> +	case $STATUS in
>> +		inProgress|postponed|notStarted) sleep 10                =
      ;; # continue
>> +		         "completed: succeeded") RESULT=3D"success";     =
   break;; # success
>> +		                              *) echo "Unknown: =
$STATUS"; break;; # failure
>=20
> Well, there are more values for the status, and we know them, but we =
do
> not handle them. Maybe "Unhandled status:"?

Sure! I'll fix that in v2 :-)

- Lars=
