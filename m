Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E67C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658C164F33
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhCRLfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:35:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43581 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCRLet (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 07:34:49 -0400
Received: from Christian-PC.fritz.box ([109.91.254.15]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MEmpp-1lSZA22mhX-00GFfg; Thu, 18 Mar 2021 12:34:41 +0100
Message-ID: <c33f420348a795cec3314afb5d1d0bff706e3484.camel@avr-fun.de>
Subject: Re: Git install crashed nearly whole System
From:   Christian Strasser <christian@avr-fun.de>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Date:   Thu, 18 Mar 2021 12:34:41 +0100
In-Reply-To: <YE5bU18AExEHkwtX@meme-cluster>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
         <YE5bU18AExEHkwtX@meme-cluster>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m9HAwBFTgxQy2eOENaXBXpcChqhn4pSLm/tVWeZWkqapjv4b3Hn
 nncQ2F1SafVUhXL9Mz8aBJFydvhGd35USgalt6ePQnDZk2KHXVcQ9fvjB3Qyi8QMlaoi7lu
 wPw6QpnC+iPUBEdn+nG50K0je9NRANfq4ALp82MOy9xj2xA7R2BxX1NyR/lthNYDnQiZzJ+
 nRBdUjFie05F1n4EDjYuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Phwoz6ZXYo0=:299GBj84xmn8gFzr4jytK2
 N8JQ8lW8OHNkWNL88PyPsdJoAXM7+gyc0d24Y41ROac2r2a6D9SJD0NBWWtqvsGza8fsdckim
 /Nt+96AgtRTn5LsC7XRJZAp/IizBrd9/PGb6MrNKM9HAU/a4IyxOUSiViIR2/opxSfzC8BhDx
 RyIeiO393oIIWVUh9Hk0bn0zoK81BWrZ2ZkffxQnCV84t5KYbgJTWxL7IHfkMKDBAVH5KBwUE
 WXINLVhJnkA/YGoZVt5lwJ6qQEB/RGiWFz3atIvTzj3KPIUOUWP64BuNZ3IWEiPo9NtJFycVi
 NZCbDtRdTLu4c4PV2DZGxcipyUHxAs4QtLKtuo9Gb5H1ZGax7ZMjvKmulmyxcwRUm/DgXAAnr
 GKGvPVkWrsOT/PMNdyRMTfP7bYl9+EWe8N9iV5WaXOxMGZynwFhypYJ7L/LKRUvScbRcpv+Ah
 1S4uKYYCqg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Santiago,

Thanks a lot for your information. 

Yes, I'm sure everything happened after I run sudo apt install git-all.

Greetings,
Christian

On Sun, 2021-03-14 at 14:52 -0400, Santiago Torres Arias wrote:
> Hi, 
> 
> On Sun, Mar 14, 2021 at 07:23:40PM +0100, Christian Strasser wrote:
> > Hello all,
> > 
> > I installed Git yesterday on my system. For that I used “sudo apt-
> > get
> > install git-all”.  
> 
> I'm not sure if this list is aware of this specific debian meta-
> package,
> but this reads like a scary packaging mistake that needs fixing asap.
> I
> think this would probably be sent to the Debian packager for git-all.
> You can probably ask the people listed as uploaders in here[1]
> 
> > During the installation a lot of very important
> > packages got removed! It was horrible, and I couldn’t use my gnome
> > desktop environment at all! A lot off dependencies got lost!
> > Fortunately, I could save my system through read out the
> > information
> > about removed packages from the apt history.
> > 
> > Today I totally removed git and tried to install everything again
> > with
> > the same instruction. The same misbehavior did happen! 
> > 
> > For more information I added the history as an attachment to this
> > email. 
> > 
> > Information about my system:
> > 
> > Kernel          : Linux 4.19.0-14-amd64 (x86_64)
> > Version         : #1 SMP Debian 4.19.171-2 (2021-01-30)
> > C Library       : GNU C Library / (Debian GLIBC 2.28-10) 2.28
> > Distribution    : Debian GNU/Linux 10 (buster)
> > 
> > Gnome           : Version: 3.30.2-11~deb10u2 (apt-cache show gnome-
> > shell  grep Version) -> 3.30.2
> > 
> > Best regards,
> > Christian
> > ...
> > Start-Date: 2021-03-13  19:10:24
> > Remove: gnome-color-manager:amd64 (3.30.0-2), gnome-session:amd64
> > (3.30.1-2), gvfs-backends:amd64 (1.38.1-5), gnome-control-
> > center:amd64 (1:3.30.3-2~deb10u1), chrome-gnome-shell:amd64 (10.1-
> > 5), rtkit:amd64 (0.11-6), gnome-software:amd64 (3.30.6-5), gnome-
> > settings-daemon:amd64 (3.30.2-3), network-manager-gnome:amd64
> > (1.8.20-1.1), gnome-sushi:amd64 (3.30.0-2), gdm3:amd64 (3.30.2-3),
> > network-manager:amd64 (1.14.6-2+deb10u1), packagekit-tools:amd64
> > (1.1.12-5), gnome-tweak-tool:amd64 (3.30.2-1), gnome-disk-
> > utility:amd64 (3.30.2-3), gnome-tweaks:amd64 (3.30.2-1), gnome-
> > music:amd64 (3.30.2-1), udisks2:amd64 (2.8.1-4), gvfs-fuse:amd64
> > (1.38.1-5), nautilus:amd64 (3.30.5-2), gnome-shell-extension-dash-
> > to-panel:amd64 (18-1), systemd-sysv:amd64 (241-7~deb10u6), libpam-
> > systemd:amd64 
> 
> These last removals in particular look rather bad, but I don't see
> how
> they could be triggered by downloading git-all. Are you sure this
> only
> happens when you run apt install git-all?
> 
> Cheers!
> -Santiago
> 
> [1] https://tracker.debian.org/pkg/git

