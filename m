Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003001F462
	for <e@80x24.org>; Sun, 26 May 2019 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfEZVeC (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 May 2019 17:34:02 -0400
Received: from mout.web.de ([212.227.17.11]:52337 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfEZVeC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 May 2019 17:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558906418;
        bh=zRZNcGOZ6wQj36V/MgBgtpPqF9RGjXshHnAJJa4GLiI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nrmxoZFBtL/byNdHtmijZZuW1Erp07gySC5X01CpYSXI2CfFXNnK/nUQkZcn2pkEc
         giIt3E/dyQZXVKRNSWH2zzZs5HhFvrrWCChNm7fn+/Oee6sSYsirRKB4Ou3agR9MaN
         Uf0WD+XdPLwIwlCL3HzdDTAqr3M/uQzP/WG2HRjY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.20.65]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8R26-1giHpY04W2-00vycQ; Sun, 26
 May 2019 23:33:38 +0200
Subject: Re: git archive generates tar with malformed pax extended attribute
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <877eaefdkt.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2b52ca7b-bb72-193a-9d6b-83003ce49424@web.de>
Date:   Sun, 26 May 2019 23:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877eaefdkt.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GcvWVNWfwcZjWxf8oOZCu9fWFpuNjHBYIDzKlWAlqEQAHbx9NH1
 kuLNb58+CNUelPrcCWnQQ+h9fNZeGH5Ud0oLgtttyiYpE1RWky3m+TZWSELlwsIJzRjG7Wj
 0d/Jo4A1eLhxN7BZa7MXCjBkkMSUeJNLW+INIPn7A+gMbKpQPvFmQ2rjg7eitI8IzM6CVUp
 rclRpHpCqU3J8m/s9RDiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:92JclFD5w70=:/FhPeJoLOERtLBFUorNDl4
 01OD6i/2Qp5Neyu8CoZAoB79PBU7dWdYlhicG79aMORbkIf6OIGUTYuy8QM+B9ZjOfIMK97/T
 FhHLvkbUcxybr8ntTE5UOY2ORXI+ADP195ZxHkOOmu8s5bvCJpngvAHKbag7F5MryHqlO8s1H
 UV+gMfxxRG1BLMfUwZo3xJ2Gi1Bvmh4RgzqAvSfmKldD253544HEKr7p0/vyxhx4WYw6L/Xhb
 v9Rq+XmIO+FlUh1s4VNir15BdkFzMyPkOBVFOVASqiDIltYwYEXu6uCSMRi6dKXFAn0dEH3a4
 /4Sr2t85FQnujGavIAl/uLFC1kzNLpnaeidqVe6BTPmY6b8u/OLY07wnr7XbDYQj600QDewW1
 /SBPynWTtB2cnX53itAiMyCa/ve04CeVf6DVrQRbszR9RnSCWjpBzkrfgVF1dvGa2uaoHlOZv
 79JyB098H2Fv+rCHZKBI0/lVr1CyoIqFzkxS9hQu56fnX6eRfGlaCUIQQoVIuQNY1RvUevGzF
 yA601e+W/F5gNAriFXz85bpj+oWXBAUNjp7aezUaMpzUGpbAxZCkjueUmXbrMnVgABPnYHjd8
 esF8N5AdkO9iK1x0soZL6oIRNhlK0kYiLgR9+67uTk2x9uDwrTlPO1e4MG8nKXPddT8l2pQFm
 m3Hdu4+WdXQqiTJGW75pYctitRH42XZzLhIy1q2/6wYvaqw2x/REbkne5/eBiH4sxtNgXgH2H
 xglv8lDrgFXao619w5ZhcuddUZutZi2LRVhzLt1HWTCbvHcH3rPjVrv7hO/iS2HAc+/UrZpM1
 Hj1EgyYyz19GTB0EzmQjou6r+xbH4s4ff8DpOcrmo9ucdLOPkvB62hAeQkmjQ1codYgt0YmDa
 SYEV/IbrL4bSpQGLcMugeZNSxpqD63XIN1eU4Mgj7R+zwu/5mamC8rFxxXkm5dnJukpBbZBrv
 rVnHOLv4KIBE5DUeHxx4dqP/WEIDlU0c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.05.19 um 23:07 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sat, May 25 2019, Ren=C3=A9 Scharfe wrote:
>
>> We could truncate symlink targets at the first NUL as well in git
>> archive -- but that would be a bit sad, as the archive formats allow
>> storing the "real" target from the repo, with NUL and all.

> But that being said, this assumption that data in a tar archive will get
> written to a FS of some sort isn't true. There's plenty of consumers of
> the format that read it in-memory and stream its contents out to
> something else entirely, e.g. taking "git archive --remote" output,
> parsing it with e.g. [1] and throwing some/all of the content into a
> database.
>
> 1. https://metacpan.org/pod/Archive::Tar

Git archive writes link targets that are 100 characters long or less
into the appropriate field in the plain tar header.  It copies
everything, including NULs, but unlike a PAX extended header that field
lacks a length indicator, so extractors basically have to treat it as
NUL-terminated.

If we want to preserve NUL in short link targets as well, we'd have to
put such names into an PAX extended header..

=2D--
 archive-tar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 3e53aac1e6..e8f55578d1 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -291,7 +291,8 @@ static int write_tar_entry(struct archiver_args *args,
 	}

 	if (S_ISLNK(mode)) {
-		if (size > sizeof(header.linkname)) {
+		if (size > sizeof(header.linkname) ||
+		    memchr(buffer, '\0', size)) {
 			xsnprintf(header.linkname, sizeof(header.linkname),
 				  "see %s.paxheader", oid_to_hex(oid));
 			strbuf_append_ext_header(&ext_header, "linkpath",
=2D-
2.21.0
