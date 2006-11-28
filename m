X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] git-commit: make '-a' the default.
Date: Tue, 28 Nov 2006 10:09:39 +0100
Organization: At home
Message-ID: <ekgu98$83e$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vy7pw5a4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 28 Nov 2006 09:08:33 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32497>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goywv-0006Y9-AX for gcvg-git@gmane.org; Tue, 28 Nov
 2006 10:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935738AbWK1JIR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006 04:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935736AbWK1JIR
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 04:08:17 -0500
Received: from main.gmane.org ([80.91.229.2]:31671 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935738AbWK1JIP (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 04:08:15 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Goywe-0006Tj-HU for git@vger.kernel.org; Tue, 28 Nov 2006 10:08:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 10:08:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 10:08:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> At the same time, stop talking about "--only" option being the
> default when given paths. =A0It has been that way for quite some
> time.
>=20
> This change breaks t1400 which assumed the long tradition of not
> modifying index when not told to touch it with an explicit -a
> nor paths, so this commit includes adjustment for it as well.

Perhaps we should make it configuration option instead? I usually use
"git commit -a -s"; I add -s anyway, so adding -a is not that much more=
=2E

By the way, if I understand correctly git-resolve is meant as restricte=
d
git-update-index, which can _only_ mark file as resolved (and probably
check for merge markers, unless --force'd).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

