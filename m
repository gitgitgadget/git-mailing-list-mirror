Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4F2E1F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755440AbdKNPUh (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 10:20:37 -0500
Received: from mout.web.de ([212.227.15.14]:54215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755426AbdKNPUf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 10:20:35 -0500
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHYLM-1eDWYP2QZw-003Ip2; Tue, 14
 Nov 2017 16:20:33 +0100
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
To:     Ashish Negi <ashishnegi33@gmail.com>, git@vger.kernel.org
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
Date:   Tue, 14 Nov 2017 16:20:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:o5xhk4WScsCLSscB89D7SEG1t3uVq/0lvTyBn5GueU4q7hzpW+d
 7KGi1qISxUjx2J0L/UyBEbaqHUWJLO7t/O7qS4a4+V7MS3ZRk1ePh2FgkQPEFjz9nSfvZi8
 V+XMCTF3P6pu/x7jltMHU3SEgqxg7Q2ecxh1XZ05fPwHc4FyzEqYq9VgVPfsDW6I5M4Ec5u
 woMGIaoGHeGQLVzmmJXCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cqYZLpVkC7E=:/C6HxsTXkn7aZ+jwugneKC
 mIrAR9yvv+HxckE2dcpKbl8243gCK85xHSPI305i+pg71PXVJN1FWpeB/uEV+6ROaVOugfhEr
 wPxosHlP8I4LvtNJeohi+oe92/g0NiRtUKVy96Gape60LOfErydKe1gI2Q/r41RSvGXl8kXzB
 eQdgOvXuC6UliaP71+asMGkoUSSFBCo0N9REg7mCeLxjQGF2l8qcxt7X02bXwCzmK8cvO5CCe
 N5NwIwwjEfWb3DIRUYGBYMFAuKsRcqnTp+XDgXYPTC4DmBTomYvQ5VBw1b7z8VogyQXgDBKvi
 F8UANOXdWd8M3gUNIeMfcY69YNTMb9zB+8q906JCoWu958FkT2j9GSHpmcBjyHPCeXV3fxfVD
 Fm4J68pe6MmE0AE8Zp+C+eSYagO/lQhixQ+MaBr43/wFOehRaF/8OsbgW3FBcT4xM2pRBfKTi
 9jyNGuqFZlO1cDn4nl6ijlr53TaeFqZuYTezjoZUCkIKfyT0U4F+APjSI48Pc8ETgV3RArzYM
 rhybTC4vrv5uo2vKzSt2weK7BkbN7U/5s+Ickn5bhNtLF4ho4S/lxh/aXMuq9mAUKQKZfOy30
 LBm+shGH4/c9hMxQ5xtoJtp/BEj0qjnrX1inVeK2Pk1sTlYmFaksOUmR8tTrcuYM4fYzDaoRV
 DojPIzhmFVGCHAt52FVMSS6cx2/fMLiWkAcqSna0KcX/6N5eRl0X9m7Y0/NuBqrisRXnxaagY
 4ATeW6Q3ZTxDoNI/sQtVQufZzv/goM4s/JYUGVIQakHOo/lqXlQMXpcpOuamcjcn7tCu8lw7l
 6rwgvLM+n9CMXQScouvtNyivxCt78RQ42gLVuNEHuBnI5/j42Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-11-14 13:31, Ashish Negi wrote:
> Hello
> 
> I have a cross platform project. I have a utf-16 file in it.
> I changed its encoding to urf-8 and committed. When i pulled the file
> in Linux, it shows that file is modified. This means that the commit
> which changed the encoding does not convert crlf to lf, when new
> format is text based (utf-8).
> 
> Steps to reproduce:
> 
>    In windows :
> 
>     Change encoding of file from utf-16 to utf-8.
>     Commit the change.
> 
>    In linux:
> 
>     Pull your branch.
>     You will see the issue of file being shown as modified even though
> you have not used it.
> 
> 
> If i change the file encoding in linux and commit. Then if i do git
> pull in windows, i don't see the issue.
> In linux, during committing i get warning : warning: CRLF will be
> replaced by LF in …file_name..
> 
> Here are my configuration :
> 
> 
>> git config --global --get core.autocrlf
> 
> false
> 
> 
>> git config  --get core.autocrlf
> 
> false
> 
> 
> 
>> cat E:\work\WindowsFabric\.gitattributes
> 
> 
> # Set the default behavior, in case people don't have core.autocrlf set.
> 
> * text=auto
> *.vcxproj eol=crlf
> *.sh      eol=lf
> 
> # Denote all files that are truly binary and should not be modified.
> *.exe binary
> *.dll binary
> *.pdb binary
> *.ico binary
> *.png binary
> *.jpg binary
> 
> 
>> git --version
> git version 2.14.2.windows.2
> 
> 
> I played around with core.autocrlf values like true and native, but
> that didn't help.
> 
> The behavior is inconsistent across platforms, and windows version is
> giving me problem.
> 
> Can someone suggest right settings for this ? Or is this a bug in Git.
> 

I don't think it is a bug :-)
What does
git ls-files --eol …file_name
give you under Windows ?



