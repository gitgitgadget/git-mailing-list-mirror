X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 01:30:13 +0100
Organization: At home
Message-ID: <ekl8j5$in4$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net> <Pine.LNX.4.64.06112
 91235590.3513@woody.osdl.org> <87bqmpvlxf.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 00:29:53 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 27
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32688>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZoC-0002jf-2V for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967731AbWK3A3p convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006 19:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967732AbWK3A3p
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:29:45 -0500
Received: from main.gmane.org ([80.91.229.2]:34254 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S967731AbWK3A3o (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:29:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpZnm-0002ca-08 for git@vger.kernel.org; Thu, 30 Nov 2006 01:29:22 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 01:29:21 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 01:29:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Carl Worth wrote:

> In the thread on the fedora
> mailing list that prompted my first "user-interface warts" and the
> patch I mentioned above, the process was worse:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git commit
> =A0=A0=A0=A0=A0=A0=A0=A0"hmm... why didn't that work"
> =A0=A0=A0=A0=A0=A0=A0=A0read message
> =A0=A0=A0=A0=A0=A0=A0=A0git update-index
> =A0=A0=A0=A0=A0=A0=A0=A0git commit
> =A0=A0=A0=A0=A0=A0=A0=A0"crap... it still didn't work even when I did=
 what it told me to do"
>=20
> Here's the original version of that report:
>=20
> https://www.redhat.com/archives/fedora-maintainers/2006-November/msg0=
0141.html

=46rom the SYNOPSIS of git-update-index(1) one can see that git-update-=
index
needs files to act on.

But I agree that git is not very user friendly, and has some usability
warts.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

