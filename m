Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909B420986
	for <e@80x24.org>; Sat,  1 Oct 2016 15:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbcJAPeM (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 11:34:12 -0400
Received: from mout.web.de ([212.227.17.11]:58094 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbcJAPeL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 11:34:11 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Maaur-1bWDuo0LGL-00K5qA; Sat, 01 Oct 2016 17:34:07
 +0200
Subject: Re: Impossible to change working directory
To:     Sebastian Feldmann <sf@sebastian-feldmann.info>,
        git@vger.kernel.org
References: <A99D7D06-8214-4C09-BCB2-E4FCE75FF317@sebastian-feldmann.info>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <477492a9-7ff2-59d0-1463-b47694ce66c1@web.de>
Date:   Sat, 1 Oct 2016 17:34:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <A99D7D06-8214-4C09-BCB2-E4FCE75FF317@sebastian-feldmann.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xgKOaCvNsJUg73/Qwf8gcpiuYokVJnjRYD835nDrCF8J0ePnDs/
 ni5x1c23HbQOaB6B//n7a9oFnWm/4C+qvGPwk5cn4Wd+7GXIC6LWAxnrv7YijeTi+OU2e5M
 +17DTQIVgrr0bOIJ7HE9QFz0acjMspSMoq/hxZLbTvcVBqVlQ3NjCYydw4RTniz0HDnRDoR
 dptY4wncogLvfrZASBzbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IcNN05oYZAY=:VMcUseNxpTR4AiQZV4b2Zu
 Ijuhb+BWZygQbZPWet4pbFKvfloWmgiKEm79d4DztL8fhiM37uHVaTWjf5tCaWIN7/Fkh9VsF
 eTyvB63r2n8UKf4OBm51nrARKLdY6UUj3qOsiwZhqJG8BPFMNnP0UHXbVQ463Fx38aiSxJcnw
 PsbnN7VhnFOw3BrFkfeo5bZddKhUfKUvgd+if3PlmtZJbRxChazyOrkzy3I4gJMrVvr38o0sc
 +75xeRbddN4fDkKFhOJ/3MSBx3QmEoRhk+s5xEhKg6rEJaQcrBWF9jfmf+elLmc+MDhkThGJG
 EVK7h0x8PkM1RPFHC0uMywkORnozEmcJJu6o0MkBYm7fqE9XHxIxPDbl0tDYUstRLNSQHbEPO
 V9cbwCa9qS5xn8xnZPY2eP2jPLXUdTAxpcPn4GxVch2v6I+cnmNsqrCyKeJzGKsHpfhWEaRnu
 J9jSX7GT8GRlAtbMZQzK2k3TrX4JbjCiJKUHHpLWWYQKlODWAvDu7nevOKm1c9MITqCBmGaJ+
 BvQ837Vu9xMcT7GS10KEhru8pKHHWESALia/NukA3/OubpFpzDdGPN2Vc4ms7l8wg/r74ZDeh
 /U6v96yi/O9MDrpgadGwDyXwitisAw0Q37EtdWcMdfigKS0eH2NR9FERSoNN/CEOOtrtw3y9c
 63Mo2Tl1h+VaLtXsKLaDAwaS122+4Lka2C+hwdCJkFKlAl91hjwAbexj+liO9e0hk4tUyIVMB
 /fLazUnX3+fKFdrDcUrn+EoUXsnjOlZNNYW/DugMvxQ1gOibdhIwZLK7TZO6zAD11HacIp9zs
 1L2Oi7h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29.09.16 21:30, Sebastian Feldmann wrote:
> Hi there,
>
> I have a problem executing a pre-commit hook.
> The hook script has to change the working directory to work and if I use plain
>
> git commit
>
> it works as expected, the script executes without errors, but if I use
>
> git commit —only file.x file.y
>
> the script fails because changing the current working directory fails.
> If I echo the current working directory it always echoes the root repository path
>
> Is this expected behavior?
> Thanks for your feedback.
Is there any chance to send us the content of the script ?
(Or a demo example, which doesn't work)

