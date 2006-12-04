X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 17:03:07 +0100
Organization: At home
Message-ID: <el1go7$2ro$1@sea.gmane.org>
References: <87odqm2ppv.wl%cworth@cworth.org> <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org> <4571DB40.6020800@vilain.net> <Pine.LNX.4.64.0612022246310.2630@xanadu.home> <7vd570q888.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 16:02:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33199>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrGGa-0007ZA-1h for gcvg-git@gmane.org; Mon, 04 Dec
 2006 17:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937051AbWLDQB1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 11:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937050AbWLDQB1
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 11:01:27 -0500
Received: from main.gmane.org ([80.91.229.2]:36640 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937049AbWLDQB0
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 11:01:26 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrGFv-0002Gd-RX for git@vger.kernel.org; Mon, 04 Dec 2006 17:01:24 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 17:01:23 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 17:01:23 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> (And obviously, for all the normal reasons, if the index or HEAD does=
n't=20
> match, the error message should be helpful and also explicitly mentio=
n the=20
> "-f" flag. Somehing like
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0file 'x' does not match HEAD or has been stag=
ed for changes.
> =A0=A0=A0=A0=A0=A0=A0=A0Will not remove. Use '-f' to force removal.
>=20
> ("has been staged for changes" is just a long way of saying "index". =
See?=20
> I _can_ learn.)

I'd rather have

        File 'x' does not match HEAD or index (has been staged for chan=
ges).
        Will not remove. Use "git rm -f 'x'" to force removal.

I'd rather not learn that "staged for changes" mean "index". I'm quote
comfortable with the concept of "index" and the name "index",
thankyouverymuch.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

