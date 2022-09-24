Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEA7C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIXNTf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiIXNTd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 09:19:33 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AD2F3AB
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 06:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664025553; bh=khoKaZ9dKL2m/7Q5wenBUtoMs/aMGehI/5cRvLIODms=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=C+6A2eIG4K0mXu/c+v3z+OE9wImguQv229nNmS6xX8oJDGWBzNRxQiqCzdLpMlA9J
         WziIb+UCP57SOMNBafb1C2oxmsQ2T1NnISskqHu3VFDvySskPXMcruENgr/HPSiQy5
         70NUL/dDWrOKeOA2kvdgW0RZXDhC/TqphkcPfcbal32vzfbCJ0seCHQ9m7HH0ZqNY3
         LLgY8SE2N0eb2qXJGgpQAmj/fkS6exMRt8zu/E8fKlJ75nkW1Zli1rX+ZK/O7zU31u
         D7+yRLZlfxwXkA93WinSM9w+U5b35Fe7W15P2fZWW23p7RVQKibY/HmY/I61F4sv3v
         BN3+QXYSP2KIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.1]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1pPnP31sb6-00uZun; Sat, 24
 Sep 2022 15:19:13 +0200
Message-ID: <712ffe78-c3e3-dacf-c3e3-f339385e9bb4@web.de>
Date:   Sat, 24 Sep 2022 15:19:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: git --archive
Content-Language: en-US
To:     "Scheffenegger, Richard" <Richard.Scheffenegger@netapp.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <PH0PR06MB763962EB6321F85803C5CE2D864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <xmqqleqbxj4h.fsf@gitster.g>
 <PH0PR06MB7639720FB3A1611F4C96E52C864E9@PH0PR06MB7639.namprd06.prod.outlook.com>
 <Yy0ChPPqZUwVFyAt@tapette.crustytoothpaste.net> <xmqqedw2vysc.fsf@gitster.g>
 <8eb5131e-5ae1-79bd-df0c-bf0b2ec8583f@web.de>
 <PH0PR06MB7639DAA5CA112495E3EB43AB86509@PH0PR06MB7639.namprd06.prod.outlook.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <PH0PR06MB7639DAA5CA112495E3EB43AB86509@PH0PR06MB7639.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zPjh/eGT9L9kMtgoCwhmrcNxZzV+c3B7NaYEMdtyjgqnIn2xgYd
 TKdRgcVDcN7NHJLOVY8o/An/5yJpq8uDeW7HM70TQrG2O7Jr42ghr/18vl2XLoB9KEfspDK
 6quyJHL0Ehp1SIcFmpHhWfj17+RRAv4fFafqoqhFAWhAGJfwmnLXnqoxtMruGq3KlMcEfh4
 4qsuh4cG0FlPccNLtxpsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QeLhiRGDRso=:gEM7lotIcVmHxZPV2aUnoB
 RPODeNZoZ6meFkCXboRVmVBTvZjC+2qdQxky/DGmJ9ebFh531Tx6wrBb2WV39aJEUXi7KieZJ
 p3SCk1qBbD5OM0xSqJdG4Sz5MNUO7UFTFbobiDh88CbznQWhCbs5BEGoW3JyYs44tcRMuDfh6
 qHkzR9go/gcHRKRldgMzEj1Rc1slAmkFIibDondJ8YvD4BHQ3H/M2mbCFV1tnJLXf3cbJiloB
 3oqHjlkzukBv2Pksc5DThrqUfAGzwe7Nn9Z2jVSqvLhDHW41DAAWl1IqU8CgFA8Mr1Sphp6tX
 WXotbG9htiECOCpMcNsGOSbRc6kfP3uJSdlOutE4/LZK5ot/YOrNfTK9be/mdZ03j8/EvtLR4
 AOPTVgtOIzyV6z59yG1OWBx1F/FBNmXDnxBRsFK0a9b/jVNuvCmdrL3LrvK8KR9zJmM3UyEJ9
 UZmP34XNnVsWeXUnH7bjSPcy1itDY3jazDB5MlJYNtfKN+gJHt1cOzPpGrQvFqgNIvtP0rexn
 gsvtaep6MXdVH/pNGojT4M3sscdJg6NMefDNfQKI8uPiT6Qrmfi3VU/FtJ8xGtna09N3eHr/L
 NO19IEN//ahukdWcHnZ99bI9gOAuwTJb/u4nefucnFfyIZjt+++KFt2W3wKEgcUtXmyZpV24X
 kQpecpo+P1MzU8oh5x/WvjVVUkuJKEUk+hbW1VgECWgEu4YWvYEX5VkUq3cBTEb/TMm2+p2RC
 etax2C4S5n2FqopL3eP/tbvNARVEZivW3MW22jDDhQDggMaZc0ajsno/OFqHy661qGNaU4Hm9
 08Fx/+p6v5nXIn9p3nBQ/qZBGwzd34kQSnkOPsZXZ1bovZfEDK/xaIblWy3BRDhK+iS0cDyEy
 63CxGUlqRvqMTQdqfOqZ6XCFQ8T67KScNAe+6nbr9M5nFazxTyFF9CmcJcz4m4sru68EisSXU
 uehpgWx8IcEGD1ENMa9op5/exUElsDmNis/9TGGIKVsY2crLbID8Agq1Lcb/QVtloOfZ7+AQB
 6f8zBUw8aUiBVhqdMN7NiZ6yaWlpym4aRUCMAHjYQNQY8CScLlH1S0dDCqNPwuYGPouKi6zfK
 9+Ucu9vSjk7eyhS8FhtMzTv0xPsgZR7KupkinKxXWCMbe+JBWOzHWJeLwbYxbB/seBMnrYNEl
 efuzM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.22 um 13:34 schrieb Scheffenegger, Richard:
