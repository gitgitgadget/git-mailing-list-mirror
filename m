Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31CD8209B8
	for <e@80x24.org>; Wed, 13 Sep 2017 09:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdIMJIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 05:08:24 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdIMJIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 05:08:23 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0Luaps-1dRQ342GZs-00zmRG; Wed, 13 Sep 2017 11:08:14 +0200
Subject: Re: Unexpected pass for t6120-describe.sh on cygwin
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <7c3db153-2a56-f27d-af71-e4b61f1252a1@ramsayjones.plus.com>
 <alpine.DEB.2.21.1.1709121538360.4132@virtualbox>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <52f990d5-cdac-b516-269c-acbb68897e6e@grubix.eu>
Date:   Wed, 13 Sep 2017 11:08:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709121538360.4132@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:MT63ECs4w/No6jTRRl5h6Y562eIRmyElfMqNbnY/ftv08bD6Nk/
 MPRxCxFaCDgZnNneBbddb1IJweaItYvORsoEVTsV5lesP0y0pez9jsK2Z4s6CgvHWbQAFf4
 JFhpxzYtdP1JhujeVEWapItnhgvYLT7lteCWy2rxNJT/oLyWY6mf4HjpjL/jsQtkIvYjC3l
 O78PDyHRwJv5Vd68ZdU4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MIi11HMl788=:Zv4Zb1F+tzmnmgk8/DxTak
 bXlwuNAjibAnbM8IZuv/ue8vTbNzfzdLqpofteAd+i09dPyAM8vZIanRaspXZI//Wap07sbM6
 p9kZQWxBmyWCdDQvJoBRTkqEgInYlM3/Dt2W53KBNPJXFxtaQeW3EkJs0oXrxwKjyP/96VpyD
 ZMrfSXXo5JO/Y2nA1j8UPO51XIbtu7w41Ewp4poHq6zRy4zK4Iq/p4blaHpWDda4QCZgWl1Q2
 kp8UL14yVYnrq65b02Tni5L4cOn/D2TJ1qIQMWf0aOp0DAhE1akth2v4D0xEbmD/mSVmPFkPq
 ywiFP+pzwyeaGHeMfjPsqLH/65Bzv+5MNfeDxwau24A0Tc62ZidbS7e9iUl4fk1APmsWaWfTg
 vqv+jtL1pWKE+IZ66hezaPmyKKjPDtYhO7pRT5+4tKY1uJ8v50UqNtB/qlZI9cesT+PTtUGFV
 39Iq4bnqK6FgMYUa2iOxpnickbHerMrkc6zK38HEAV5ESdhwc7vbauS5R5DwtfHuMnrJKWYsQ
 hl4fS0bPoNEfyHwSnUFySM426UBie/byN+AUEt6sv/sG2SGhS9jkBWYdKmORHHOPmKCzBi4js
 3VNS5UiNcqKZoq5c8CBT4mp0Vy9QnIGdCDdxmY8TVJh5cFtQ0nZbviGX97rsWKPENnpNOvdpf
 oluDasMr0IW7op50nG0E4yJyshioSbpXQ7DS0sc1p1qHBPaojranNR2COj4BAOZWdp/f64GNB
 JsT9OaEsPl3ycwyMLb3DwF5c9bDcvAqJrfhnIEpXZtQfNqMNpuugOj3xwE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 12.09.2017 15:39:
> Hi Ramsay,
> 
> On Sat, 9 Sep 2017, Ramsay Jones wrote:
> 
>> I ran the test-suite on the 'pu' branch last night (simply because that
>> was what I had built at the time!), which resulted in a PASS, but t6120
>> was showing a 'TODO passed' for #52.
>>
>> This is a test introduced by Michael's 'mg/name-rev-tests-with-short-stack'
>> branch, which uses 'ulimit -s' to try and force a stack overflow.
>> Unfortunately, 'ulimit -s' seems to have no effect on cygwin. I created
>> a test program (see below) to eat up the stack and tried running it with
>> various ulimit values (128, 12, 8), but it always seg-faulted at the
>> same stack-frame. (after using approx 2MB stack space).
>>
>> So, it looks like all ULIMIT_STACK_SIZE tests need to be disabled
>> on cygwin. I also wonder about the ULIMIT_FILE_DESCRIPTORS tests, but
>> haven't looked into it.
>>
>> Given that 'ulimit' is a bash built-in, this may also be a problem on
>> MinGW and Git-For-Windows, but I can't test on those platforms.
> 
> It is.

Thanks.

I just dug something up from an old cygwin list post. Could you please
try and report on the following (cygwin, MinGW):

ulimit -s
ulimit -s 4096 # anything lower than the value from above
ulimit -s
bash -c "ulimit -s"

My suspicion from that post is that ulimit affects the sub shell only -
if yes, running a test inside the sub shell to confirm whether the
setting is in effect would be great, of course. /usr/bin/echo $(seq
100000) or such does the job on Linux (with stack limit 128), but I
don't know whether this is portably reliable.

If ulimit on these platforms has no effect but does not lie about the
value either it's a simple prerequisite test (test ulimit present, if
yes set and get and compare the stack size values).

Michael
