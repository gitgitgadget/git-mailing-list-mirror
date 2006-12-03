X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Juergen Stuber <juergen@jstuber.net>
Subject: Re: jgit performance update
Date: Sun, 03 Dec 2006 23:42:04 +0100
Message-ID: <874psceh4z.fsf@freitag.home.jstuber.net>
References: <20061203045953.GE26668@spearce.org>
	<Pine.LNX.4.64.0612030938140.3476@woody.osdl.org>
	<ekv34g$mck$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 23:10:21 +0000 (UTC)
Cc: jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-060-106-209.pools.arcor-ip.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:muCZzxCkE3hOGMf+RX6r3O87g3A=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33152>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr0TP-0000sR-7R for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758802AbWLCXKK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 18:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758818AbWLCXKK
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:10:10 -0500
Received: from main.gmane.org ([80.91.229.2]:17864 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758802AbWLCXKI (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 18:10:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gr0TC-0008Cw-3B for git@vger.kernel.org; Mon, 04 Dec 2006 00:10:02 +0100
Received: from dslb-084-060-106-209.pools.arcor-ip.net ([84.60.106.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 00:10:02 +0100
Received: from juergen by dslb-084-060-106-209.pools.arcor-ip.net with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04
 Dec 2006 00:10:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi Jakub,

Jakub Narebski <jnareb@gmail.com> writes:
>
> GitWiki tells us about egit/jgit repository at
>   http://www.spearce.org/projects/scm/egit.git

I tried to access that with git 1.4.4.1 from Debian but=20

% git clone http://www.spearce.org/projects/scm/egit.git

hangs, the first time after "walk e339766abc2b919e7bb396cae22ddef065821=
381",
the second time after "walk 9eec90ec5da239e063eaff6305d77294dc03396e"
which is the "walk" line just before it.

There's also the following error shortly after the start:

error: File bc01ab9e5fcd26918d7a334207183fa57ff1ce50 (http://www.spearc=
e.org/projects/scm/egit.git/objects/75/1c8f2e504c40d1c41ebbd87d8f896852=
9e9c30) corrupt


J=C3=BCrgen

--=20
J=C3=BCrgen Stuber <juergen@jstuber.net>
http://www.jstuber.net/
gnupg key fingerprint =3D 2767 CA3C 5680 58BA 9A91  23D9 BED6 9A7A AF9E=
 68B4
