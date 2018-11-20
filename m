Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1731F1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 10:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKTVE6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 16:04:58 -0500
Received: from mout.web.de ([212.227.17.12]:54931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728119AbeKTVE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 16:04:58 -0500
Received: from [192.168.209.20] ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MUncu-1fxTzH1XbA-00YA1D; Tue, 20
 Nov 2018 11:36:15 +0100
Subject: Re: Cygwin Git with Windows paths
To:     Steven Penny <svnpenn@gmail.com>
Cc:     gitster@pobox.com, rsbecker@nexbridge.com, git@vger.kernel.org
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com>
 <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan> <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
 <005801d47fad$345d5a70$9d180f50$@nexbridge.com>
 <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
 <bddb9e06-2688-c459-9467-a3f0978866f9@web.de>
 <CAAXzdLXCEeZdkCXT+-0n=Fn7_=Nz5cm+6xr0w-cd6B1om028uA@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <9bee0f47-d1fb-c483-2597-d8edb1ed36de@web.de>
Date:   Tue, 20 Nov 2018 11:36:20 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAXzdLXCEeZdkCXT+-0n=Fn7_=Nz5cm+6xr0w-cd6B1om028uA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IRmReQwSJ142XkA4w0JMoCJ1gcLeyh0eooRx6MFiOnKpo7hj1xw
 493jNGTEFMyjGP+UVPN8d+oY0GT20oreM03dSyDy8l1WX2kZUMDr9cmh+SyZQsrlvNQ0uij
 ihqCFpDP/wdwooX2fbovDmskQ1CMz6h74/N4OFkTp5wMTFsP7pR2nyz8nRjCSgWMqeG5712
 jXwYIkHZbCbE3ArdI6FMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:njbTwoFJtyY=:quvgp0+Hu0YLJMHM10YloH
 W4Yfth/MehHaFtorxvIOqBypGsoSH6GM1occOy2mayx81brRLDV+ZaYOQXtYYqUREVzwe+Kjf
 iK17r1vZeLoECGMawDx1DP8FnLDthbQAvVyD2blg4crqescHSmBtuWT3jptE8hKREbuCGpTlG
 K3oojVXmk9bec+5DlKXuHylWsLHEjo3fyU7Sc9Mwo2hXxez0plEYL05gc1O551J3cnuKCIS6J
 oTmb1zL2aEFwbBSLUWT4NBDSNAfYAkDrTA7CfenXvOY0KPYk30qexekDOlw3iJlFacaYIBIH+
 X4YbS3SPDzJSucmXCBb7EkGWAq8IigaAMb69LRGVQqRi8Q6UX9HzZMz1v1hYFFZGRhtcDCOS6
 Ti1BpTCRwMhp6Vx6xVBz67sJrouzWClut6K8r4yAKVj4ec463om+awyYTOj2COdSioNmEa1Nq
 LcMUy7VwWnJJGviQ/wb2fM1XtSrf3cslHEq2qsNbEMdTHIF5Oc7KEL2lg0tEHPSFUhcc5+mHA
 UgSydnYZblwNbQyCYcWMHhIBnxRe0IZLUJgK8f7TyvQ+rbMcHBcN8+RsC+bigoMa27aLlP3VH
 luaxwWOnv7Oqw+IJbjcGMEtqiXT9Mkv2aQCiXEof5ONleMWGizI07M/tflW620ghIcsjdh1M8
 Fcv3iTeWDKI+sT8g6rjSN7BopKomCqUiqxf5VFr++TFxuw3DTMmictNk7iNYmVTreAzCbY5Cs
 ze8lPOuQNuhlw3mSf+mHeAWHifj+g4NBVvbx0n20Ct27fsTzoRZJ7lf9ehgrrKNVaMSKsJ8ud
 yB7ZufAK9W50pHPaKFOvfyMcYrEfE4nkd/nMKSlq7MipBXftd1PQlY0Bc/XwpiSyYxjK0lC6H
 gRVKW4Um5Eyrx4NM+bbLkeOLbUqCGy94nlQwKV1WjcpWQ1B+NORhOspl75DSMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.11.18 01:17, Steven Penny wrote:
> On Sun, Nov 18, 2018 at 11:21 PM Torsten Bögershausen wrote:
>> If nothing works,
>> it may help to add some fprintf(stderr,...) in the functions used
>> by 05b458c104708141d2f:
>>
>> strip_last_component(),
>> get_next_component()
>> real_path_internal()
> 
> I didnt see any "real_path_internal" in the current codebase - however i added
> some "printf" to the other 2 and got this:
> 
> $ git clone git://github.com/benhoyt/goawk 'C:\cygwin64\tmp\goawk'
> get_next_component, next, []
> get_next_component, remaining, [C:\cygwin64\tmp\goawk]
> Cloning into 'C:\cygwin64\tmp\goawk'...
> get_next_component, next, []
> get_next_component, remaining, [C:\cygwin64\tmp\goawk/.git]
> fatal: Invalid path '/usr/local/cache/git/C:\cygwin64\tmp\goawk': No such file
> or directory
> 

Could you please post a "git diff" of your instrumented code,
so that I/we can follow the debugging, especially what the printouts mean?

I think we need to understand what is going on in abspath.c

