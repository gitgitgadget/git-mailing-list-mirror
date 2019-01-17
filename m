Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 375621F454
	for <e@80x24.org>; Thu, 17 Jan 2019 12:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQM0Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 07:26:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:33242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727241AbfAQM0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 07:26:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A016AE76;
        Thu, 17 Jan 2019 12:26:14 +0000 (UTC)
Subject: Re: Git bomb still present (at least in SUSE)?
To:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <a212bd07-8d3c-da5c-6387-4d70ed8edd65@suse.cz>
 <20190115180031.GA31834@sigill.intra.peff.net>
 <20190116025110.GD8864@google.com>
From:   Marketa Calabkova <mcalabkova@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=mcalabkova@suse.cz; keydata=
 mQENBFuJDK0BCAC7oCihZ+z6LUKGAMlrgytiGpOWS7J/SEejYnSXPQ4fZI65C1jHER04G19C
 l17cirTWKUXvv7I8GDyZfPSvDiU5neOuZCF+8dWuOwQjP6ddrUkTjrimBNTJQ+4p4sF7PQNy
 1EHafttHqqRO4JOfqZl2ux9e+w4iu3Yiy4N9cMNCcSLCWuU3HBl2qllGtPOK7aEEEpwwPK53
 P8Z5IT6DKjnYbxanJrZCowuNH/EBwgW8C6T5Crd4TYNESigOBcOXlRjn/r272TtKJyndF49C
 hvLIMIv/OUf7kaRPu97ZHVPFKQq5f9p3yPWXBE17Cjc8yZAw1Ralzxf6N4mQzFyVLc5VABEB
 AAG0Jk1hcmtldGEgQ2FsYWJrb3ZhIDxtY2FsYWJrb3ZhQHN1c2UuY3o+iQFTBBMBCAA+FiEE
 gfb7Iobbgba+AolQALUzKizvWXYFAluJDK8CGwMFCQHhM4AFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQALUzKizvWXb9jgf46kmHK8mBJTL54AK7PBvqJO1O3l0WQKHI0k6DfPN0j5vs
 GK61wxvdZBMP3obLvoo5txRI1qMHxeviaNVm47Z14ZGPSKl+l0a+mMNZW/sCV5neCWl7auvl
 DvpZDpQoC96EbWgLqDUzK/eofs7uwAbz7dH1F2xiqVi8pbXFQErKubAq540Q2nbXyRc5cjOs
 /oTVnM8gcl7SGCHjTVkw/8emDZg2is8Nw3sQMHeQGWoonLiM7qkdnF8A0rtZ/jroj3LWb9mZ
 sLNXa3E/LcQ3mP81Z+chPa55WbTRnnNFXkAYeAFx7+4UDVstqbpSM01IPHLW3UTnTxMkGfUI
 PUJUtgBBuQENBFuJDK8BCADN/DCjbiiBWRrWo+kv5KeDrxXApq7eBhV0epYs0zDqZCJz1FuT
 viU4aoCqCQXU6go0Za8aJZwMN8RWz/35lyg/hxuziFyaQiw7a+W68dEKSbDaoHr8hpKPnI+6
 lhlwK87hv6zFpu+jGlTaxUMpwPdznq0vjLdkAxgKMasVvQslFn9ThsqY/z3DJqkwpR8aC9EI
 AZXZg5+2YXNUCCVQA88vHybl84LFD3Qgypz9wgnOuMsybyA9PYY5zl+Lz1B6w6UJBANXe6A9
 ebhre/9i7kDFmnGh9mfmmH/15lap9fdefAB9Wtndp0eYCI8pYyRYrtdk688GyLKY/Fv1JtSn
 ZEd/ABEBAAGJATwEGAEIACYWIQSB9vsihtuBtr4CiVAAtTMqLO9ZdgUCW4kMrwIbDAUJAeEz
 gAAKCRAAtTMqLO9ZdkhDB/9ImVmDa89VG47JxfPmsAu70tgYnOonFze7dn5tAEVhSuGrMOB5
 hrkoRcHCjawQmvG7BWkAGoXW2oOl4pp1uRVLOIHXruIKkgEN+nWvCr2Lvxc8Mwmj0B51nL1E
 Qkhu5jjJuIZ4+Kb/4nwxaqYfEDZwbe9QPmidGlkIqwsgEnBqB8L6sKH4XRJ7MTghsXZziZIr
 qq/vC4xBK98vbwLfz6QRcV1hWNbEX7d+7gkIot33LD1HCNaX07ZGPhu0S0T6PueDWiSdZlk6
 DOwOGtPShksjN/3YdmqUA7Wp+JUj1j+QHE6S9RrRUUlabUEuxok7YnA1XPAoDcekzE8n4mpZ lG8B
