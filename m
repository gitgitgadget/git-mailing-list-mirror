Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B836A20964
	for <e@80x24.org>; Sun,  2 Apr 2017 04:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbdDBEe1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 00:34:27 -0400
Received: from mout.web.de ([212.227.17.12]:63038 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750768AbdDBEe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 00:34:26 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJTdf-1cxY1M2aR1-0037ct; Sun, 02
 Apr 2017 06:34:23 +0200
Subject: Re: [BUG?] iconv used as textconv, and spurious ^M on added lines on
 Windows
To:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        git@vger.kernel.org
References: <feaeade7-aeb5-fa67-ab29-9106aeadb2a6@gmail.com>
 <264c72d0-9558-fa0d-e5ee-eaca894538be@web.de>
 <bbd60ab1-1309-6b1e-9b7f-09764bab5ccd@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <fde70c33-72ed-4035-2a55-2184fa9ac553@web.de>
Date:   Sun, 2 Apr 2017 06:34:26 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <bbd60ab1-1309-6b1e-9b7f-09764bab5ccd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:T57H1NdLM36Lm4Bd7xfWCm4NWplUskhVVNr+6WPHhFHqxF+KNVD
 n0Azck2sFlElUKVCIKJ0SB8P1gObEDDknfEVr7AzAJ25Uf+76peo7SZd5sx5tfFIbnm2NFO
 OiQfUw1mKiABJa7k2hGliGZSfpukt/yubaUDk1zodJ7QXPCjp5bk1sZwf/fK3fYfPwp4A5G
 1lc/rU9xU2Viui2ry+pYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uldO7+nzgnU=:EkK03g98PvavzLGZsHs7M1
 n2kflrgKD+yflt2XF++Cv41hD3EbkroRbznRv0YrVCIGp9RX5qxtPsV8wyftQWvpWdCMGPZxO
 9RvMPWbGQce0uvulOWPUBAwHQARbMRnJPwAIAu6p1DUXBIMaYi1tY20L95VGdbXTxlmPqYJuE
 M2n8yOMs6AZJTv23+pYIB/SFGMXszxpu6H7+pcN1pPSdjNIRvCw+5ViL6NmXoTdkJBQY4hgQM
 0PRJd22MM/hwGleMsR2SC2k5yHP3e2fSQYhR9SJSU5NEmUofyoxrgArJPXPy1C/aIAw4W/Pjs
 tz+WKQAGrih9gUCmA+IJVoDJ9iI1GVJzK5yygXzQ3hqYxU+uAB0HX2WwZ+1tFHHjb2K/gPI9P
 thPI1Qc6Rd64LaVTYsjT8kFSirbQaTYMQXtikHDbGTBjw6ENkwbmW0Y9Al4ewdbl01mU1jWEr
 9xXmh0Zpzqu9TopSJP9aG/ieFSl09qmDLz27ok4B+uYG1q9dgZXrFOQP4PMhZPGMPQiiMcmQp
 2sw8KepQ/80QjT6H8uhW97w3FbBbRSLEDve20P2v+hZfpRyKQWVRirHu1BWxdOBJSFGU6LbXu
 GHSzmDYq9pv0n0WRtPcxJhDfLlpjYgrY5IFW+qV2FyuLymafpFD9krUk+FDlZzpZbE+pMxCdA
 0nvPA00HnzzK7zv3RHaIO6xr+lrs/rZQ/BgmWQWm95KTGEkRraRxiwfEPJyi/ZeH0j610ntm4
 VbkjLVo/FQykhAgeOh/3bNGkVugZum4+ZAqG3MOsVR21NbFnl9QjaK0MnOgw5JBNA1BnHxFAB
 yhYS21Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-31 21:44, Jakub Narębski wrote:
> W dniu 31.03.2017 o 14:38, Torsten Bögershausen pisze:
>> On 30.03.17 21:35, Jakub Narębski wrote:
>>> Hello,
>>>
>>> Recently I had to work on a project which uses legacy 8-bit encoding
>>> (namely cp1250 encoding) instead of utf-8 for text files (LaTeX
>>> documents).  My terminal, that is Git Bash from Git for Windows is set
>>> up for utf-8.
>>>
>>> I wanted for "git diff" and friends to return something sane on said
>>> utf-8 terminal, instead of mojibake.  There is 'encoding'
>>> gitattribute... but it works only for GUI ('git gui', that is).
>>>
>>> Therefore I have (ab)used textconv facility to convert from cp1250 of
>>> file encoding to utf-8 encoding of console.
>>>
>>> I have set the following in .gitattributes file:
>>>
>>>   ## LaTeX documents in cp1250 encoding
>>>   *.tex text diff=mylatex
>>>
>>> The 'mylatex' driver is defined as:
>>>
>>>   [diff "mylatex"]
>>>         xfuncname = "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$"
>>>         wordRegex = "\\\\[a-zA-Z]+|[{}]|\\\\.|[^\\{}[:space:]]+"
>>>         textconv  = \"C:/Program Files/Git/usr/bin/iconv.exe\" -f cp1250 -t utf-8
>>>         cachetextconv = true
>>>
>>> And everything would be all right... if not the fact that Git appends
>>> spurious ^M to added lines in the `git diff` output.  Files use CRLF
>>> end-of-line convention (the native MS Windows one).
>>>
>>>   $ git diff test.tex
>>>   diff --git a/test.tex b/test.tex
>>>   index 029646e..250ab16 100644
>>>   --- a/test.tex
>>>   +++ b/test.tex
>>>   @@ -1,4 +1,4 @@
>>>   -\documentclass{article}
>>>   +\documentclass{mwart}^M
>>>   
>>>    \usepackage[cp1250]{inputenc}
>>>    \usepackage{polski}
>>>
>>> What gives?  Why there is this ^M tacked on the end of added lines,
>>> while it is not present in deleted lines, nor in content lines?
>>>
>>> Puzzled.
>>>
>>> P.S. Git has `i18n.commitEncoding` and `i18n.logOutputEncoding`; pity
>>> that it doesn't supports in core `encoding` attribute together with
>>> having `i18n.outputEncoding`.
>>
>> Is there a chance to give us a receipt how to reproduce it?
>> A complete test script or ?
>> (I don't want to speculate, if the invocation of iconv is the problem,
>>  where stdout is not in "binary mode", or however this is called under Windows)
> 
> I'm sorry, I though I posted whole recipe, but I missed some details
> in the above description of the case.
> 
> First, files are stored on filesystem using CRLF eol (DOS end-of-line
> convention).  Due to `core.autocrlf` they are converted to LF in blobs,
> that is in the index and in the repository.
> 
> Second, a textconv with filter preserving end-of-line needs to be
> configured.  I have used `iconv`, but I suspect that the problem would
> happen also for `cat`.
> 
> In the .gitattributes file, or .git/info/attributes add, for example:
> 
>   *.tex text diff=myconv
> 
> In the .git/config configure the textconv filter, for example:
> 
>   [diff "myconv"]
>          textconv  = iconv.exe -f cp1250 -t utf-8
> 
> Create a file which filename matches the attribute line, and which
> uses CRLF end of line convention, and add it to Git (adding it to
> the index):
> 
>   $ printf "foo\r\n" >foo.tex
>   $ git add foo.tex
> 
> Modify file (also with CRLF):
> 
>   $ printf "bar\r\n" >foo.tex
> 
> Check the difference
> 
>   $ git diff foo.tex
> 
> HTH
> 

There seems to be a bug in Git, when it comes to "git diff".
Before we feed the content of the working tree into the
diff machinery, a call to convert_to_git() should be made.
But it seems as there is something missing, the expected
"+fox" becomes a "+foxQ"

#!/bin/sh

test_description='CRLF with diff filter'

. ./test-lib.sh

test_expect_success 'setup' '
	git config core.autocrlf input &&
	printf "foo\r\n" >foo.tex &&
  git add foo.tex &&
	echo >.gitattributes &&
	git checkout -b master &&
	git add .gitattributes &&
	git commit -m "Add foo.txt" &&
	cat >.git/config <<-\EOF
	[diff "myconv"]
	       textconv  = sed -e "s/f/g"
EOF
'

test_expect_success 'check EOL in diff' '
	printf "fox\r\n" >foo.tex &&
	cat >expect <<-\EOF &&
diff --git a/foo.tex b/foo.tex
index 257cc56..88c2893 100644
--- a/foo.tex
+++ b/foo.tex
@@ -1 +1 @@
-foo
+fox
EOF
	git diff foo.tex | tr "\015" Q >actual &&
	test_cmp expect actual
'

test_done

