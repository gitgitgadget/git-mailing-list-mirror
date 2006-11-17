X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 10:37:50 +0100
Organization: At home
Message-ID: <ejjvqr$k0v$1@sea.gmane.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 09:37:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31681>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl09m-0006Ul-C1 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755037AbWKQJgr convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbWKQJgr
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:36:47 -0500
Received: from main.gmane.org ([80.91.229.2]:59525 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755037AbWKQJgi (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:36:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl09E-0006Q7-7g for git@vger.kernel.org; Fri, 17 Nov 2006 10:36:36 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 10:36:36 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 10:36:36 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

> Either way, they're just a 41-byte file that contains a 40-byte hex
> object ID, plus a newline. =A0Tags are stored in .git/refs/tags, and =
heads
> are stored in .git/refs/heads. =A0Creating a new branch is literally =
just
> picking a file name and writing the ID of an existing commit into it.

This is an implementation detail, and is not true in repository with
packed refs. Although usually (by default) only tags are packed.

But it remains true that ref (be it branch or tag) is just name and ID.

> The git programs enforce the immutability of tags, but that's a safet=
y
> feature, not something fundamental. =A0You can rename a tag to the he=
ads
> directory and go wild.

You can have only refs to commit objects in heads directory (and I hope
this is verified by fsck-objects), you can have refs to tag objects
(heavyweight tags), to commits (lightweight tags), to blobs (for exampl=
e
public PGP key used for signing tags), to trees (I guess unused).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

