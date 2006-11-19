X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Sun, 19 Nov 2006 19:54:27 +0100
Organization: At home
Message-ID: <ejq96b$frg$1@sea.gmane.org>
References: <87wt5rffbm.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 19 Nov 2006 18:54:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31852>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glrni-0005Jh-Ub for gcvg-git@gmane.org; Sun, 19 Nov
 2006 19:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932832AbWKSSx4 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWKSSx4
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 13:53:56 -0500
Received: from main.gmane.org ([80.91.229.2]:26849 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932832AbWKSSxz (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 13:53:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GlrnZ-0005Gw-Ty for git@vger.kernel.org; Sun, 19 Nov 2006 19:53:50 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 19:53:49 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 19 Nov 2006
 19:53:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jim Meyering wrote:

> When I try to push the new tags, git-push fails:
>=20
> =A0 $ git-push -f --tags ssh+git://git.sv.gnu.org/srv/git/coreutils m=
aster:refs/heads/master
> =A0 updating 'refs/tags/cvs-head'
> =A0 =A0 from 2fd3fd29a8b40be695bc2327c8cd3bd33e521100
> =A0 =A0 to =A0 db18f53ffb221e9957124d8af81c11a7e350ac3b
> =A0 ...
> =A0 Total 1, written 1 (delta 0), reused 0 (delta 0)
> =A0 Unpacking 1 objects
> =A0 error: denying non-fast forward; you should pull first
>=20
> I get the same error also when using --force.

Possibly remote side has receive.denyNonFastForwards set (it should not
I think if it is public published bare repository). But even then there
should be no fast-forward check on tags...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

