Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C6720193
	for <e@80x24.org>; Sat, 29 Oct 2016 09:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932625AbcJ2Jno (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 05:43:44 -0400
Received: from mout.web.de ([212.227.17.12]:57688 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753615AbcJ2Jnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 05:43:43 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lz3BE-1cvfZW1SQy-014BTs; Sat, 29 Oct 2016 11:43:34
 +0200
Subject: Re: [PATCH] valgrind: support test helpers
To:     Junio C Hamano <gitster@pobox.com>
References: <71c3d13a-fa29-75d3-50ac-81978c08f552@web.de>
 <xmqqshrg3af4.fsf@gitster.mtv.corp.google.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d6485418-e009-f808-8ee2-a06e60c60d0d@web.de>
Date:   Sat, 29 Oct 2016 11:43:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqshrg3af4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:s6DsqdFJ0l3aWmtZUfquRbyfROvrQq+3IoqYedbryoJNuDX/exL
 w20MByst+gLL//RW9Y7WvMnnWOt9llcC8KD00JKkbyTSNl7fst2d8PEKCyrJWFReKMIGf6b
 xBI8TbdjoKyqzSnNVVIZUhuxTkpmum0aXrwO9tMPbdoM0kbbd/MFvIRC93rYPwWMKBkz+Pf
 0eUEwxzMHOyIIz6xxbnAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ql4d0DnfTo=:Z8W4OEHYwFHkqea3sYbLa2
 JQ1AHd7ZlvU9yH9dRidYXXkrjtUCOfx4jVLRyRuThqcefi/IfIXFqNqMl7vLMwVnenH2pXpyr
 3pyAjhcpr2v5gKWS+uwI6ThA9EcAHbGP/ASz+u0Vup9gYI/nnmT5qHJtTAMuLFl/XwWg9BRqr
 Uq+g5saCqZ4asm+UG+X2m2myZAezvV+2jDOiL4l1miIbYNfLtfE9Kx7MkFDhlXstwsc6VW8AR
 K5ROnpeuigx68dS0rm/HAGIco0Sbqc2tcTHR4mlHOd1oQKCM+/x+bhe95nRKTZ/UfO2XW2Pbf
 w9OXD3tBL/je0ZaUGktyQWQUvGq9VcqiImFXvt3faQ7ds0tXzLtTy6Do4+lmXTTtd6qzSS69B
 RmzQ5ovx4GyN3D4OxBYqebNMTLxoLhdsM/oLAWu/AhtgU6QMKbhr4Y5/tVvbb/KP17L8L9fU7
 BWK5lEZIRbMDLvInvukvwfoRl21PHZ2/USPg39YMPsiEri/eJJatgKPYCmrS8j3UAfLHrR4sS
 Dh15+cQWW+D61wlRAfqhLIRsS+B6LudnakPuwOVxrLjEOz3Bxr5zc8YT8Wzkwvh1F2zrqw51O
 SLxjSqYlAgVryfNlIcp/BVdIeSFP6N6QegD3DvxNa43cZRcnkeZYJsmz5pI9M3bvzCraNOAeo
 uW9KTQ2zPfF3Bkxc/hUba4wCvENUh3lD3sljD5F5LjQRIzuqyCLmpkbnkrwGjnk4W/kb6AScI
 o23WyJ3SvtvCXrCdZS+ARuDIGfGJnODNCNzkoz76CM7aVPoJhSFMQA8JTmPIj5d0Ux5KTd/sz
 iEmpcjp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2016 um 14:50 schrieb Junio C Hamano:
> Hmph.  I somehow thought this was supposed to have been fixed by
> 503e224180 ("t/test-lib.sh: fix running tests with --valgrind",
> 2016-07-11) already.

Its title seems to indicate that intention.  Probably the quickest test
script that calls a helper is t0009-prio-queue.sh, and without my patch
it reports something like this, unfortunately:

  expecting success:
          test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
          test_cmp expect actual
  
  ./t0009-prio-queue.sh: 4: eval: test-prio-queue: not found
  not ok 1 - basic ordering
  #
  #               test-prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
  #               test_cmp expect actual
  #

René
