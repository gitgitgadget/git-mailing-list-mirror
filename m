X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Mon, 04 Dec 2006 22:19:55 +0100
Organization: At home
Message-ID: <el239s$e1i$1@sea.gmane.org>
References: <87d56z32e1.wl%cworth@cworth.org> <87bqmj2zit.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 21:18:28 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33251>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLCY-0007h2-KA for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937392AbWLDVSL convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 16:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937394AbWLDVSK
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:18:10 -0500
Received: from main.gmane.org ([80.91.229.2]:47015 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937392AbWLDVSJ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:18:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrLCH-0007BV-R5 for git@vger.kernel.org; Mon, 04 Dec 2006 22:17:57 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 22:17:57 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 22:17:57 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:

> But what might be very interesting is a modified "git-apply --index"
> that would not fail in this case, but would instead do the following:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A01. Apply the patch to the working tree
>=20
> =A0=A0=A0=A0=A0=A0=A0=A02. Apply the patch to the index
>=20
> And of course, if either fails then the entire apply operation fails,
> leaving no changes to working tree or to the index.

Or even new option to git-apply, namely --index-only, which would apply
patch to index only.

BTW. With git-apply we have three possibilities to apply patch to:
HEAD, index and working tree version, and three possibilities to
store result in: working tree only, working tree and index both,
and index only.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

