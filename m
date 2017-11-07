Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E199F20A10
	for <e@80x24.org>; Tue,  7 Nov 2017 02:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753424AbdKGCyM (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 21:54:12 -0500
Received: from mout.gmx.net ([212.227.17.22]:51166 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbdKGCyL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 21:54:11 -0500
Received: from bedhanger.strangled.net ([188.192.144.31]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LxPgU-1fIqfu3mYM-016wzq; Tue, 07 Nov 2017 03:53:33 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH 1/3] checkout: describe_detached_head: remove 3dots after committish
Date:   Tue,  7 Nov 2017 03:53:21 +0100
Message-Id: <20171107025321.31028-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
References: <20171105162730.31405-1-bedhanger@gmx.de>
In-Reply-To: <20171105162730.31405-1-bedhanger@gmx.de>
X-Provags-ID: V03:K0:lPajf5wE3Oo+vSBNfzNHHeFiWQIASyDviO6lWG4BQrD8fr8QfLD
 mD+zCHzMufy+RbqfunBGWTKaIiUcKPkPdInmREA4LM+qPz+QK06hyKrI6Jb3dCSK0vGPPN4
 5xqY9XpylrXwn9yYiOJ1FvyOCn1e14IkMFEt8d3plgjj6bv8h5oVyzVrk1Uj/+9RLMYnHET
 MB2Wbh7N76YqMR+UPJ2pQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sAYppOgwMMQ=:gCCSAcpbFNjoh9J7ePgPuH
 6hcHoiahHF3uo5r4TUefi+hYl5OqZQNvWxgHpmILUhUGq8drbClaA6hP2nSExS9vQmLrYOvLh
 PbMwGCsQJV7kVqzJz5p8TJR8utv/zjwO529hzZFgL5O35qlBAmbmN9lofg5ZiTl1hk2g76GRY
 gM+NFm4tgWGjnaJdEymFU5hniyv3iGhO8vV9wnoD4wsuEE1G1c6QecU74IrlfljfVBjCvhdUM
 OROThCV2Jw/OTlcg6zrWeSC0FU7m1+/4PHx4EXj2bA/bguFXXCdRaLJEF0lHacv6veGhEDtr6
 I0lZ1OuC6xP7UmSrs/xmBpIcXkct/SHdr2Xyru/aDkiEC9U0KkWaIqQ41jDZwu1fcLSYLIyw4
 5rtD/0FEToS5ZVPW9lNSI/8vCkFhm71Vqz5WffXemZneIu8dwhqRi+qZdFSb+65vsIUiRp2nB
 PlUmFYVCHmrL2rciLLGn+FBUksaU2nJOCSjcbGpx81sDPNUsplYJbAu33Or4tKd8oWMPZ6Lxu
 I6aA0ghs3mTeDTzxCOqtufsLBuYvEAFXDLLSWOiS7W9Xhj73vCbYNpduXH4hBtNCud3WSt7Hx
 kg+gunyZOktYS9H5+W3EKpJ5jDiO+OJ+JY6BbXhplcb8Pbu7lBMP/1xtyLohoaSMleHs2K0fg
 QdxTDeZq/O2NA/pWJ7fFdpbb3uYug3gmzisRqFS/pyYFgNicVB/f10/MLhs+GkCe5U/FGgiDQ
 DL3RPRhrFBn/NO11+IJ/e/w8aArrvsfdkO+Bq/Z+sCBnhm/J9TekNjk28wr/J5kfEzdaKzGtK
 0bmiDdokB6GDSgeN9Pa0xgZM8B04g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for all the feedback provided!

I'd like to summarise what consensus we have reached so far and
then propose a way forward:

   * we'll use the term "ellipsis (pl. ellipses)" for what's
     been referred to as "3dots", "n-dots", "many dots" and so
     forth

   * we would like to use ellipses when attached to SHA-1
     values only for the purpose of specifying a symmetric
     difference (as per gitrevisions(7))

   * the usage of ellipses as a "here we truncated something
     longer" is a relic which should be phased out

To get there, preventing describe_detached_head from appending
an ellipsis to the SHA-1 values it prints is one important step.

This change does not cause any test to fall over.

The other important step is dealing with the "git diff --raw"
output which features ellipses in the relic-fashion no longer
desired.

It would appear that simplifying diff.c's diff_aligned_abbrev
routine to something like:

	/* Do we want all 40 hex characters?
	 */
	if (len == GIT_SHA1_HEXSZ)
		return oid_to_hex(oid);

	/* An abbreviated value is fine.
	 */
	return diff_abbrev_oid(oid, len);

does do the trick.

This change causes quite a few tests to fall over; however, they
all have truncated-something-longer-ellipses in their
raw-diff-output expected sections, and removing the ellipses
from there makes the tests pass again, :-)

If we can agree that this is a way forward, i'll create & send
v2 of the patch series to the mailing list (it'll include the
fixed tests) and we'll see where we go from there.