Message-ID: <e212c318-8158-23b4-5a84-b178c0979c14@suse.cz>
Date:   Thu, 17 Jan 2019 13:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190116025110.GD8864@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ieBfM6ezzB01xEYHTVjuW4zDwDD1lkLod"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ieBfM6ezzB01xEYHTVjuW4zDwDD1lkLod
Content-Type: multipart/mixed; boundary="HQFmfCLPsykYZzmHmU0u48xYwE37gh7w1";
 protected-headers="v1"
From: Marketa Calabkova <mcalabkova@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Message-ID: <e212c318-8158-23b4-5a84-b178c0979c14@suse.cz>
Subject: Re: Git bomb still present (at least in SUSE)?
References: <a212bd07-8d3c-da5c-6387-4d70ed8edd65@suse.cz>
 <20190115180031.GA31834@sigill.intra.peff.net>
 <20190116025110.GD8864@google.com>
In-Reply-To: <20190116025110.GD8864@google.com>

--HQFmfCLPsykYZzmHmU0u48xYwE37gh7w1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hi,

Jonathan Nieder wrote:
> Jeff King wrote:
>> On Tue, Jan 15, 2019 at 02:35:29PM +0100, Marketa Calabkova wrote:
>>> meggy@irbis:/tmp/test> /usr/bin/time git clone
>>> https://github.com/Katee/git-bomb.git
>>> Cloning into 'git-bomb'...
>>> remote: Enumerating objects: 18, done.
>>> remote: Total 18 (delta 0), reused 0 (delta 0), pack-reused 18
>>> Unpacking objects: 100% (18/18), done.
>>> ^Cwarning: Clone succeeded, but checkout failed.
> [...]
>>   git clone --bare https://github.com/Katee/git-bomb.git
>>   cd git-bomb.git
>>   git read-tree HEAD ;# yikes!
>>
>> So I don't think there's a bug per se. It is possible that Git could
>> have better protections against maliciously gigantic repositories, but=
 I
>> don't think anybody is actively working on such a feature (and it woul=
d
>> involve much more than this case; it's pretty easy to generate trees
>> with pessimal diffs, etc).
Thanks for your answer, now I finally understand what the fix is about.
> One thing I think interested people could do is introduce some kind of
> "limits" subsystem into Git, so that a person could configure Git to
> refuse to even try when it notices that an operation is going to be
> sufficiently expensive.  I.e. something similar to what rlimits (or
> other limits e.g. enforced in cgroups) provide in an operating system.
>
> That said, as alluded to in the last paragraph, there's also some
> protection possible at the operating system level.
>
> So my feeling is that there's some real potential for improvement
> here, and I'm happy to help mentor anyone working on it if it is their
> itch (because of the "can handle at another level" thing, it is not
> mine).
Thank you, I am interested. Mostly for educational purpose, I have to say=
,
I would like to contribute on such a big project as git is.

I would be happy if you help me with that. How can git know how big the
repository is before it tries to checkout? Or do you think it is OK to
start the operation, notice it is already too expensive and kill it? And,=

well, how to easily track how expensive the operation is (e. g. not in th=
e
particular operation)?

Greetings,
Marketa


--HQFmfCLPsykYZzmHmU0u48xYwE37gh7w1--

--ieBfM6ezzB01xEYHTVjuW4zDwDD1lkLod
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgfb7Iobbgba+AolQALUzKizvWXYFAlxAdGYACgkQALUzKizv
WXZejwf6Ai4TEOTlMylr6mqTmPSH4hWc25Qi7s/ffssBhRqJTY7zapGntOHU4rzi
1oBVlA9YFHKn8Xu+furECvZ3hYCyJZzTOWVwLno+SLYRMXf51c+piVbd1jdeSaXi
aYaFP88w/5PZGrQC164vTumFLVy2mCen6MrSdamlxvY15ZBmfIfOpDH+UWzXp1WK
cz6HKG2EYaqs440/ynH0/VxAU4NxIk9O1WDd8fWRPNAPmRcrG2MbHmYrI7njKS6D
LebRhA+I8MeO5TdLzGMUtJjyO00hUre2BA6SjTb+EZwRDQKFHb8bDYUFcRtn7X+/
u39UquEbakCNyq/s7MWa2VrmU8WG1Q==
=OPTi
-----END PGP SIGNATURE-----

--ieBfM6ezzB01xEYHTVjuW4zDwDD1lkLod--
