X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/3] Ask git for author and committer name
Date: Tue, 5 Dec 2006 10:10:17 +0100
Message-ID: <20061205091017.GB25002@diana.vm.bytemark.co.uk>
References: <20061111232322.17760.26214.stgit@localhost> <20061111233046.17760.62871.stgit@localhost> <b0943d9e0612041424v42313a2r22d8fc8d1b18cb55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 09:10:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612041424v42313a2r22d8fc8d1b18cb55@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33325>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWJk-0007Sf-70 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968132AbWLEJKU convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006 04:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968136AbWLEJKU
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:10:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2933 "EHLO
 diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S968132AbWLEJKS (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 04:10:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GrWJd-0006YJ-00; Tue, 05 Dec 2006 09:10:17 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-12-04 22:24:52 +0000, Catalin Marinas wrote:

> On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Consistently do the following to get hold of default user and
> > committer:
> >
> >   1. Use the value specified on the command line, if any.
> >
> >   1. Otherwise, use the value from stgitrc, if available.
> >
> >   2. Otherwise, ask git for the value. git will produce the value
> >      from on of its config files, from environment variables, or
> >      make it up. It might be asking the spirits of the dead for
> >      all we care.
>
> I haven't forgot about this patch. I switched StGIT to the gitconfig
> files and there won't be a need to invoke "git repo-config". I'll
> try to modify your patch.

Ah, nice. But will you still honor the git author and committer
environment variables that way?

--=20
Karl Hasselstr=F6m, kha@treskal.com
