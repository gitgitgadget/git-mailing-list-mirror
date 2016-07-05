Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F37120706
	for <e@80x24.org>; Tue,  5 Jul 2016 18:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbcGESGQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 14:06:16 -0400
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36350 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbcGESGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2016 14:06:15 -0400
Received: by mail-vk0-f54.google.com with SMTP id m127so215337941vkb.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 11:06:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FdTwLlO5hyOYHCncMuqLOfvfkkxQKR9dbWF/xhdltRg=;
        b=zFdjA0xMpz3NEc26m4QslmmiLL8v+sMbXvWU/6n0Om7lF0AOQdHyPWyxAg3fviDeXz
         +d8msD1aMD/i6qweImwqd0aVo1Ooiv6eMIkQra1kQrlBJVlZg2gjMpkilz7oEvBHg0Y6
         RFaw+eaIbXBgKrIVRr9bvwC4sqjYrYpg7Yqh19IQ5XRjFlgGrgNqC0QHfZOsUwXw3idd
         pD1HltnK4Z2JNFmYOja48zrvZ3PZ8XA5H2PatOv99QCA1z4506+fLXbeLa2bfBf28MN+
         RlRpl6NXfx4ZOQ/mkEVw9MFQH8bPxq5if64KS9dEY3m195vI8/65d/lHJu2mbNuZn9+D
         1gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:sender:in-reply-to
         :references:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FdTwLlO5hyOYHCncMuqLOfvfkkxQKR9dbWF/xhdltRg=;
        b=fgir8dcVyVpnF0iuWAAXyT4v2D2X1X0lZm7uArkdr9lcxSyjzVtH709jLvvJKVc0SV
         Pfuc3j9SwTgUMZqfs/4exfdYk/iJQ1TPHZ8s/pfRS84tPAJBjaB8COJI0bw57+YnGQEZ
         9mXZSqcKpSlFNgbsiBRKhYXjxfMy2aymOtGJV6IeHAVjgR0giT74devxi3L4yUR1vqH3
         og+1dAGuJUCKJx1tD3qtTLoA2QX2RJJNe09C53vD3uRyDp3ihr3ns+fzaXdkzL0sn6N6
         4wGPRIxXD1RtjhcaBlSeNepi0rx2bL/LcVaymNmZXSfHBte6AsItgo/fZ+MKNdEuib/P
         jZ0g==
X-Gm-Message-State: ALyK8tIJSil4jrCdZLQnFYRVrsIeY2EfC5wuPKcNEqwyeSDgiWXDxcWGA6lSFTUA6CBM/4YpqndouMICQ4YpjQ==
X-Received: by 10.31.142.76 with SMTP id q73mr8486035vkd.100.1467741974451;
 Tue, 05 Jul 2016 11:06:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kpaxton@paxdesigns.com
Received: by 10.103.110.131 with HTTP; Tue, 5 Jul 2016 11:06:14 -0700 (PDT)
In-Reply-To: <1467741182.14863.6.camel@kaarsemaker.net>
References: <CAOkrQrwH=Rj4OS4WphGqzc07hjFBB4B9BFy92qPWdJfB70KPnA@mail.gmail.com>
 <1467741182.14863.6.camel@kaarsemaker.net>
From:	Kevin Paxton <kpaxton@paxdesigns.com>
Date:	Tue, 5 Jul 2016 14:06:14 -0400
X-Google-Sender-Auth: Kr_UVIG7X-ffEobHhQ43-SvBRO0
Message-ID: <CAOkrQryazf=38eUMjcZzByjk=OVNfFGpFKnp5zpyML7yDKhW=A@mail.gmail.com>
Subject: Re: Dependencies required for offline installation
To:	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thank you for the response.

I apologize. RHEL 6.5, not 5.5.

Would the same version be applicable to 6.5 as well as the
dependencies that you mentioned?

On Tue, Jul 5, 2016 at 1:53 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On di, 2016-07-05 at 07:45 -0400, Kevin Paxton wrote:
>> Hi,
>>
>> I’m looking to install git on a separate network that is running
>> Redhat 5.5.
>
> That's ancient and unsupported. If you insist on using rhel 5, at least
> do 5.11 so you get the security updates.
>
>> I need to know what is the list of packages that I need to
>> download to be able to install git-all? I plan on using git-svn to
>> migrate an existing svn repo over to git as well. Svn version we have
>> installed is 1.9.3.
>
> There are rpms for git 1.8 in EPEL. git-all is probably overkill, but
> you'll need at least git, perl-Git, perl-Git-SVN and perl-Error.
>
>> Does the tarball contain all dependencies already? Should I go that
>> route? Or should I try and find all the rpm's required?
>
> The source tarball of git contains no dependencies. Also be aware that
> building git from source requires even more dependencies.
>
> D.
