X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Combined diff format documentation
Date: Thu, 26 Oct 2006 01:45:16 +0200
Organization: At home
Message-ID: <ehost8$go7$1@sea.gmane.org>
References: <ehoo2k$1g6$1@sea.gmane.org> <7vejswkoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 23:44:56 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30126>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcsQW-0004Xn-LN for gcvg-git@gmane.org; Thu, 26 Oct
 2006 01:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964828AbWJYXot convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 19:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWJYXot
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 19:44:49 -0400
Received: from main.gmane.org ([80.91.229.2]:31172 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1751116AbWJYXos (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 19:44:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GcsQP-0004Wx-Ao for git@vger.kernel.org; Thu, 26 Oct 2006 01:44:45 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 01:44:45 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 01:44:45 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

>> =A0 =A0BTW. it is not mentioned in documentation that git diff uses =
hunk section
>> =A0 =A0indicator, and what regexp/expression it uses (and is it conf=
igurable).
>> =A0 =A0Not described in documentation.
>=20
> If you mean by "hunk section indicator" the output similar to
> GNU diff -p option, I think it is not worth mentioning and we
> are not ready to mention it yet (we have not etched the
> expression in stone). =A0Nobody jumped up and down to say it needs
> to be configurable, so it is left undocumented more or less
> deliberately.

By the way, I have just checked that combined diff format doesn't have
(for unknown reason) "which section" indicator in chunk header.
Compare
$ git diff-tree -p -m fec9ebf16c948bcb4a8b88d0173ee63584bcde76
and
$ git diff-tree -p -c fec9ebf16c948bcb4a8b88d0173ee63584bcde76
(this is the source of example combined diff format in diff-formats.txt
which I've found via
$ git rev-list --parents HEAD -- describe.c | grep " .* "
i.e. finding all merges which included changes to describe.c; there
are only two such commits).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

