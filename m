Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 003DB1F404
	for <e@80x24.org>; Sat,  3 Mar 2018 12:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeCCMwU (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 07:52:20 -0500
Received: from mout.web.de ([212.227.17.12]:56593 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbeCCMwU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 07:52:20 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1eiAUg2us8-0134ux; Sat, 03
 Mar 2018 13:52:10 +0100
To:     olyatelezhnaya@gmail.com, christian.couder@gmail.com,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t006 broken under Mac OS
Message-ID: <f711d7ea-b3a0-82c4-6700-5ec285c91115@web.de>
Date:   Sat, 3 Mar 2018 13:52:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:qauxK/sY28EDPE1yBDsaSAaIVV7nXaS318FOj1e0XvNOjkg8sZE
 2HGqUo+GhLrVktz9RnwG2BYwVOB5SiYxnm4aGHaaxhDSXNf25/ckxx+bL8v9awtjcqgGwkz
 8tooP+sqWEQ3y7phlTJncpI/k7JXvyH1MAyyEshgbMIh28RAr6IlztGl04Qm3sZ5PfE2II7
 Dkppvapb8y0gVY3pexWAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2dE7HrojTWw=:MyZP/1Tl/KDpdJFDj58Wa2
 47Q4n9+YjhtYCXy0syTCFIVqURIp55Q0bH/Zbp9TNfNLhCDxyuYilN18l1Xbj3s+Gu83PQFSD
 xsIuokVCHkCvbI+uz6zat3opA6dROx7EjyFIEs3IE6MvwItguUCLKKSlJUwTUS9TjDw+8GRlu
 eEMaY2TZuXoMpTAmlNSh5DHGZmi6e+dY4FoYwTw3aJ4kKWQGfSIA9+GZR/ctlZ3chPQd7lCdB
 xVK9lh7sR8L9B0Ec4o8+d26ZELk0MCRs6wsBvudzy8Xtp0WfOlxLh/E8CzzCtlQBg9VnNMKqv
 aeEcm3y9qx+FuIk5RZliTXPlGMiibB9c9t9wyZEGfTOlFnrmysG9mkFjgus9bTMBC0tGjalAB
 xtkqW0U7C8c8w68dmqEdIzlYNUCPNX59h6Qw2BilmOCJaa5vSitLHoI5KPNsvF1iCvbsXyJtg
 9VWMMcF7Yz/JQyoz73+fiXfi8+nQN2bouepqmf5XoP0Py69VgqUA0ugi06RWJdhCm06CyHGLv
 4RmCIzPRY6pkukrxsOIaZjJlnoINoteFOgmtvewR5+N0oMjynXGDgSceKxKzFa8cqXjv/TCq7
 vZDfKsd8hyQ7mbtjFhBp/oFbfSVuQ33uNeLdYY63DI1hs0T1eEJFK3REKgKjhgIUxvBtwj7JD
 QFAIlTLelh/pgpQpSnbpk0YQ5nEBA2/yN7259ERR3kSXrU1KUVp9H4FXPLlaYoKYms+c239Cb
 fM/SVlXGDULWgkm+rsZSUITTXWLhkNAbHmlUddnwnf6mHUQCCzZ53stw3oY0j2FZLRhmlATUE
 q+/RKIuCae7RLTTQ9751cliVm4HIm1EyeIn1Elc611x9Le5ANo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hej,
Beside that t1006 has a broken indentation (mixed spaces and TABs at
 the beginning of the line, I get 4 errors here under Mac OS:

not ok 15 - Check %(refname) gives empty output
not ok 36 - Check %(refname) gives empty output
not ok 58 - Check %(refname) gives empty output
not ok 89 - Check %(refname) gives empty output


Running with debug and verbose shows that the empty files are not empty.
The characters in the non-empty file are outside the ASCII range,
so I copy  the stuff in here after running `od -c`  on the log file.
And I don't have a clue, where this stuff comes from - but I get different
"crap" with each run - seams as if there is a read behind a buffer ?



15:
0006000    0  \n   @   @       -   1       +   1       @   @  \n   -  \n
0006020    + 361   r   0 360 024 254  \n   n   o   t       o   k       1
0006040    5       -       C   h   e   c   k       %   (   r   e   f   n
0006060    a   m   e   )       g   i   v   e   s       e   m   p   t   y
0006100        o   u   t   p   u   t  \n   #  \t  \n   #  \t  \t   e   c


36:
0016220    -   1       +   1       @   @  \n   -  \n   + 225   x   <   e
0016240  240   @  \n   n   o   t       o   k       3   6       -       C
0016260    h   e   c   k       %   (   r   e   f   n   a   m   e   )
0016300    g   i   v   e   s       e   m   p   t   y       o   u   t   p
0016320    u   t  \n   #  \t  \n   #  \t  \t   e   c   h   o       "   $

58:
0027120   \n   @   @       -   1       +   1       @   @  \n   -  \n   +
0027140  302 206  \a   4 220 311  \n   n   o   t       o   k       5   8
0027160        -       C   h   e   c   k       %   (   r   e   f   n   a
0027200    m   e   )       g   i   v   e   s       e   m   p   t   y
0027220    o   u   t   p   u   t  \n   #  \t  \n   #  \t  \t   e   c   h

89:
0043160    0   0   0  \n   @   @       -   1       +   1       @   @  \n
0043200    -  \n   +   p 034 276 034   !   ;  \n   n   o   t       o   k
0043220        8   9       -       C   h   e   c   k       %   (   r   e
0043240    f   n   a   m   e   )       g   i   v   e   s       e   m   p
0043260    t   y       o   u   t   p   u   t  \n   #  \t  \n   #  \t  \t
