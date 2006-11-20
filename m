X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 23:16:45 +0100
Organization: At home
Message-ID: <ejt9dh$kfm$1@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 20 Nov 2006 22:19:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31942>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHTR-0002PR-Ce for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966739AbWKTWRz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006 17:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966837AbWKTWR0
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:17:26 -0500
Received: from main.gmane.org ([80.91.229.2]:18377 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966854AbWKTWPn (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:15:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmHQI-0001Xo-W9 for git@vger.kernel.org; Mon, 20 Nov 2006 23:15:31 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 23:15:30 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 20 Nov 2006
 23:15:30 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Martin Waitz wrote:

> A submodule really is part of the parent tree, so it is very natural =
to
> add the link to the submodule commit into the GIT tree data structure=
=2E
> In addition to links to blobs and other trees, they can now also hold
> a link to a commit, which in turn has the pointers to the submodule t=
ree
> and its history. =A0In order to differenciate a submodule entry with
> normal file or directory entries, they get a special file mode.

Erm... isn't a _type_ of tree entry saved somewhere? Currently it can
be only 'tree' or 'blob', what you do is adding 'commit' (then permissi=
ons
are permissions of top tree of module, of course).

By the way, in todo branch, in Subpro.txt, there is talk about adding
link to submodule trees in _commit object_... well link to submodule tr=
ee
or commit, with the "mount point".
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

