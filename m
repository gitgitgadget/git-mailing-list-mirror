Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE576ECAAD8
	for <git@archiver.kernel.org>; Wed, 14 Sep 2022 07:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiINHlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Sep 2022 03:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiINHlM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2022 03:41:12 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB672B54
        for <git@vger.kernel.org>; Wed, 14 Sep 2022 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1663141255;
        bh=l/FS2uXYhMI/LmdtP96rNUv9pG/Kd7g97CRYoHSdNrU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
        b=IVlxqkmO11m4BZSnH1KUw7HsRWBSYS0RaMRjEqGEoeXc/6o3DaXTJ8GM5mWi7C5zt
         qI9v5jnn1wwa20cgfKTfRsznKX32+5bqWIGy9sOECOZzoD+O96tiidVaBlm1N26LMH
         piDZp7L9wo7dDORQ9ZGU6o2JdrpuXmflMPKuS12s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MG9DE-1oXKIN2wcm-00GnP4; Wed, 14
 Sep 2022 09:40:55 +0200
Message-ID: <854127f2-55aa-5636-813d-d91b8a4cdcbc@web.de>
Date:   Wed, 14 Sep 2022 09:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: Wildcards in mailmap to hide transgender people's deadnames
Content-Language: en-US
To:     "Florine W. Dekker" <florine@fwdekker.com>, git@vger.kernel.org
References: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <2e846a72-a4c6-2a5a-255a-15eee037f574@fwdekker.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJ0uamQpVoNyLWunj8H/Ytib31+gVl66xtzn+EGfAqTuIfsPBYo
 p2/j01Rsb1wRry1+UAy3p+E9dStG2GV/lP9j2geLgGRtWIlHsWv+jcM7/Rrq1xycYpD/NPj
 UyZ+IhtpHbJjPRB05CyBjP+pzKqVsL2f/jwG9tpfNQCDs6OLB84jgT6l56qhaaVti0DDfhS
 c5E1Wh20Sy9o5H5uKx0qQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HsMmr+Zfb5k=:L1WfvOT7LJaxBrvW0rfq2j
 Oqrhy+lNI13VEzE/E9s5iZs1QdLKtyzqhqrv+yPEIPKTJrpQ6XTCOo5xWWR7ll9GreeSH6Ivt
 CNb1SLbFRo9Ksc/SpFCYK3TvZ+U8ruQzNCqTu0UrjwjO+YHnxMZ5h75qIqSGuRRHP5jgpkqml
 v2J23O+7w0RaIpiZVp4y95l8CaAOA86wiKrCzVWDAtA2i69v4KzXwKpxehsOy3wNEf9eazAVG
 wGg6KvaP0H59ZbNiQpP3NadtkxFBW+Izzk2o9yfTLhKZxobyjsS1vJXVv2E6qe0BplI+VWUII
 mq3uGQB31pMpbMVMSMbbRNpfDFO8m8dybHwA8UHWY/YxysSqdpPjp+HDIgcXIN52UksRVF2Ja
 lXw1CGpsn0Q5JeJgsYjDvWUCMjcaDV0gUlvEw8JaGuxA6G53eBBlI+SackzFUHjHXEVCuaTQ5
 IpU2Ze2vbk0dhvK2WkcewqoVO6g1ZZca2EeXGtlvLnEKlvYuVn4ylyk5BlDYxnaZyL1q1ZAoj
 z/W0Yw9mIN+iidbUsevpMGrInuOj3FLJM1XgExt6moDcHDbzjj6A9vitgCv0YzisV4pyxRcKX
 39nrMlKlAKqjW06Yn09B+aE6XA7XnNxMmqngBYx5HqDo3OnGzDd5smn7nBRoLHBGsqGd/xcG/
 lTq9raQ3foCdeKa+lkZK0ctbc2ThkOSgjiVvgHYWyuRQysmWzZgA877ic4RJvGuXTbVVrxgU9
 IAG/4z8gVJ69Wq4wei/VGsy0nEwxa+UcpnagwEENdkSRXoC6BmvDKDD6BxxWv1sh+P7SwQ74J
 LHzJp2/3S2XA3QRn5i7VU6lKvq66jr0U/wGQRCIROrkeo2OVnWmPfDVV083zLTns1v0xUPlw9
 V7RlDcaayQd9zghu5L8UjtH8lcpRGJe70QXzgAf3GncvnacOmMpqqyOGBaWO5oKNIRoweNPFh
 Y/3JdbqZsX0nPRi0YdVFE+sLI46iidDaeTSxBoWfb6+Y9HgJ9t8+1A+HwnrrLhIaRwnc4g5qJ
 +PYcaxRfC/RQGeyIQYHYkscveJG1Ysqrlp2TyJc84fJvB95EX9qzs6g0F6qZJyjV1bWA5J31X
 FTo48rJ8qv8eX+C8LtUYcpBiJ3dYyRDkBuRJUbI+nbrXFI/fANHBH8hMSCMLRGvmY1LFrl1vo
 9y3nE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.09.22 um 23:53 schrieb Florine W. Dekker:
> Now, John can now add the following line to their mailmap config:
> `John Doe <john.doe@example.com> <\*.doe@example.com>`, which does
> not reveal their old name.

That would falsely attribute the work of possible future developers
ann.doe@example.com and bob.doe@example.com to John as well.

Supporting hashed entries would allow for a more targeted obfuscation.
That was discussed a while ago:
https://lore.kernel.org/git/20210103211849.2691287-1-sandals@crustytoothpa=
ste.net/

> Someone could always spend more effort to uncover the name using more
> advanced tools, but the point of this feature is to prevent
> accidental discovery of the name in cases where completely hiding the
> name is not feasible.

Extracting old email addresses from a repository is easy by comparing
authors' email addresses without and with mailmap applied, no advanced
tools required.  Here's mine from Git's own repo:

   $ git log --format=3D'%ae %aE' |
     awk '$1 !=3D $2 && !a[$0] {a[$0] =3D 1; print}' |
     grep -F l.s.r@web.de
   rene.scharfe@lsrfire.ath.cx l.s.r@web.de

The same can be done with names (%an/%aN).

Ren=C3=A9

