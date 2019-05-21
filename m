Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97F4D1F462
	for <e@80x24.org>; Tue, 21 May 2019 02:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfEUCbJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 22:31:09 -0400
Received: from mout.web.de ([212.227.17.11]:58095 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfEUCbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 22:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558405867;
        bh=ceFuBnwnMwEe/GzqZLw0h5iXO8eP7t8jmFcQWmp8/bM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gosP5eQkcqqPpk0IFh5b7W03LAyaZ3bv3mSAXFgKAlICur3otjJ1CQeIiMESyL86i
         /+aYk3uuVxecqBVZy2MS8/O3Fdhk+t9z+KwfO/HHAYs3squRjcflCkEFJ04kMsU/Qu
         kjgcsensiw5Lhb714OlTrAyQPz7WtBOggUzAZg8g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhleR-1hEpmi1YaR-00MrAp; Tue, 21
 May 2019 04:31:07 +0200
Date:   Tue, 21 May 2019 04:31:06 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Ax Da <discussion@gmx.net>, git@vger.kernel.org
Subject: Re: Git config "ignorecase = true" has issues
Message-ID: <20190521023106.3sfrapksxg6xjtdg@tb-raspi4>
References: <trinity-4a160867-2036-4f8a-8363-7bf2e021d840-1558184320864@3c-app-gmx-bs48>
 <b75455b6-139a-aa6c-c7f6-7c9330e2ac6f@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75455b6-139a-aa6c-c7f6-7c9330e2ac6f@kdbg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:N1NpPc1Zl9nPRw8F0IWTFOZD08Wdk1IUio/e7tVQxwNahwdVPGA
 KhKDGK/P8jr/iA9G3NuhlU/2ct2Pvd5A+Zq+EkKOZLV/y9IAdEZ4AuISOKNiuv9CRPg6rCb
 AoztGcZOwTCaX5gj0JyHa2lQAEhAHgIkSXb3dDaq+14pUMO9Tx70u77LngfIBBguyyrplW+
 /00UEG4YKJvGcyUriFJlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmIjI6h0FaQ=:o+kabDkPHFugderJyaqJBD
 J+2F+cbr921s5RhJHx3iFcx7xcH0Qt0VZ8e7kJl/OlcmzTobdS9Unlwnc26wvcnmmcMnxBAgT
 WdcBlhXRzV0Hhy4DWE43Qa6qPI54CuokLJtNzAuCUl6bZTjEoqQiKQlcp0UhG64JW1whH6q7e
 PkJ2ROD6ss81jVRa8/05tai7LRKIhAMiKtJ92LkY9famRMZR3O+0CcT7JrUtn2O/EcbuUMyRe
 QokVTDAOOr+SRBRkF1pWBdU1xUQ3ppMcFFxWHVd76so14R/wHvNnXtvjOTw5R/fclVvS12+Su
 L/mqv51Sl3HQjHzogv/fPty/roiXuVivzMBP462HZ+qdJBS3mRfVxceP3Co5QzRjqJn+VqC+O
 FiRZudGmLTGhuoWSOHI86Q8NUy3iRAZLnrXIHKgB1uwEm0jQyc8tLRLFO5WK+RP3An51wc5pj
 pDheU7ceVPcnrPdk4J4j89SRwuDeznwcmM/MqNV0T9+VReqf1fJSpGjjafa9G4O5qFfZ8/sYh
 v12vGC9QR5y+Lv8SwSCX5C61yx8oQ/IUbGI9cJ9U2W4NzXGeuQA2qQw4v2FeYVEtXd5pH+0RC
 zReu2H2QVqLvz4e1K4vnTK78xHai7YVLqv6rD+E3DUct4RPFF2U/U96n4wnAr/hG2kY0S05Qj
 D9skOB1wkHpTDf3/2eC0fi/13tTMpJs0naXSLOt5D4PZPD/DANRRAKOnlD+rqqM/PbPiCyOKR
 1Rxjm/FJl26FkdIfZQvydlulOg788ZByjwhDdcx5RRGC3rMP8jHxuY2HYdUwNrcnzTg+lJIzI
 xMQUezAzqYzkULiqHI1w2ouz+XSOmYs/t7GHLfjqcBEagWIU7toG4HFw1ywP936FpHGWRXT/s
 gKu4z1DH8V7WVQNf2rIo+HXsidmcgg6tIpt281IpFzzseKGgqiGsJNKSPyEwdMCwRZRW2EecU
 fepXKV6AZdXvcDfEbC5fbYzH2f3BmZ58=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 18, 2019 at 06:38:39PM +0200, Johannes Sixt wrote:
> Am 18.05.19 um 14:58 schrieb Ax Da:
> > You can rename files like this:
> > git mv File.txt file.txt
>
> On a case-insensitive, case-preserving filesystem, a case-only rename
> operation is better performed in two steps that do not just change the c=
ase:
>
> git mv File.txt  file.txtx
> git mv file.txtx file.txt

Is this still needed in latest versions of Git, please see below  ?
A quick test shows that both the file is renamed and the index is updated:

user@mac:~/projects/git/git.pu> git mv Makefile MAKEFILE
user@mac:~/projects/git/git.pu> ls -l MAKEFILE
-rw-r--r--  1 tb  staff  100301 Apr 17 16:53 MAKEFILE

user@mac:~/projects/git/git.pu> git status
HEAD detached at git.git/pu
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        renamed:    Makefile -> MAKEFILE



  commit baa37bff9a845471754d3f47957d58a6ccc30058
  Author: David Turner <dturner@twitter.com>
  Date:   Thu May 8 10:23:34 2014 -0700

    mv: allow renaming to fix case on case insensitive filesystems

    "git mv hello.txt Hello.txt" on a case insensitive filesystem
     always triggers "destination already exists" error, because these
    two names refer to the same path from the filesystem's point of
    view, and requires the user to give "--force" when correcting the
    case of the path recorded in the index and in the next commit.

    Detect this case and allow it without requiring "--force".

    Signed-off-by: David Turner <dturner@twitter.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


[snip]
