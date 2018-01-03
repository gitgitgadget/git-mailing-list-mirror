Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D71B01F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751024AbeACQyw (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:54:52 -0500
Received: from mout.gmx.net ([212.227.17.21]:51854 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeACQyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:54:51 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LsOsW-1evCxi0JNA-011y8R; Wed, 03 Jan 2018 17:54:46 +0100
Date:   Wed, 3 Jan 2018 17:54:44 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] Several fixes for the test suite related to spaces in
 filenames
Message-ID: <cover.1514998470.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vuTpgP38gwqnAhAGqYwsVVUgZm7qpx8npFTh6QB01H90mj08uJY
 uH67g2XVcORyYgY5Mgq6dsu8pUKvdGST/+IaYWZQz7/zRJZsmhf/RxkqKmn0z79vj97G4xf
 zmzpx2n6A+Q1+HxSp00AIwihAHEfMhHZBI6IFeAVUVRLqYT99zDFYdUIzj1J2QU5+8z2pB+
 9rAfYj57UjNThr5hbYYgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LZHRTqVoFp0=:aFIKwq/A/VajGO95bhR7g4
 zRHS1g/xYHx+gPHcMHkUAb1VW7+zUq9xl9niIkrNZiJTGbTsG1kRweGt9QiVBpbnS4wyd2pcj
 A0/ByHZK8rbSI5Evc5lM0erwnOlgRI2Vsdmr7R8baWA7bAf548VHvS/jiQZYBnCYcXj77hv71
 if+oAUEe1gdVI8ZZctbGCyVOShzfvzNtJ6ttnNWVwfxBIoK/7iHhUFaYn7U2fmDK6QWONbk9a
 WppwRYq/skl2CwA5ZfBvCx/+xhDcdTiX71ERQ08qhDv9voA9PywtU7JPxq7O0W8BkxMwVA9V7
 v3jO2jh3vqpAfCLWXw1NXy36J+B06IBfug00AAogBOdtrt3klMu35dXJs7u4h5GpPDghTnPE3
 ppXIuLufBWdRjP07ZDbN2AoZabIJEI8vWWd3AxffTkgo66fkYclDcBDdAhGNg/kGK+IV4AK27
 gjZryTYRQfFp4vQPEQmsT1MK+SwttazwDghV0NOaSknzR0kBWBMoTrL0BPgT2YkZfLHAovzGb
 B34dkjtYSUhzwaEkJVw0V9g02MC8cwJzqDN6ZNWovhmc9kzjNAM5lvF0MI8X8IuT3Gb1mp9p9
 rRIdSTN+sJOf5DIvNBJj25fEJSZS+IYxmYfzKojLCbY5IgFx7Y0c65ZQN3Ylzw6srHrkiCsvY
 4LBKtsAFrCkFHJXARQ/QCxY8ruplY0fA7QNEz8vkkWcA5U5z971/xFV8nKuDtJ59aC5ekAtsk
 IjgFRcAnk8REb26mobLiMkuk663SObc/ONNYdUgTbD1qxa1Rw0PVysbiFpPbfWfPIejA02l5n
 Z8rwvfnT8sAqrPVVUtofSTwelLKEAMB5BptceB8L209IAc47spwUzBe214wQIUL9/z/wePI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second issue was found long ago, and the patch carried in Git for
Windows, although nothing about it is specific to Windows.

The first patch was developed today, when I tried to verify that Git's
test suite passes if Git is cloned to a directory called `with spaces/`.


Johannes Schindelin (2):
  Allow the test suite to pass in a directory whose name contains spaces
  t0302 & t3900: add forgotten quotes

 t/t0302-credential-store.sh | 2 +-
 t/t3900-i18n-commit.sh      | 8 ++++----
 t/t7500-commit.sh           | 4 ++--
 t/t9020-remote-svn.sh       | 4 ++--
 t/t9107-git-svn-migrate.sh  | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)


base-commit: 1eaabe34fc6f486367a176207420378f587d3b48
Published-As: https://github.com/dscho/git/releases/tag/with-spaces-v1
Fetch-It-Via: git fetch https://github.com/dscho/git with-spaces-v1
-- 
2.15.1.windows.2.391.g0b42e3c56de

