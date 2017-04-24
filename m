Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECB0B207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 19:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S976935AbdDXTsf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 15:48:35 -0400
Received: from mout.web.de ([212.227.17.11]:57118 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S976843AbdDXTse (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 15:48:34 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvGa-1css5D1Z6i-009u7f; Mon, 24
 Apr 2017 21:48:31 +0200
Subject: Re: t0025 flaky on OSX
To:     Lars Schneider <larsxschneider@gmail.com>,
        eyvind.bernhardsen@gmail.com,
        Git Mailing List <git@vger.kernel.org>
References: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com>
 <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
Date:   Mon, 24 Apr 2017 21:48:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fp0gE6ymtxgktjEhG74Q8LLNV868wUbSBM+XRSxjChbSZwI7/vz
 PHN4ZIQZ1WQT2o8rLpmGc1nUvv3aQ9mL8w0ptV9jtsweLBE2rddFUo57usteW0rvX1SUb61
 EPFrgH1IDmWT7wuapSqx8GJLYc0j/jBg3as5Uai0Mnu4znFUOSH5lj1TPZEjlikLpzIRF51
 wZ6P3ndK2FTtUZ1rGRAsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MweondY1ucE=:EfxC+NWhDq4o2IXSDMtCbu
 oyPdsoOL606da0y+LupQblUY8zywD3hOM0pWOv7h9WgeJwLZdFgP5Zqzds4y9aCZJqWpny7l0
 Uy77S0kCvfAYRs13TwXrB4tWM0gEmmX30ZeP6zFjzmrc6MGvkkLIOG1XnMM6KJI+zSCEnT7GI
 XJdFFnPI7XhYiSkUOzHPhvEsf9VH9eVLWh6Q2OQxK7FUC0Ls2pLzRuNyQdu+uGaOpBu95U9Q5
 lBYDmuL6zCRlkQiQRmCyArMPazGL4R8LfJqlmLqzeOPMJ9zn7qnRos8gw9VL7fW+RnbtNTeYI
 hzTtVRzo9Uw0Qinpn0+UaAG7f/DI2BAB2S/qXcCaN/8FmimQGhC1ldxJoW6mAGB4WWGqN4svO
 kveMviBijtfmH/NxmCq8Bf8Lrl/8TlDf5aLjINAH+U4yTOWIRajGQco2L+URT8q4Mi9lfXZEr
 4tnXj1Dzbk6svdglIcQLOW5DAb6L0urJTw8g4y7QDYwPgTkT5J7uFv+u2laTqyuByGVGy66Ae
 fucy6NK2DTgPPfM7f1edWfKpIIcNEz0iy91gW6819XDBgR76nIYA3QJuteFFK7Z+KvBNWJSSH
 P1BS+EBmKwO/COVrh/cntvvdTNCeNk1NignlIkpMqlA5k3ryP01Sp72E/XuqMtSnE8/YLw+9l
 cB9PxTfK/VXemEgqIKTagJiG0n6OnkowqSOIz0hLGLQTBbHrCCWC3uJkNd8lf53FcjVvCDi5O
 PsnzbHX4va3hxW1lbBKKEBG0Y8mRBOvsfs1aKDdB7I5bODV9C1iG3B8cpdeGD9TCAPr9IxhXA
 TUdxpP2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-24 19:00, Torsten Bögershausen wrote:
> On 2017-04-24 18:45, Lars Schneider wrote:
>> Hi,
>>
>> "t0025.3 - crlf=true causes a CRLF file to be normalized" failed 
>> sporadically on next and master recently: 
>> https://travis-ci.org/git/git/jobs/225084459#L2382
>> https://travis-ci.org/git/git/jobs/223830505#L2342
>>
>> Are you aware of a race condition in the code
>> or in the test?
> Not yet - I'll have a look
> 

So,
The test failed under Linux & pu of the day, using Peff's
stress script.

not ok 3 - crlf=true causes a CRLF file to be normalized

The good case (simplified):
$ git status
   modified:   CRLFonly

Untracked files:
        .gitattributes


$ git diff | tr "\015" Q
warning: CRLF will be replaced by LF in CRLFonly.
The file will have its original line endings in your working directory.
diff --git a/CRLFonly b/CRLFonly
index 44fc21c..666dbf4 100644
--- a/CRLFonly
+++ b/CRLFonly
@@ -1,7 +1,7 @@
-IQ
-amQ
-veryQ
-veryQ
-fineQ
-thankQ
-youQ
+I
+am
+very
+very
+fine
+thank
+you

--------------------
The failed case:
$ git status
Untracked files:
        .gitattributes

-----------------------
$ ls -al -i
total 28
3430195 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 .
3427617 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 ..
3429958 -rw-r--r-- 1 tb tb   37 Apr 24 21:19 CRLFonly
3432574 drwxr-xr-x 8 tb tb 4096 Apr 24 21:27 .git
3425599 -rw-r--r-- 1 tb tb   14 Apr 24 21:19 .gitattributes
3430089 -rw-r--r-- 1 tb tb   24 Apr 24 21:19 LFonly
3430174 -rw-r--r-- 1 tb tb   36 Apr 24 21:19 LFwithNUL

-----------------
#After
$ mv CRLFonly tmp
$ cp tmp CRLFonly
$ ls -al -i
3430195 drwxr-xr-x 3 tb tb 4096 Apr 24 21:36 .
3427617 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 ..
3401599 -rw-r--r-- 1 tb tb   37 Apr 24 21:36 CRLFonly
3432574 drwxr-xr-x 8 tb tb 4096 Apr 24 21:36 .git
3425599 -rw-r--r-- 1 tb tb   14 Apr 24 21:19 .gitattributes
3430089 -rw-r--r-- 1 tb tb   24 Apr 24 21:19 LFonly
3430174 -rw-r--r-- 1 tb tb   36 Apr 24 21:19 LFwithNUL
3429958 -rw-r--r-- 1 tb tb   37 Apr 24 21:19 tmp

$ git status
	modified:   CRLFonly
Untracked files:
        .gitattributes
        tmp


So all in all it seams as if there is a very old race condition here,
which we "never" have seen yet.
Moving the file to a different inode number fixes the test case,
Git doesn't treat it as unchanged any more.




