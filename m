X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-merge-subordinate
Date: Wed, 25 Oct 2006 18:11:05 +0200
Organization: At home
Message-ID: <eho29l$1td$1@sea.gmane.org>
References: <20061025155009.GD5591@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 16:12:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30070>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GclM1-0005Vf-0u for gcvg-git@gmane.org; Wed, 25 Oct
 2006 18:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932457AbWJYQLm convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 12:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWJYQLm
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 12:11:42 -0400
Received: from main.gmane.org ([80.91.229.2]:29155 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932457AbWJYQLl (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 12:11:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GclLa-0005QG-09 for git@vger.kernel.org; Wed, 25 Oct 2006 18:11:18 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 18:11:17 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 18:11:17 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Matthew Wilcox wrote:

> Linus doesn't like seeing unnecessary merges in his tree. =A0I'm not =
a huge
> fan of them either. =A0Wouldn't it be nice if we had a merge method t=
hat
> did a merge without creating a merge? =A0I call it git-merge-subordin=
ate
> (since my tree is subordinate to the tree I'm pulling from). =A0I sup=
pose
> you could call it 'slave' if you want to be more pithy. =A0Anyway, th=
is
> is a first attempt, and it's totally cargo-cult programming; I make n=
o
> claim that I understand what I'm doing. =A0But it does seem to work.

Hmmm... the --squash option to git-merge/git-pull isn't enough?

--squash::
        Produce the working tree and index state as if a real
        merge happened, but do not actually make a commit or
        move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
        cause the next `git commit` command to create a merge
        commit.  This allows you to create a single commit on
        top of the current branch whose effect is the same as
        merging another branch (or more in case of an octopus).


--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

