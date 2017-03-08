Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18337202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbdCHRqx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:46:53 -0500
Received: from mout.web.de ([217.72.192.78]:51433 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751616AbdCHRpX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:45:23 -0500
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZlG-1cv3R72Avy-009RS4; Wed, 08
 Mar 2017 18:36:55 +0100
Subject: Re: fatal: Could not get current working directory: Permission denied
 | affected 2.10,2.11,2.12, but not 1.9.5 |
To:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
References: <elvahoiwfqayelbskykd@qjih>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org
Message-ID: <7d947891-ce40-23e7-2bc7-0f76dee53665@web.de>
Date:   Wed, 8 Mar 2017 18:36:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <elvahoiwfqayelbskykd@qjih>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xb4gkBgil6hMxijdNtC39YMvviuWgamL1jEizerzsDlDD5b3BW4
 8xg+WNMwsSOMvVTOxFjEah9da1rSD4BlfZeEbbpIPfJKay+2gO4MwO4sxdjBuv8f2PbaIiJ
 eWqsvbDBEq9fVry8acrZTfJXRM/w5QEL7yPv4nykxcQc0T9QKDeeHYZ2FBdfex1IQazklXC
 KF/G9JugmIbzi7z3SkT2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HKgdHmnTEN0=:hJRnA9N2OdsuTnNgoPsDg4
 BbUtjof1J7+QElvfdXcptGRxY5dhIQYtrRXGGgEWDnMdsDLth6nZ6mOJ9mLVf2j4vscgMa/M8
 qtWAmEXpMTrDuNSHvxj9PdNTfh5lxFSaZTe/mXtvCCneAG4/jCphzWmn0dfTlQP22CjZFYQLA
 RIbZTe7bEQ6GQQOKDxhMn2FZ19a2qeUYovj1aGvxAZiwU3vh4CVWGq85kTWvY1eoV8we3K+W9
 rL/UB+GWCVDoVqEU5iXvNtZiU1A2aWWt2iKGD9cNXGNi9Qk4dcFjhH985FR4fOBHswMv0fwLi
 Ka3gP5XKQ2UT7Zv1cRnrUAAHE3GlU0iVULdHEolAbE32rT/5DyMOh3YvybXjeyVGzcDXBayc4
 9OobUGYJkb6eUx8Viw791ZpoXwhnrlXJbMC/7czM7oLeVya80tnKv4jr064yZw9aElL9XE4BE
 Kydsf/SrlbcqxuQQjCppw7c21QA1CKC3xRAFCwQ6Cj0g2lIZ1gCj4+nlBml/chQDDwIU52fba
 FYNPP4DXb938RhITyCFt+FDnkGR1Vcrm5X51CF/DLwv7zpgCQBz9Q1ZOnXcFz9HOf5SM6QSW3
 TXu20dxvORFDPcPIS8Dwot0YEjdez/Vm8bcJM73qtd9+5v0praEpSMrRJToFPBkTZp6LCDQKR
 Xj72f5tTI+g3wrt/wowXkCtlOOhiz2+pOabYds1Js5QeDSia/br0VYmn4z0yw3cfgdtnCPvDZ
 d9eVAVmHs79pjfE6ZIyTqYmfl7hBVmNw4Hcf+knOI91ztWR66UwZX4lGDkcWHXfkpRBd1AmF4
 CoOawvd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.03.2017 um 17:10 schrieb Zenobiusz Kunegunda:
> OS: FreeBSD 10.3-STABLE
>
> Story: I was trying to install openproject using this manual
> https://www.openproject.org/open-source/download/manual-installation-guide/
>
>  Everything was fine till command $ bundle install --deployment
> --without postgres sqlite development test therubyracer docker
>
> works witg git version: 1.9.5 ( branch from repo ) does not work with
> git version: 2.10 ( branch from from repo ) 2.11 ( both from FreeBSD
> and from git repository) 2.12 ( branch from repo )
>
> On another server that passed but there was npm problem.
>
> This is error for $ bundle install --deployment --without postgres
> sqlite development test therubyracer docker

I suspect you might get better responses from the makers of bundler 
(http://bundler.io/, http://groups.google.com/group/ruby-bundler).

> Fetching dependency metadata from https://rubygems.org/. fatal: Could
> not get current working directory: Permission denied
>
> Retrying `git fetch --force --quiet --tags
> "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"`
> due to error (2/4): Bundler::Source::Git::GitCommandError Git error:
> command `git fetch --force --quiet --tags
> "/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7"`
> in directory
> /usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2
> has failed. If this error persists you could try removing the cache
> directory
> '/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/cache/bundler/git/awesome_nested_set-209215f38dc7f6765d32201897f8688e973f4de7'fatal:
> Could not get current working directory: Permission denied

These long and repetitive messages make me feel dizzy.  So git fetch was 
executed in 
"/usr/home/USER/openproject/vendor/bundle/ruby/2.2.0/bundler/gems/awesome_nested_set-7bd473e845e2" 
and reported that it was not allowed to get the current working 
directory, right?  That's odd.

I suspect that older versions of git ignored the error, used an empty 
string and went with that instead of an absolute path, but that's just a 
guess.

Was git perhaps started by bundler under a different user ID?  You could 
check that e.g. by printing the return value of geteuid(2).

"/bin/pwd -P" executed in the same directory under the same user ID as 
git should error out and report "Permission denied" as well.  Are the 
permissions bits and ACLs for that directory and its parents OK?

Thanks,
René
