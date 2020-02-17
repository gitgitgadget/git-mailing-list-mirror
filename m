Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6439EC34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC7E207FD
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 22:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgBQWpm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 17 Feb 2020 17:45:42 -0500
Received: from elephants.elehost.com ([216.66.27.132]:22600 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgBQWpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 17:45:41 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 01HMjYPq070587
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Feb 2020 17:45:34 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <lyle.ziegelmiller@gmail.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
References: <000001d5e4e3$91ffb0a0$b5ff11e0$@gmail.com> <20200216211604.GE6134@camp.crustytoothpaste.net> <001801d5e5ae$e4375780$aca60680$@gmail.com>
In-Reply-To: <001801d5e5ae$e4375780$aca60680$@gmail.com>
Subject: RE: ! [remote rejected] master -> master (unpacker error)
Date:   Mon, 17 Feb 2020 17:45:28 -0500
Message-ID: <005501d5e5e3$f7082260$e5186720$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMhw4Eo4Ohz4QZPcWFj6oDqlRz55AI5bVuwAiHqTdKlZWX1QA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of lyle.ziegelmiller@gmail.com
> Sent: February 17, 2020 11:26 AM
> To: 'brian m. carlson' <sandals@crustytoothpaste.net>
> Cc: git@vger.kernel.org
> Subject: RE: ! [remote rejected] master -> master (unpacker error)
> 
> I wrote a bunch of emails about this in December 2019. Did they all get lost?
> 
> I'm consistently able to clone the repository, but I can never push to it. I used
> to be able to. I've explored all possibilities that I know of.
> 
> I'm using Windows 10, and the Cygwin version of Git.
> 
> $ git --version
> git version 2.21.0
> 
> Regards
> 
> Lyle
> 
> -----Original Message-----
> From: brian m. carlson <sandals@crustytoothpaste.net>
> Sent: Sunday, February 16, 2020 2:16 PM
> To: lyle.ziegelmiller@gmail.com
> Cc: git@vger.kernel.org
> Subject: Re: ! [remote rejected] master -> master (unpacker error)
> 
> On 2020-02-16 at 16:10:12, lyle.ziegelmiller@gmail.com wrote:
> > Hi
> >
> > Any updates on this error I emailed a while back?
> >
> > lylez@LJZ-DELLPC ~/python
> > $ git push
> > Enumerating objects: 5, done.
> > Counting objects: 100% (5/5), done.
> > Delta compression using up to 4 threads Compressing objects: 100%
> > (2/2), done.
> > Writing objects: 100% (3/3), 279 bytes | 23.00 KiB/s, done.
> > Total 3 (delta 1), reused 0 (delta 0)
> > remote: fatal: not a git repository: '.'
> 
> This error is telling you that Git doesn't think the remote location is a Git
> repository.  It could be because it really isn't one, or it could be that the
> permissions are wrong.
> 
> It could also be that the repository is mostly there but very slightly corrupt
> and therefore can't be detected as one.  For example, it could be missing its
> HEAD reference.

It also could be that the security setup on the server is messed up and you cannot run programs from wherever git is installed.

