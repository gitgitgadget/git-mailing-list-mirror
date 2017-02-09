Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31BF01FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 12:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdBIMbT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 07:31:19 -0500
Received: from mout.gmx.net ([212.227.15.18]:64897 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbdBIMas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 07:30:48 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1F72-1cI56k3t4C-00tFnq; Thu, 09
 Feb 2017 13:29:35 +0100
Date:   Thu, 9 Feb 2017 13:29:33 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
In-Reply-To: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1702091319350.3496@virtualbox>
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hzhUQLrm+QvTWnjvtmcbpMl2bCyeovv0D4sHJHGCrUYYJOcsK+b
 oqTTNa1paZdsodv96uvTkmlGaAcf+ne/WjdlmVN0Xc8q8kq4eYGwH04VM9Y4bzXXhZq76w3
 aVNaey1C5qT3PVUIX7tTRo2bbADZPGzbU6/qBesiutooNXeifu616ZNAO57jDgKBTmBDfyr
 9Ls89uoehb9fzp5uoN0Kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iGfObSy1qAo=:RR4C/31CdVAh1XiX1Znoiv
 edvA7D1NvhprvicfCWREyEiivQnstWGl2Td73g1FICPtIQPv8rOt7nf2I7QIg4j2Ahyw8AiZz
 nqLONrMFUAqkln7z4VTddjpGFy3VkMxUu8D6oHPrmvu9N3GEWiTyzqOLJUHWMehITRWazH7+4
 FWFTuFvriODlunEp3+NYPuKPasTig5nH/wJisrs7F4c5yxMBl7C+VrjchQMuUIG5KN1+Qth/U
 aZ+F9rv6JUpv0J+gKwKmJmZJ85JIfXBHQ/GgLPXPcvb1/YLopKnBPb86HD3dF/iMacP8hBSXh
 L5bTLcja4PKwG6j2aXr5rvkC6+46Lx1MAHaI4uXIZhuHSvktLclkgJMFPNfGMFkGaUvqwNdd2
 2QfWPhSS3IUAyVGH929GkuLUw4O7VObsEtC8FdDdVzt0m1HBynJurvI+8J/dcnnRPKmgCFWfP
 SlV3og62ssuW9z5KDBRsRA1wLnXzLYrSqJFOrj8r6RbxBu7hLBdKgWO2Wa8+AvkOQJud29NBJ
 NPQL5rwyD+3tUQMMWspjLa+179d+Jjs/f5ShWeydbgQPWnAOqOtXFWcE4+PRIj26tQcJFB1nr
 NPTQja+xwPLWrjGBlAuMfgJx4G/qAHYW9feTloxlmKXlFn9A5qQSwidSHfD4YBZuwecLG4jis
 GJNgVYPlSR7Iy+zaQZ8OxVIrt89Q7x3jpqfkN1uxxMx9Rs6tpESuTWxEaeyB4thf4RmnsYE+B
 dpEjA6U4HiQsE9LHqgCJyqY6A4pul4gS77L7/W5sG0aUtT9+rBWABdONUwI2dnuKo/44tnK+d
 11MoJWi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 6 Feb 2017, Junio C Hamano wrote:

> * sf/putty-w-args (2017-02-01) 5 commits
>  - SQUASH???
>  - connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
>  - git_connect(): factor out SSH variant handling
>  - connect: rename tortoiseplink and putty variables
>  - connect: handle putty/plink also in GIT_SSH_COMMAND
> 
>  The command line options for ssh invocation needs to be tweaked for
>  some implementations of SSH (e.g. PuTTY plink wants "-P <port>"
>  while OpenSSH wants "-p <port>" to specify port to connect to), and
>  the variant was guessed when GIT_SSH environment variable is used
>  to specify it.  Extend the guess to the command specified by the
>  newer GIT_SSH_COMMAND and also core.sshcommand configuration
>  variable, and give an escape hatch for users to deal with
>  misdetected cases.
> 
>  Stalled?
>  cf. <alpine.DEB.2.20.1702012319460.3496@virtualbox>

The latest messages in that thread are

- your claim that you never said correctness is pused to a back seat (when
  an earlier, detailed mail listed four priorities of your patch review,
  none of which is said correctness, so I did not bother to answer), and

- my answer that suggested to take a break because the conversation turned
  less rational: I had to point out that your objection was not really
  valid in this case.

I now see that you added a SQUASH commit (that was news to me, thank you
very much), and that you seem to still insist that the code should prepare
for possible future changes in the config settings that may actually never
materialize. (And that would have to be handled at a different point, as I
had pointed out, so that suggested preparation would most likely not help
at all.)

In short: unless I read any convincing argument in favor of said SQUASH
commit, I will remain convinced that v3, as submitted, is actually the
best way forward.

Thank you for your attention,
Johannes
