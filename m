Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A57C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhKXUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:48:20 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17463 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhKXUsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:48:13 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AOKig6x044029
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Nov 2021 15:44:43 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, "'Junio C Hamano'" <gitster@pobox.com>,
        <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqq7dcx1ent.fsf@gitster.g> <000201d7e173$3eb3d320$bc1b7960$@nexbridge.com>
In-Reply-To: <000201d7e173$3eb3d320$bc1b7960$@nexbridge.com>
Subject: RE: [ANNOUNCE] Git v2.34.1
Date:   Wed, 24 Nov 2021 15:44:36 -0500
Organization: Nexbridge Inc.
Message-ID: <000301d7e174$1b568570$52039050$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHLMPeZyQzNqkxJMp5NZJ0GWXnoyAHsQPH9rB0kD4A=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 24, 2021 3:38 PM, I wrote:
> On November 24, 2021 3:29 PM, Junio C Hamano wrote:
> > Subject: [ANNOUNCE] Git v2.34.1
> >
> > The latest maintenance release Git v2.34.1 is now available at the
> > usual places.
> >
> > The tarballs are found at:
> >
> >     https://www.kernel.org/pub/software/scm/git/
> >
> > The following public repositories all have a copy of the 'v2.34.1'
> > tag and the 'maint' branch that the tag points at:
> >
> >   url = https://git.kernel.org/pub/scm/git/git
> >   url = https://kernel.googlesource.com/pub/scm/git/git
> >   url = git://repo.or.cz/alt-git.git
> >   url = https://github.com/gitster/git
> 
> In an unusual situation, make reports:
> 
> GIT_VERSION = 2.34.GIT
> 
> Instead of the expected
> 
> GIT_VERSION = 2.34.1
> 
> which we see usually.
> 
> Am I missing a step that was added since 2.34.0?

Oops. I have to build off 'maint' not master. Got it.
-R.

