Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D013AC433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B80464F30
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCRJzH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:55:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33587 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCRJzC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 05:55:02 -0400
Received: from Christian-PC.fritz.box ([109.91.254.15]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5VLY-1lkfhv1vwI-016uLX; Thu, 18 Mar 2021 10:54:37 +0100
Message-ID: <4caa629a19be9fe7134148764a3a9dbc5167cef0.camel@avr-fun.de>
Subject: Re: Git install crashed nearly whole System
From:   Christian Strasser <christian@avr-fun.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Date:   Thu, 18 Mar 2021 10:54:36 +0100
In-Reply-To: <00a701d71917$6d624d20$4826e760$@nexbridge.com>
References: <8aa7be071abc23371397f72b725babc4e4e90190.camel@avr-fun.de>
         <00a701d71917$6d624d20$4826e760$@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NDOm1R4yubgVUDt2mwdVPZP3CCl6KZe+4u8aNlnS21vAq9Z5g64
 l0uSu4wf3vzxKe9iL9SyA4WsNcYP0QyAFo0Vg5uJ9tx69FiYSvnJos7+FE6u8LaOdH+348i
 SaWmiI5eTIeWairifrTCcqidx9Vd1+xlFpWVuephjjK0HDyxPcpG+JGxiOAEeZLWZvdjLRi
 VQ0d/2Ufwc/Hr3AgaS2Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eM5lN5sbyyw=:Nrmq+3TUddDNb1gYOzLe+o
 xcitC54+r96qZwMyZzkPXzZU7fndcvBeCC9ByPO71qySS5hHNkdekTFw8S6ExRvGSMlQjRqIr
 B9KmqLQ2VpuQluur8mXg3jihtHi5eMUnnUCWYOJtiV7y6DzHRT1NcArqsokaii2G51OtqvFtQ
 n8X5o+OLENjMmJ/H8bfnOfety52THpgk604hEXEWJHs/iIoDN4K3k22YCmYBLVZhjTvMferp/
 osjBuu2vPlV3k+WfMcJL+QmkHxyMVX2K7uSkVRNjlh11QbOju2rw+FhIw/YhQtXJXZ0WBU31j
 o+Ozdh3PLxdRH0iFG9qdaiR0eaRIjN0r2/pVmauIVkPiXvMJu6bPEzMfSzpbKkASSqn8OO7qz
 MkNrd7ZtcyzWpN3cudRDaq5DpJx+94PQslSUW33jfcx6YO6BeSay4E8pNFU+5rhIJD+J2lQpP
 WDrKg4jthg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2021-03-14 at 17:17 -0400, Randall S. Becker wrote:
> On March 14, 2021 2:24 PM, Christian Strasser wrote:
> > Subject: Git install crashed nearly whole System
> > I installed Git yesterday on my system. For that I used “sudo apt-
> > get install
> > git-all”.  During the installation a lot of very important packages
> > got removed!
> > It was horrible, and I couldn’t use my gnome desktop environment at
> > all! A
> > lot off dependencies got lost!
> > Fortunately, I could save my system through read out the
> > information about
> > removed packages from the apt history.
> > 
> > Today I totally removed git and tried to install everything again
> > with the same
> > instruction. The same misbehavior did happen!
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
> 
> I think it might be appropriate to report this to the apt team. The
> links can be found here: 
> https://help.ubuntu.com/community/PackageManagerTroubleshootingProcedureshould
> 
> I just (2021 Mar 03 2115Z) ran apt-get update and apt-get upgrade
> git. Yes, it did upgrade a whole lot of packages, including ansible,
> git, syslog, openssh, and many others. The apt manager for ubuntu
> only appears to know about git 2.7.4. You might have to add the git-
> core repository using: add-apt-repository ppa:git-core/ppa -y
> 
> After I added that, then ran apt-get upgrade git, I am now on git
> 2.29.0. Granted this is Ubuntu, not Debian, but apt should be ok. I'm
> not sure about the "git-all" package. I have never used that one (not
> is it certified at my place - just "git" is).
> 
> Regards,
> Randall
> 
Hello Randall,

thank you for your reply. I'll consider your suggestion.

Regards,
Christian 
 

