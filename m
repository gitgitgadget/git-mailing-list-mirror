X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:18:09 +0200
Organization: At home
Message-ID: <ehq5g9$7jr$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net> <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 11:17:54 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30191>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd3F6-0002UI-1W for gcvg-git@gmane.org; Thu, 26 Oct
 2006 13:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752136AbWJZLRp convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 07:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbWJZLRp
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 07:17:45 -0400
Received: from main.gmane.org ([80.91.229.2]:52947 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1752136AbWJZLRo (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 07:17:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd3F1-0002TM-6p for git@vger.kernel.org; Thu, 26 Oct 2006 13:17:43 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 26 Oct 2006 13:17:43 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 13:17:43 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Vincent Ladeuil wrote:

> Ok, so git make a distinction between the commit (code created by
> someone) and the tree (code only).
>=20
> Commits are defined by their parents.
>=20
> Trees are defined by their content only ?

Trees are collections of tuples: (mode, type, sha1, name), where mode
is simplified mode of a file or directory (only if it is symlink, direc=
tory,
file or executable file is tracked), type is blob (file) or tree
(directory), sha1 is sha1 of contents of given entry, and name is filen=
ame
of given entry.
=20
> If that's the case, how do you proceed ?=20
>=20
> Calculate a sha1 representing the content (or the content of the
> diff from parent) of all the files and dirs in the tree ? =A0Or
> from the sha1s of the files and dirs themselves recursively based
> on sha1s of the files and dirs they contain ?
=20
sha1 of object is sha1 of type+contents if I remember correctly. So the=
 sha1
of tree is based on sha1 of the files and dirs it contain.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

