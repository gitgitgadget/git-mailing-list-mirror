X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 02 Dec 2006 10:52:33 +0100
Organization: At home
Message-ID: <ekri99$7gh$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 2 Dec 2006 09:50:56 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33015>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqRWH-0004e1-1T for gcvg-git@gmane.org; Sat, 02 Dec
 2006 10:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162879AbWLBJuu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 04:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162880AbWLBJuu
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 04:50:50 -0500
Received: from main.gmane.org ([80.91.229.2]:55966 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162879AbWLBJut (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 04:50:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqRWB-0004dH-MQ for git@vger.kernel.org; Sat, 02 Dec 2006 10:50:47 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 10:50:47 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 10:50:47 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0- We keep the word "index", and not reword it to "stage" in the
> =A0 =A0names of commands and options. =A0"to stage" is very good verb
> =A0 =A0to explain the _concept_, but there is no need to use
> =A0 =A0inconsistent wording Porcelain-ish and plumbing use to
> =A0 =A0describe the entity used for staging.
>=20
> =A0 =A0(1) New people need to learn the new concept anyway, and they
> =A0 =A0 =A0 =A0are intelligent enough to learn what that new concept =
has
> =A0 =A0 =A0 =A0been called for a long time in git-land at the same ti=
me.
>=20
> =A0 =A0 =A0 =A0"The index" is the receiver of new contents to be stag=
ed;
> =A0 =A0 =A0 =A0conversely, "to stage" is the act of registering conte=
nts
> =A0 =A0 =A0 =A0to the index.

I think we should refer to "the index" as "the staging area [for commit=
s]",
at least the first time (it is a bit longish to use it later).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

