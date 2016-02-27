From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Sat, 27 Feb 2016 18:39:31 +0100
Message-ID: <56D1DF53.1010006@web.de>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
 <56D078F3.9070905@web.de> <xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
 <56D0D2DF.1040807@web.de> <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
 <20160227032907.GB10313@sigill.intra.peff.net> <56D14C56.6070306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZirL-0004hG-P0
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422813AbcB0Rjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 12:39:52 -0500
Received: from mout.web.de ([212.227.17.11]:62155 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756340AbcB0Rjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:39:51 -0500
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0M40zO-1ZjGe60YgE-00rZJW; Sat, 27 Feb 2016 18:39:40
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <56D14C56.6070306@web.de>
X-Provags-ID: V03:K0:h2PfUlfwacaMBRDPxPfpq6jk1+LMyeYNgu42NCB73B/iUKqBuqw
 VlkbQrIT0gJqrloIiSL2V89PSpMLFW7pobqwg71Oi7pncEbt8nW+p/VPnHenDmOLeKZw9BG
 ZVI1tXX1MGVyg9TGlfxTua9GB/WsRbKVoewu8ecjyOtYu7BiAEr0xsalUZzxEVC6knpirL0
 IWllMMyVy2sc+6xRHix6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HexAEfw1xpo=:1gPTvMu9OjBR6zZ2VP4kHW
 hvzznjdX+al/bImzwpo1zqQ67TwVyIDOWlOaBUxrOD6Z1sNG6flCKvtcQZPo/GLTALQvFWcn9
 4s3myQ8C4sIz8y4N08Zx3iXF+WwL92BZfWhvMRz8kTUFJeMJOm/KbwWRSvd16hQ+F7Zps5JCS
 u7tpczTo1LGLN7ZFoXlF7Xdm/rRykcxmE2JpKKz2bDd62RMl5EVcqbh509vqu4LU88VFKWypC
 gKvjD3mfua240+VauDdMJn8zzgoQTTMOG3Xl1ZZ6Lv+9GoxZGy+zMP4hQE6W7bQxcd5j4Ppro
 6aYx+4QKqkw9kboJ3LFhYPYcVL/PYpsGSQCLe5NYSfV/MshEgAOXsCIU4GINS3ESmGVR++I53
 4qJpbhIeVYBfnQOcIgNvbCLZ9d1d5+YO2chmOsf7UEestMjYK2XygeEo1Hxg+1D6SaIreLWZ2
 9ID+Mb7El1DeLMA9oLcvDH8t8PPm8/g3DtXpEwO3Wcy9k5LkEn3f0x0YaxfuOWVQ2GiZdd27O
 r7ZDOdEv29R1ugKVruI/AEGxDxfkXK6NpKSspvuwiu2d+pwblzwqFSW957/mcp8vv7bze++Cf
 1jZ8Z8fqaJ2R5ivjzm7lN1l7kN6bNE5W1WSjKyM3quU29T9jv6MCfjiPgQ3MeB8V6CGSkVvqD
 edboFa4siZlXkv2Ji5sY4vY8LSIgzRuCN8qdX+RlvwNG6isrX+OrC1sBJC05btDqb/vd4Ab5Q
 F14UuFhnr1qyqaWkQh67aeTaMof9r2dpt8ZQchYbk9uDs8pU444Oo5JC5ZVuqFzYXo1fnqDV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287706>

How about something like this as a workaround ?
(I can send a proper patch, if this is the way forward)

commit dcd7d5551d6931e47829c7febbee0877340eb17f
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Sat Feb 27 15:18:28 2016 +0100

    config.mak.uname: Darwin: Use clang for Mac OS X 10.6

    Commit
    "tree-diff: catch integer overflow in combine_diff_path allocation"
    make gcc under Mac OX 10.6 crash like this:

    CC combine-diff.o
    combine-diff.c: In function =E2=80=98diff_tree_combined=E2=80=99:
    combine-diff.c:1391: internal compiler error: Segmentation fault

    Xcode for Mac OS X 10.6 has both gcc and clang.
    Later versions of Mac OSX/Xcode only provide clang, and gcc is a wr=
apper
    to it.
    Make Git compile under Mac OS X 10.6 by using clang instead of gcc

diff --git a/config.mak.uname b/config.mak.uname
index d6f7980..211afec 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -102,6 +102,9 @@ ifeq ($(uname_S),Darwin)
        ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
                NO_STRLCPY =3D YesPlease
        endif
+       ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 10 &&
echo 1),1)
+    CC =3D clang
+       endif
        ifeq ($(shell test "`expr "$(uname_R)" : '\([0-9][0-9]*\)\.'`" =
-ge 11 &&
echo 1),1)
                HAVE_GETDELIM =3D YesPlease
        endif
