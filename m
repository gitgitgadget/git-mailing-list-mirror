Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D1A1FE4E
	for <e@80x24.org>; Mon, 11 Jul 2016 11:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbcGKL3U (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 07:29:20 -0400
Received: from mout.web.de ([212.227.15.3]:64272 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbcGKL3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 07:29:19 -0400
Received: from [192.168.178.24] ([84.61.32.248]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0M3Spk-1b4u3X3Sgy-00r3Z4 for <git@vger.kernel.org>;
 Mon, 11 Jul 2016 13:29:15 +0200
To:	git@vger.kernel.org
From:	Nils Fenner <nilsfenner@web.de>
Subject: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign" is
 enabled
Message-ID: <57838306.5090505@web.de>
Date:	Mon, 11 Jul 2016 13:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Yoo8dVXPFheQe/MdD/6/BJmB/jR6NlBy5+0uSso71IKTxCat90b
 +iT++Ky0rMupvXfJKFoYmf5tnximKXhiaerWQdyUFNqgkU+w0f9J6BlQ6sRAfuIOcuhAbYg
 PSaH3NpkHdtfXDpSAxaeofTJgRxclTiYwXM3JD7EmOt28Ca0yFK7qdf8HfZ2rkjsgNJENRw
 9lQz9DlqZd8pf84wNT3SA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:A0qJFZI8Gos=:/D6E6JVfSjsmfamhAjPQwB
 8/kUVCfglzxO6O1oqIex/APDdmyP6q+pNUSqy8jPTOq1MyadK42Dy/5ywiESQU3c36CpKs6nY
 bU55EOFBfE9cSmd7ofMhkoMyJlXHnW8ta23p1IPOtpdQYxdART/qox1tr8cycUyd4G5pXUKVH
 CngKjwvhuxjzQemGuRsajXeQ56UOB64rw4TxGuy1x5dkt6Dv659yL5OSXNUNzTTgS0ylhMml4
 YtwjsWB9UT2RTPoPnDr7cDWtnppomTuHMpWRUCSdCNyIjYvANPAntYgSLq9nXKhnUWH82WJi1
 ewkQB0x5r5cxJrOJwd0zrIPsNIGcExgbFKZm7WA6s7AKGoar2BnjAVBHH8fiqAUg3lykSihn5
 ycwgPW4MVDPlvFSlgt+SOgBH5IgMzHfQqiO5Pe3BKi9ik6nQHIyLH37PKPcy4V05mS2wnGuKT
 WfX9KlRo5EEz0g2ROYxUOQvjGICTGJVrIOoTAo26j4+eLY2xfanYP8xXrPD+urW/PxzF6Fe8R
 YV+q07dKqqQa1iEmBRAY8oTNv1SRs40thiIdgsGdYi6dFBOmJNdw5rco72H/yPKAf7XaQmxUz
 7uRnSv51UNihVdL7DRcPZT4QjYIv+zkMgnOe6xC0V9AbBxmVmypwZoTnmMrEiqIcM5LAOytdM
 2AZ2rABakanhAA1uyMxNl+lMRhWmwMj6LiJKJJlOb8oWTi/qilvNWbN6wbndJND0EmZ84oRkG
 /oafpcMf8MyBA2a4m1CDPmZ1eETYAZ94RcNBbxe6I2zEi5oNfoG2RnUpdlG1zuStIQ/ho2R5e
 j6kGLEW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Git community,

since Version 2.9.0, the configuration option "commit.gpgsign" doesn't 
work as users would expect. By committing via 'git gui' (or usual 'git 
commit'  without further option), commits are not being auto-signed any 
longer, when "commit.gpgSign" configuration option is set. I also 
couldn't find a flag to "workaround" that situation in the GUI. To my 
understanding, I now have to pass the '-S' option to 'git commit' every 
time and GUI becomes "impractical to use". Surprisingly, nobody seems 
having noticed this behavioural change since the release of 2.9.

FYI: In the release log, there's a note stating, that this has been 
altered in the context of 'git commit-tree'. Maybe this interferes with 
"normal" behaviour.

Would be happy hearing from you soon. Thanks!

Cheers,
Nils