>
>> If I/O latency instead of CPU usage is the limiting factor and
>> prefetching would help then starting git grep or git archive in the
>> background might work.  If the order of visited blobs needs to be
>> randomized then perhaps something like this would be better:
>>
>> git ls-tree -r HEAD | awk '{print $3}' | sort | git cat-file
>> --batch >/dev/null
>
> Isn't the 2nd git, receiving input from stdin, running
> single-threaded?

Yes.

> Maybe
>
> Git ls-tree -r HEAD | awk '{print $3}' | sort | split -d -l 100 -a 4
> - splitted ; for i in $(ls splitted????) ; do "git cat-file --batch >
> /dev/null &"; done; rm -f splitted????
>
> To parallelize the reading of the objects?

Sure, but in a repository with 100000 files you'd end up with 1000
parallel processes, which may be a few too many.  Splitting the list
into similar-sized parts based on a given degree of parallelism is
probably more practical.

It could be done by relying on the randomness of the object IDs and
partitioning by a sub-string.  Or perhaps using pseudo-random numbers
is sufficient:

   git ls-tree -r HEAD |
   awk '{print $3}' |
   sort |
   awk -v pieces=3D8 -v prefix=3Dfile '
      {
         piece =3D int(rand() * pieces)
         filename =3D prefix piece
         print $0 > filename
      }'

So how much does such a warmup help in your case?

>> No idea how to randomize the order of tree object visits.
>
> To heat up data caches, the order of objects visited is not relevant,
> the order or IOs issued to the actual object is relevant.

What's the difference?

NB: When I wrote "tree objects" I meant the type of objects from Git's
object store (made up of packs and loose files) that represent
sub-directories, and with "visit" I meant reading them to traverse the
hierarchy of Git blobs and trees.

Here's an idea after all: Using "git ls-tree" without "-r" and handling
recursing in the prefetch script would allow traversing trees in a
different order and even in parallel.  Not sure how to limit parallelism
to a sane degree.

Ren=C3=A9
