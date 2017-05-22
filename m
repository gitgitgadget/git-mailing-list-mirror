Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F17E32023D
	for <e@80x24.org>; Mon, 22 May 2017 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759410AbdEVUd5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 16:33:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34392 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbdEVUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 16:33:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so35332701wmf.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X5C+ekv0zENT2v66G4k66rUbi5R8v9obn8tb2hZaMWI=;
        b=Z1SCbl0LdDCLZONgy8V5Ggkgdtxn8ts4XRv+b4Nj8y5j2E2xoew02ZfI1n6JDGTrqS
         3f3tS3WnuehNLaLjROGKVMfYlflLV2zDKwwB9oxERVK2zj8TBK9roawinwNTXWAV94sr
         ZYBLtw9k8i429EbJ4if3WjoojMOr1Ek5ihg2vO6uvwEMlzM2HPQ3di/qYClcYjz8/Htk
         DqF8VS+gJEh2UkQa05RAzSU0ffFwLQXrEB0nDMff7M1zOEyaN7Bn142i38OGJ91ZimoH
         ZX7eEHC9B5O3Rz+Ui0gGTMl+qLkibdJy7c71UvgLvqWGUqLrU5sBbgXVTbCosueVWceL
         avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=X5C+ekv0zENT2v66G4k66rUbi5R8v9obn8tb2hZaMWI=;
        b=n5oyU4B5SvFpAF+r8QD5fQCW2JZa++hBNMvNI5IlviPJ3hP5tFCWMndNNi3KWTyXCM
         8yKqV5Wn8zuciHtc+NeFLY5vJc+GlKvPKHFOULltt9zJoRtSNPvTwjuKQ5Z7e8PNlMPH
         OBnzOCtdyNQhZ+M8aoV218rnwYTF5W+E1i/jliRajiOcpt+lwod4T0Mlvi6SMwNzrr7b
         Rirc1G7Ygo/B5ml9rN6tE9nLA2MlbGxaQFkY3cwcW5mkjDAEs1R8c5cAx1vgy/uQRaBu
         4ngola5UOeZTHT1saNFwZ+lS1205HXv4LUbj4XPwkuwUnnMnOz0VjWg25ZZunropBPH9
         0yPA==
X-Gm-Message-State: AODbwcBXOOQxE5zknSujR7DEDL9SvSlFIOjYt1tYYpCLkVtTu6oTTrk6
        aO7LVGoDi2idoA==
X-Received: by 10.28.69.73 with SMTP id s70mr25933370wma.36.1495485235464;
        Mon, 22 May 2017 13:33:55 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB60CD.dip0.t-ipconnect.de. [93.219.96.205])
        by smtp.gmail.com with ESMTPSA id x126sm23385697wme.12.2017.05.22.13.33.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 May 2017 13:33:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <0e2eb0e4-6efd-349e-21be-ae1133a6047b@web.de>
Date:   Mon, 22 May 2017 22:33:52 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, e@80x24.org, ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E2C871B0-DCDF-40C5-A559-C396F3C8AA66@gmail.com>
References: <20170522135001.54506-1-larsxschneider@gmail.com> <20170522135001.54506-5-larsxschneider@gmail.com> <0e2eb0e4-6efd-349e-21be-ae1133a6047b@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 May 2017, at 21:52, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-05-22 15:50, Lars Schneider wrote:
>> +After Git received the pathnames, it will request the corresponding
>> +blobs again. These requests contain a pathname and an empty content
>> +section. The filter is expected to respond with the smudged content
>> +in the usual way as explained above.
>> +------------------------
>> +packet:          git> command=3Dsmudge
>> +packet:          git> pathname=3Dpath/testfile.dat
>> +packet:          git> 0000
>> +packet:          git> 0000  # empty content!
>> +packet:          git< status=3Dsuccess
>> +packet:          git< 0000
>> +packet:          git< SMUDGED_CONTENT
>> +packet:          git< 0000
>> +packet:          git< 0000
>> +------------------------
>=20
> The documentation mentions "0000" 2 times.
> Is this a bug in the docu ? Or a feature which may need a comment ?

The first 0000 marks the end of the content and the second 0000
marks the end of an empty status list.

Explained in the existing protocol here:
=
https://github.com/git/git/blob/10c78a162fa821ee85203165b805ff46be454091/D=
ocumentation/gitattributes.txt#L451-L457
=
https://github.com/git/git/blob/10c78a162fa821ee85203165b805ff46be454091/D=
ocumentation/gitattributes.txt#L464

For clarity I should probably change it to this:

...
packet:          git< status=3Dsuccess
packet:          git< 0000
packet:          git< SMUDGED_CONTENT
packet:          git< 0000
packet:          git< 0000  # empty list, keep "status=3Dsuccess" =
unchanged!

Thanks,
Lars=
