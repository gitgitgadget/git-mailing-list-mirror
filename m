Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAF2C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 00:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376789AbiFWArQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 22 Jun 2022 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359642AbiFWArO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 20:47:14 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Jun 2022 17:47:13 PDT
Received: from omta014.useast.a.cloudfilter.net (omta014.useast.a.cloudfilter.net [34.195.253.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E5E41F82
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 17:47:13 -0700 (PDT)
Received: from cxr.smtp.a.cloudfilter.net ([10.0.17.147])
        by cmsmtp with ESMTP
        id 417yoG0g0ScQd4AycoPiQV; Thu, 23 Jun 2022 00:45:42 +0000
Received: from thunderbird.smith.home ([70.176.251.46])
        by cmsmtp with ESMTPSA
        id 4AyaoyGbq0VDM4Aybosgpq; Thu, 23 Jun 2022 00:45:42 +0000
Authentication-Results: cox.net; auth=pass (PLAIN) smtp.auth=ischis2@cox.net
X-Authority-Analysis: v=2.4 cv=Eenb/dqC c=1 sm=1 tr=0 ts=62b3b7b6
 a=OCGoW4wscCDr3YEa6K7Wzw==:117 a=OCGoW4wscCDr3YEa6K7Wzw==:17
 a=8nJEP1OIZ-IA:10 a=JPEYwPQDsx4A:10 a=6XUDo1k8oTiJZPsL8bIA:9 a=wPNLvfGTeEIA:10
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 2E0E81961EA2;
        Wed, 22 Jun 2022 17:45:40 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.org>
Subject: Re: SHA-256 transition
Date:   Wed, 22 Jun 2022 17:45:40 -0700
Message-ID: <12092182.O9o76ZdvQC@thunderbird>
In-Reply-To: <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
References: <12011256.O9o76ZdvQC@thunderbird> <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com> <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-CMAE-Envelope: MS4xfAGUBxA57x3Xd4EN3QcFXDCD4dpQI8C4DvxRn/UnxDBEiK9JT5AvxTlfWDPpnYtLxBGcV31Y7CTK/EYkpLRH5LOv6giKH6hGQIAI5AMZJq6sZVGj5jeI
 LjFOIzqmbAY/+soYY+gy9FFPh99r+KItDGP53s6Hb0M6ijjv6vsVMO9Rp30gEIqMdDKCUTbefZ2g4xKkLLEjxZyj/j1ZUYfaqtJ1EuIj7UkBXmsJX5AMvzWU
 dpWmVS6w6O4ygEwOqeLqQmn6f/KUGyqGsGpIOuUuCYLuWi59pNerteSURO16OyUKFcwisHZh9UEoarVDhu8Jxw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, June 21, 2022 5:29:59 PM MST brian m. carlson wrote:
> On 2022-06-21 at 10:25:01, Ævar Arnfjörð Bjarmason wrote:
> > But the reason I'd still say "no" on the technical/UX side is:
> >  * The inter-op between SHA-256 and SHA-1 repositories is still
> >  
> >    nonexistent, except for a one-off import. I.e. we don't have any
> >    graceful way to migrate an existing repository.
> 
> True, but that doesn't meant that new repositories couldn't use SHA-256.

So, any idea when a graceful way to migrate a repository might show up?

> 
> >  * For new repositories I think you'll probably want to eventually push
> >  
> >    it to one of the online git hosting providers, none of which (as far
> >    as I'm aware) support SHA-256 repos.
> 
> This, in my view, is the only compelling reason not to use it for new
> repositories.

Which is a reason to send patches by email. 




