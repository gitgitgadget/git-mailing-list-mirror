From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: t7063-status-untracked-cache.sh test failure on next
Date: Wed, 21 Oct 2015 18:05:49 +0200
Message-ID: <5627B7DD.3020909@web.de>
References: <5627A31C.10906@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:06:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZovuG-0005N6-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 18:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbbJUQGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 12:06:10 -0400
Received: from mout.web.de ([212.227.15.14]:55377 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbbJUQGG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 12:06:06 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MIeTI-1Zr8oy2YVE-002H33; Wed, 21 Oct 2015 18:06:00
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <5627A31C.10906@ramsayjones.plus.com>
X-Provags-ID: V03:K0:6Lt1vZrW/oqAnbcdrk3va0SIbnmQkBIILl/bd97g/hw63YhLdzJ
 C4M5Feia6Lr1WSXfqdKbwZBFYRkDT/WpnQKX0xoyc+h3u9Vr8cCxdEXu+Op2eYR0//HqFEc
 3X2esYWwQJ65nhuGAcrt6Emq71Xat1pw0IRxt5fWwuotprXezQre17wOIV8gpmUnfwzRi+X
 zRlRle6llpPUO4D42CcmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xM8CP6IF4eA=:cD1S1OEFbG1jY6ukfq5tfd
 7Ummk5dlz8bxBhD5fpYwZadxxXjjfI6eV5wzzthkEomj7tKEOtY+2GRYkcsoi/naLq2Lk6Viv
 ufbYgFdoikLVoU+/QKfjJfGor5dVHXzvhY0Bol5RSMHkyWOAL6L7SrZryx/NCv1il62Dh7imv
 rfUDA4f4SQm+l36ZPlpcS/1Vc4w0MojhuFmv389+oJK8WOufwFAstxJjvk4LNYrzV+3uu9Ub8
 1k1Dg1D2+C8p+JUTcYlVag5FexmysGUeYmFaQiXwNMe5q4X9LWrFaM2ccFsEvKc4DOaevRw6H
 CLt/MpU+F2Xi9H51Hpd0ZUisYBSgdR0kWy/DT+fJ1fbn0w9CuIwNg+WuNR8FRG6Yew1V398gJ
 F4P9+Kj3NrKTLJrdjHmglXb2P5vxQVNrnZUIsTF6q9o1V67hVEp7abQBuPWstTuL7o/2Xz7e4
 zPB47zGOPsddts87XUdKCQHXjpjEmW1V6SgE0efHg3etx2P1VMGX9eWKLfp1BUQoPC2OC7xwf
 9qC7fdwL37fDntrSOsoeJn0GJQ7EoPgS9qcjI4vJZYJMyff7c7a9z5PmAOFMRykuGxdLd8fuN
 GvnbVR8p2gukqTIgs8msO+z20dRJdSzETHczJyBMh94egOge+mvXWInKawcvm8vdPgACNyQbB
 T7Z42C1wMONAW2xUj9jWY9rpnJhP0GhBOk3tWfGUcC+tSo37lD09RI8Mal+Wg5I7Iqr1bKWEt
 wb1QboDesQpHgBKlvROYib6jh4yD6zhZpSu8Qy/TX+VSV/xMBLbEgKxHvbLCTyol8CfaiPNn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279986>

On 21.10.15 16:37, Ramsay Jones wrote:
> Hi Junio,
> 
> While testing the next branch today, I had a test failure, viz:
> 
>     $ tail ntest-out-fail
>     Test Summary Report
>     -------------------
>     t7063-status-untracked-cache.sh                  (Wstat: 256 Tests: 32 Failed: 22)

Does this patch help ?
(Recently send & tested by David. I just copy & paste the diff)
[]
 
Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t7063-status-untracked-cache.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 37a24c1..0e8d0d4 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -412,7 +412,9 @@ test_expect_success 'create/modify files, some of which are gitignored' '
 	echo two bis >done/two &&
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
-	echo five >done/five # five is not gitignored
+	echo five >done/five && # five is not gitignored
+	echo test >base && #we need to ensure that the root dir is touched
+	rm base
 '
