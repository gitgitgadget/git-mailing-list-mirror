X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-add update with all-0 object
Date: Sat, 02 Dec 2006 09:55:16 +0100
Organization: At home
Message-ID: <ekrets$v72$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org> <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org> <Pine.LNX.4.64.0611301749450.20138@iabervon.org> <20061201045727.GA22622@thunk.org> <7vhcwgcf39.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 2 Dec 2006 08:53:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33009>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqQcr-0003Sf-Oz for gcvg-git@gmane.org; Sat, 02 Dec
 2006 09:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162840AbWLBIx2 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 03:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162841AbWLBIx2
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 03:53:28 -0500
Received: from main.gmane.org ([80.91.229.2]:215 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162840AbWLBIx1 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 03:53:27 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqQce-0003RC-Em for git@vger.kernel.org; Sat, 02 Dec 2006 09:53:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 09:53:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 09:53:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0=A0=A0=A0=A0=A0=A0=A0* 'git-diff' [--options] <commit> <commit> --=
 [<path>...]
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0is to see the changes between two <commit=
>.
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0Just in case if you are doing something exoti=
c, it
> =A0 =A0 =A0 =A0 should be noted that all of the <commit> in the above
> =A0 =A0 =A0 =A0 descriptoin can be any <tree-ish>.

s/descriptoin/description/
         =20
It _might_ be worth mentioning that you can compare two arbitrary
files using

   git diff [--options] <blob1 sha> <blob2 sha>

where <blob sha> can be entered as <tree-ish>:<filename>, usually
<commit>:<filename> (<filename> is HEAD:<filename>) to compare blob (fi=
le)
from a named tree/from a given commit, or as :<stage>:<filename> (or
just ::<filename> if file is not in merge conflict) to compare blob (fi=
le)
from an index.

If I understand correctly there is currently no way to compare files fr=
om a
working tree, not to mention files outside working tree
(including /dev/null) with that syntax.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

