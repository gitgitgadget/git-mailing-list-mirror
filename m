Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD6781FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 18:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdBHSo5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 13:44:57 -0500
Received: from mout.web.de ([212.227.15.14]:60205 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751148AbdBHSoz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 13:44:55 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXSg2-1cxzdw3Dks-00WaDp; Wed, 08
 Feb 2017 19:37:50 +0100
Subject: Re: Trying to use xfuncname without success.
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
References: <CAKepmajNz7TP_Z6p_Wj17tOpiMOpKkvQOBvVthBkEiKabAppjg@mail.gmail.com>
 <271989d5-c383-0c0d-bfcb-f4118f9fa2aa@web.de>
 <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
Cc:     git-mailing-list <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1aa20b4e-782f-a650-eab8-51218b838337@web.de>
Date:   Wed, 8 Feb 2017 19:37:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAKepmagp2mXNviA2VdT=3EQtZi2LkA_5oG6=AbfkBGKP9Hqiiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Zj0uwOIvnY+lQUePU7r72lEtDZ46ZWEtTUCy/tC33ybDzxtUjI2
 fDIiKK+ZuLSO9k0YgIC1TdMpEambe4rbBsRC4DfTSPcvIvdeo5GV2idjGkpRd9o5Sn9NpNJ
 0cFhlFTl9yIuTHxwqShYDB1A4CR1OwizGM6vfQnLAkK+ccT+yw+pjJ7VkbxyP51GxqibICT
 PEWu713HCA7A6K0Eme1dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DcyI7sBwryg=:Q/5ZbvILQcSV41eciQfNt5
 h/W8Y5f2Rhc+Dal2BP3bdOl+ES1ngbIDOslzagCRSrmqKMVTbRWoLJm2YRKXl7hsHaPN+8bJ5
 4J+Lv1vpzSFOgk/lcTcGsZhBYZ4mK1yN5205MhAFBqo5x9D1cTOWRp4cZRcYF7hsyH2iM/EXK
 V28N0togyZ7zvC7ii8TlyC5ice1UJVdo4KKinqHqCyLZtVRgihXohcWcwUOIR94oB56EGyZXv
 pbp0+9TOTl19mfhrwPYsvJyELXKDtJEwKHulRvyUokVwF0gy/tFXzDf5GGnl3IA2xCZAET9hI
 w5zg0nOglNvuNddGWuF8E+5IMOukxtnSPtzIdrf/lFJVIQDxyua0ulRRYbNQozpcPWx9FmHU2
 A+0bdV3iTY1zT0/wagUGWiQjX9baQBBV1LhvXK/v0fTYmnnnuLl2fg3/XVP2H7OuH2mJrr9gh
 petTF39gY4OZ3GfiOdOyqz/tzxsyFqFzMbzXdRmr5ZaJ4yB9R87hAFSWp2LhSUsDqX91C/L3e
 kmjQPABKxHrJjvKIrhWrYa10guvfNxXuOv0v/oAA9w6EuxFtjzhEDa5MKE2zbT2oqt1mZ6A2d
 tO6ug5YI6xIgi1MQENlQ5u5ReIMN1j+JpiX3my2cxEAELrWC+yznyl4MzaUa/XPPItXnXVBl2
 GVKxcisc4gEN863OZ6bRptCNiqIZp1bjEqYwa8xMK+XUe1hDhEXgGIaLx+cQPP7X+lpfkhVgO
 Q39Esx/cd8ehJOT5vLCyH1CRAYH4ip8OwvEoW8pZqNoFUhnRqNLuExvr63zaHEQnv+r6g/jMR
 vaDOZs8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.02.2017 um 18:11 schrieb Jack Adrian Zappa:
> Thanks Rene, but you seem to have missed the point.  NOTHING is
> working.  No matter what I put there, it doesn't seem to get matched.

I'm not so sure about that.  With your example I get this diff without
setting diff.natvis.xfuncname:

diff --git a/a.natvis b/a.natvis
index 7f9bdf5..bc3c090 100644
--- a/a.natvis
+++ b/a.natvis
@@ -19,7 +19,7 @@ xmlns="http://schemas.microsoft.com/vstudio/debugger/natvis/2010">
 
 
       <!-- Non-blank line -->
-      <Item Name="added var">added_var</Item>
+      <Item Name="added var">added_vars</Item>
 
 
       <Item Name="var2">var2</Item>

Note the XML namespace in the hunk header.  It's put there by the
default rule because "xmlns" starts at the beginning of the line.  Your
diff has nothing there, which means the default rule is not used, i.e.
your user-defined rule is in effect.

Come to think of it, this line break in the middle of the AutoVisualizer
tab might have been added by your email client unintentionally, so that
we use different test files, which then of course results in different
diffs.  Is that the case?

Anyway, if I run the following two commands:

$ git config diff.natvis.xfuncname "^[\t ]*<Type[\t ]+Name=\"([^\"]+)\".*$"
$ echo '*.natvis diff=natvis' >.gitattributes

... then I get this, both on Linux (git version 2.11.1) and on Windows
(git version 2.11.1.windows.1):

diff --git a/a.natvis b/a.natvis
index 7f9bdf5..bc3c090 100644
--- a/a.natvis
+++ b/a.natvis
@@ -19,7 +19,7 @@ test
 
 
       <!-- Non-blank line -->
-      <Item Name="added var">added_var</Item>
+      <Item Name="added var">added_vars</Item>
 
 
       <Item Name="var2">var2</Item>

> Just to be sure, I tested your regex and again it didn't work.

At this point I'm out of ideas, sorry. :(  The only way I was able to
break it was due to mistyping the extension as "netvis" several times
for some reason.

René
