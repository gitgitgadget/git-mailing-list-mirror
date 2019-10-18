Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE041F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 14:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633984AbfJRO2f (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 10:28:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33492 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408333AbfJRO2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 10:28:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IEOWn7121353;
        Fri, 18 Oct 2019 14:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=axWvDAH/P7f+8j/F6y60EiB/F+Jv9iequegesHcM0SY=;
 b=XiELLiO4jj3tt4zkNyh4WA0OYkL6A/ViceQ1aCOjsyWWIFXBW+p2FALof1QzpA5/CEO/
 OKTSjXkHHy7KQBLVI4I2Ik2dDaPbUTbq21oOIvRmfkPMdjt1iVWuXX3+Z3bXFBwG9Lv7
 +o4PRKT/+SudBBbAbpR6DGCOxegb3y8JIRVMb9AJ8snZWFsjz+iHZ0gzoOcTtDZFFGbn
 x7LIVj+2QWDBuqW74aiUQ7dNgOVSEa/pirLBE/yMp4I1vs3iqiceHzDoUKqH4eXInwzs
 qgmKQqhexxJhl4Cdj6APT/kk/sUbriho23422z1Y53VGj7gFl7j/+6KrtJEf9EwMqUPf 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vq0q449q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 14:28:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9IES2Pu054077;
        Fri, 18 Oct 2019 14:28:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vq0dxqb2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 14:28:00 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9IERsE1031768;
        Fri, 18 Oct 2019 14:27:54 GMT
Received: from [10.175.21.59] (/10.175.21.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 14:27:54 +0000
Subject: Re: email as a bona fide git transport
To:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
Date:   Fri, 18 Oct 2019 16:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9414 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180135
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 10/16/19 4:45 PM, Santiago Torres Arias wrote:
> Hi Willy, Vegard.
> 
> On Wed, Oct 16, 2019 at 01:10:09PM +0200, Willy Tarreau wrote:
>> Hi Vegard,
>>
>> On Wed, Oct 16, 2019 at 12:22:54PM +0200, Vegard Nossum wrote:
>>> (cross-posted to git, LKML, and the kernel workflows mailing lists.)
>>>
>>> Hi all,
>>>
>>> I've been following Konstantin Ryabitsev's quest for better development
>>> and communication tools for the kernel [1][2][3], and I would like to
>>> propose a relatively straightforward idea which I think could bring a
>>> lot to the table.
>>>
>>> Step 1:
>>>
>>> * git send-email needs to include parent SHA1s and generally all the
>>>    information needed to perfectly recreate the commit when applied so
>>>    that all the SHA1s remain the same
>>>
>>> * git am (or an alternative command) needs to recreate the commit
>>>    perfectly when applied, including applying it to the correct parent
>>>
>>> Having these two will allow a perfect mapping between email and git;
>>> essentially email just becomes a transport for git. There are a lot of
>>> advantages to this, particularly that you have a stable way to refer to
>>> a patch or commit (despite it appearing on a mailing list), and there
>>> is no need for "changeset IDs" or whatever, since you can just use the
>>> git SHA1 which is unique, unambiguous, and stable.
> 
> I wonder if it'd be also possible to then embed gpg signatures over
> send-mail payloads so as they can be transparently transferred to the
> commit.
> 
> -Santiago
> 

I just played a bit with this and with my proposed patch for
git-format-patch the signature is already part of the output:

$ ./git-format-patch --complete HEAD^-
0001-format-patch-add-complete.patch

$ cat 0001-format-patch-add-complete.patch
 From ac30b08065cd55362a7244a3bbc8df3563cefaaa Mon Sep 17 00:00:00 2001
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Sat, 5 Oct 2019 16:15:59 +0200
Subject: [PATCH] format-patch: add --complete

Include the raw commit data between the changelog and the diffstat.
This will allow 'git am' to reconstruct the commit exactly to the point
where the sha1 will be the same.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
commit ac30b08065cd55362a7244a3bbc8df3563cefaaa
tree 8f09d9d6ed78f8617b2fe54fe9712990ba808546
parent 108b97dc372828f0e72e56bbb40cae8e1e83ece6
author Vegard Nossum <vegard.nossum@oracle.com> 1570284959 +0200
committer Vegard Nossum <vegard.nossum@oracle.com> 1571408340 +0200
gpgsig -----BEGIN PGP SIGNATURE-----
  Version: GnuPG v1

  iQIcBAABAgAGBQJdqcnVAAoJEAvO9Nj+mLpYPEMP/0qyUF6U9y6FMM3BQrjteGGY
  IEEwmkvfW8vMBdjXRjmSI1jxRUuW+xJs3kxezNuW79Gzkl63PlS3CdW50yLlWau6
  2gU4R8oSNr7vxpgfAscELxaAuvUSp7Vb1FEPc5kPW06Sprg4PkLkUMD71ALRnGMV
  TxTVMDbMYg2xHpwBFs1ZyF2l0ElqOvRqoQqYfvRql1rgbs5LhF0RevkIN5xswj93
  3Gz1CuB8MURX2lfglfYSTy/05Rx3w/QHxwNlbbPDtXrexySf+a70j/Z6i2/BIzR/
  kxlZJ/k4ZPN931mxFcLPBsV/K51uP378oEH1QdaZyO2jz1rj+AZxXlgXe8J3ZAmt
  XYT/FMze5lukd7EQDO5vPZazp1dnJ6wnmrAd8shCSWe23vybDMCYnjXTuwAXwbA5
  R7ffKxm3MwRn9LKsbHFiV0J8tS1/fHbOIEXQDJ+kFhKqys0RSXipDZU61LnogXaw
  827TcsUYLvkYlQ+LdmSjZ537E+bUTo3Udb/UkGbgwSSm9LTjHnAI34S6dxSZ+1cl
  jBD54v8u9I1hEImWxGbXns7ET1fh17Z4PoTPpA4COt3puAQY7vB7inGY3/kWz+7z
  iRieHyD/W6lba4rqNYHBxacD4JTXN9S9Z7o6F4ijeGQThbA77RWD64SGjuJM0mC7
  mGUqvHz0pn7zOl1ZOS26
  =gCT0
  -----END PGP SIGNATURE-----

---
  builtin/log.c | 12 ++++++++++++
  log-tree.c    | 17 +++++++++++++++++
  revision.h    |  3 ++-
  3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index c4b35fdaf9..81c1164ae5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1545,6 +1545,7 @@ int cmd_format_patch(int argc, const char **argv, 
const char *prefix)
[...]

There is no corresponding support in 'git am' yet, however.

Seeing how large this signature is, I have to admit that I am partial to
Konstantin's suggestion of using minisign. This seems like something
that could be added to git as an alternative to gpg without too much
trouble, I think.


Vegard
