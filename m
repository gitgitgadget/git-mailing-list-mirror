Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0382027C
	for <e@80x24.org>; Thu,  1 Jun 2017 06:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbdFAGxb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 02:53:31 -0400
Received: from mout.web.de ([212.227.17.12]:58919 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbdFAGxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 02:53:30 -0400
Received: from [10.0.4.221] ([194.47.243.181]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lm4Z3-1dp6ZK14td-00Zdla; Thu, 01
 Jun 2017 08:53:19 +0200
Subject: Re: Git Daemon on Windows fatal error.
To:     Hector Santos <hsantos@isdg.net>, git@vger.kernel.org
References: <592F153A.7020403@isdg.net>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <4bf5ba9b-9a41-847a-9a59-df9d1f987637@web.de>
Date:   Thu, 1 Jun 2017 08:53:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <592F153A.7020403@isdg.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dMvsCTkspbaSUAvknx8RTuoK7LhTgjzL1pBYZklqS65cgnUqCLF
 4wr6Qu4j4EOu3DXFkghXyMl+MSlqylz20kMl9M1fAn/FwOh4Nevm0kKW+pvxw51QufD6rNi
 dnUK8u+fltXXJUQNbScj6mNFihGdSVdyLWQ1H+yL5aBJ2y8Ns/eX6ctkNk5SSP6C+vhOKTF
 1UaJsjGSZOwfNnAw7Qo4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ehwFXBIoWvY=:GxvRpc616Nx/uJNwPv0wWg
 Z7wzq5Q05h3ROXYVCly0dwx6MvabwHm83TVcPxwb989I+kPudZ6ZdFpzI87P7nJ91gK8kmOLe
 zU5DsSBjJDl3+jF56xL6rUbe1ECUlKr9hByTnhduGQj6kKYAcL8NUn11TnXANZ0KLigC9NGpS
 oJNTMgpi+vcQyPdcRv8jFDCNrgJmPkpqQF/VW4dmxNKCkfKZJs5W7Pv0kjf4x2AvjRnfDMxEj
 s7OqHWqmPtxe9J8sg/AemM511P54RwXscIZgZZaSCs30HeNwOPUj+KbQiOFBRfqZY/bO0emyE
 XnSjU+9vsKR4o9QJwMB509S40gb/l5idrpxZuyHRd3scklWyVxDG4S3FFVHsZRMcmoPMPtADa
 oU+VuGaMyLeLKMMNd7R8beGvNnNl/fu2tdQWYq2pDzUaQj8pQ9UVDI+7I+GolkgCEZpZK8r2m
 Gw2+Li0vFOp3LcLCzzn/vKasWeQQaR7hzSoN3xF818Mv3M/4f9+7T/EOY0KevrygYsuLAsupQ
 Ru6pJMorJmUmV5LCWxv6ypcjwkytrTfF3DrZnVAOsnbzYfLH0aKjPBm0FKPfEDkE4IciaSHxM
 J/7R8VSAx+7FHjsZ/S8gaZaXZ4g230KGRAbFqIz10g19a4+SkiVxlhD2PqnFTTNloy/9zY7dT
 8Bga5TiRnHdrQk39+kURAGJ5p37kpjT3UpHHMcJZW2qHsUN/lEqxe6MIeHlVqNWsPWaE79PjL
 qphCBhP/+UuNPvFzeegNNEu8yCpaVb/NPml6NNHRb4r3ve+6IPjBNzXZyf2Y1whREzug71YlO
 zi0fpI0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 31/05/17 21:10, Hector Santos wrote:
> Hi, I am relatively new to GIT (coming from CVS and SVN) and I am trying to 
> setup "Git Daemon" on windows.
> 
> I got it working for Local network communications:
> 
> d:\local\wc5\testgit>git clone git://localhost/http clone10
> Cloning into 'clone10'...
> remote: Counting objects: 526, done.
> remote: Compressing objects: 100% (520/520), done.
> Receiving objects: 100% (526/526), 1.38 MiB | 0 bytes/s, done.
> remote: Total 526 (delta 81), reused 0 (delta 0)
> Resolving deltas: 100% (81/81), done.
> 
> but it fails over the wire when using the public host domain:
> 
> d:\local\wc5\testgit>git clone git://public.example.dom/http clone11
> Cloning into 'clone11'...
> remote: Counting objects: 526, done.
> remote: Compressing objects: 100% (520/520), done.
> remote: Total 526 (delta 81), reused 0 (delta 0)
> fatal: read error: Invalid argument
> fatal: early EOF
> fatal: index-pack failed
> 
> Sometimes its a different initial fatal error but generally the same. Once or 
> twice, a repeat MAY work, but often not.
[] snip

First of all, welcome to Git.
Second, which version of Git are you using ? And which version of Windows ?
Third, I don't think that this has to do with Git Daemon.
        When I look at "read error: Invalid argument", it may be fixed in the
        latest version.
        And that why it is important to know the version you are using.

And, there is a special place to report problems with Git for Windows:
https://github.com/git-for-windows/git/wiki (hope I got it right),
but please feel free to continue here on the mailing list.

