Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AD1A20451
	for <e@80x24.org>; Wed, 16 Nov 2016 20:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbcKPUCm (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 15:02:42 -0500
Received: from mout.web.de ([212.227.15.14]:49672 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752966AbcKPUCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 15:02:40 -0500
Received: from birne12.local ([195.252.60.88]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgfH5-1cSsXx44UZ-00Nzkr; Wed, 16
 Nov 2016 21:01:43 +0100
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
To:     Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-3-larsxschneider@gmail.com>
 <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com>
 <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net>
 <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com>
 <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net>
 <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com>
 <20161115120718.GA7854@book.hvoigt.net>
 <20161115153159.mxfl73dnhljad5so@sigill.intra.peff.net>
 <20161116143925.GA32631@book.hvoigt.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <ca6e313f-912d-47a4-2dae-bddc969cd3a0@web.de>
Date:   Wed, 16 Nov 2016 21:01:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161116143925.GA32631@book.hvoigt.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:wf4N9JxnYFnm82B2OR/5hdE40KoPVdgS9oprAuoawzRUuHGe6Sl
 0vXt9F9swva4rrdixI8ykdpSHp5o3VBWP/Wzhr7vzPODRFoQjm5AKV/AHVgswEu2Ll+rDCx
 veAno+ZSmDg7mcsPx/ltwlrr/29HPiUTdzlrwseGqxx1BwAkQb/wYBLFsQ1g0Ov05wFBAvX
 TikJaJl9Kjxceb4Zam+SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z7LTQ4N2DyU=:yo23w3eLoFK/j+zcKEOClU
 XR25gMlYrUQcxBZN2harfqbJllPmhiAsH6OgN/eWXW+ku2jixaXrlKBn0L0g6iEfVecno5WVm
 pcbFTOMSClW4MEytxxFEJo8gSQHMU5BTgCOf0PVcwdP37WASRPx6+y4OB754E2UWpgUWRQGpF
 wLJtMIDXZT8QEdWs6rVlCOpKrh3LKUrmN4hHLF4e3DOoxBpeC0cxnJsw1pJdsYwI8u/4xtvZr
 NxlQSU3+kOg9p92Ddymx9wCKORCnVezjSpieaKltiu7NOKEtxlC0LGypR6Q7aKXdrxd2N5Ibs
 7B6xZXvwjNjAT0yoZCNoEy2m8I+zosmGo9gZot7LTifC+zgKdjBf1+NkfDzyUGZ51q/SDi9xk
 7dE7OTKPxbStfPa1J0EpS3P1tR/qgrYGKM8Xc3MzmtTk/kbgaZFDzE+WFCoE50LkWJB22NHOo
 Q3eOvfSnd3uj6YJPLlMdRKltu8VARaiP6i2k9Ssg00kqG3MFSFoN80XqPHvq7NfnziDdM/6Mo
 o16PlKiPzDcG4hMz0iFfgN854Ddnvdp8+hSPjz+/J/DnRLJC+G1lVcVGL8LtLzH1XEFouGzwp
 qCEPtneGaPw6s5PiLi3Vffcc3FbBvkyaSFtTRfi0qPg/OvQX1MavqbMiWEgrge7X6qAi71vzh
 p1J61IAt+I+vLvRa5o2rZysaKbe8vQBQy4K7WW0J/G2s8VLqnYQH+LQgWgkve2mi/CDqHv3HU
 q0g5+rwjL31fghTgUz35i3d/WxaBEPcyu/GPS6rXJvDru5OihNtLuYrBkpDmH6zHR1b2VKfO6
 cBjtxMl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.11.16 15:39, Heiko Voigt wrote:
> On Tue, Nov 15, 2016 at 10:31:59AM -0500, Jeff King wrote:
>> On Tue, Nov 15, 2016 at 01:07:18PM +0100, Heiko Voigt wrote:
>>
>>> On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
>>>> To all macOS users on the list:
>>>> Does anyone execute the tests with GIT_TEST_HTTPD enabled successfully?
>>>
>>> Nope. The following tests fail for me on master: 5539, 5540, 5541, 5542,
>>> 5550, 5551, 5561, 5812.
>>
>> Failing how? Does apache fail to start up? Do tests fails? What does
>> "-v" say? Is there anything interesting in httpd/error.log in the trash
>> directory?
> 
> This is what I see for 5539:
> 
> $ GIT_TEST_HTTPD=1 ./t5539-fetch-http-shallow.sh -v
> Initialized empty Git repository in /Users/hvoigt/Repository/git4/t/trash directory.t5539-fetch-http-shallow/.git/
> checking prerequisite: NOT_ROOT
> 
> mkdir -p "$TRASH_DIRECTORY/prereq-test-dir" &&
> (
> 	cd "$TRASH_DIRECTORY/prereq-test-dir" &&
> 	uid=$(id -u) &&
> 	test "$uid" != 0
> 
> )
> prerequisite NOT_ROOT ok
> httpd: Syntax error on line 65 of /Users/hvoigt/Repository/git4/t/lib-httpd/apache.conf: Cannot load modules/mod_mpm_prefork.so into server: dlopen(/Users/hvoigt/Repository/git4/t/trash directory.t5539-fetch-http-shallow/httpd/modules/mod_mpm_prefork.so, 10): image not found
> error: web server setup failed
> 
Yes, same here.

If we take that out:

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index c3e6313..1925fdb 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -61,9 +61,6 @@ LockFile accept.lock
 <IfModule !mod_access_compat.c>
        LoadModule access_compat_module modules/mod_access_compat.so
 </IfModule>
-<IfModule !mod_mpm_prefork.c>
-       LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
-</IfModule>
 <IfModule !mod_unixd.c>
        LoadModule unixd_module modules/mod_unixd.so
 </IfModule>

I run into other issues:

 [core:emerg] [pid 2502] (2)No such file or directory: AH00023: Couldn't create the rewrite-map mutex (file /private/var/run/rewrite-map.2502)
AH00016: Configuration Failed

(apache2 comes via MacPorts)


