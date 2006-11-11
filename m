X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/3] Re: Author name and e-mail address in .stgitrc
Date: Sun, 12 Nov 2006 00:23:22 +0100
Message-ID: <20061111232322.17760.26214.stgit@localhost>
References: <b0943d9e0611111502q2f68be67l1a2441d84923a732@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:31:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b0943d9e0611111502q2f68be67l1a2441d84923a732@mail.gmail.com>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31248>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj2JR-0006nP-SF for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946018AbWKKXao convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947325AbWKKXao
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:30:44 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:19950 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1946018AbWKKXan
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 18:30:43 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep03.bredband.com with ESMTP id
 <20061111233041.CNKZ25623.mxfep03.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 00:30:41 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 12 Nov 2006 00:30:41 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id 3AE754C04D; Sun, 12 Nov
 2006 00:30:41 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 23:02:04 +0000, Catalin Marinas wrote:

> On 11/11/06, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>
> > Is there any particular reason to have the author and committer
> > names in ~/.stgitrc? Simply taking them from the same place git
> > does would probably be a usability enhancement (unless they're
> > specified on the command line, of course).
>=20
> At the time I added these to .stgitrc, the only place git was taking
> them from was the environment variables and I wanted to put them in a
> single place. I also didn't like the idea of having the committer
> e-mail address be some username@local-machine as I don't think the
> name of the machine where I create patches is relevant. I also define
> the committer/author per repository in the .git/stgitrc file (i.e. I
> use @arm.com for Linux patches and @gmail.com for StGIT).

Well, this should all be sorted out now; git has both per-repository
and per-user config files.

> I use StGIT almost exclusively, even in "maintainer" mode and I
> would like not to spread the configuration options over many files.
> It is on my todo list to use the same configuration file as git
> (with a [stgit] section) since it has a format that should be
> understood by the Python config module.

The last patch in this series deprecates name and email config in
stgitrc by not mentioning them in the example stgitrc, because
teaching newbies to use yet another layer of identity configuration on
top of what git already provides is madness. Old-timers may continue
using stgitrc for that purpose for now (but as you say, integrating
the configuration with git is on the TODO list).

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
