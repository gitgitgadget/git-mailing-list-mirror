X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 23:22:57 +0100
Organization: At home
Message-ID: <ekicoi$jgk$1@sea.gmane.org>
References: <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <20061128215332.GK28337@spearce.org> <Pine.LNX.4.64.0611281355480.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 28 Nov 2006 22:22:54 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32596>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBLV-0007GS-6a for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757656AbWK1WWT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006 17:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757677AbWK1WWT
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:22:19 -0500
Received: from main.gmane.org ([80.91.229.2]:53218 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1757655AbWK1WWS (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:22:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpBKi-00075v-Tc for git@vger.kernel.org; Tue, 28 Nov 2006 23:21:44 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 23:21:44 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 23:21:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:

> [ For the non-git users, "git log --merge" is just shorthand for a mu=
ch=20
> =A0 more complicated git revision parsing expression which boils down=
 to:=20
> =A0 "show all commits as they pertain to any remaining unmerged pathn=
ames,=20
> =A0 and only within the symmetrical set difference between the two br=
anches=20
> =A0 you merged". You could write it out as
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git log ORIG_HEAD...MERGE_HEAD -- $(git ls-fi=
les --unmerged)
>=20
> =A0 but that "git log --merge" is a much simpler shorthand for that t=
hing.=20
>=20
> =A0 It's not that merge conflicts are necessarily common, but when th=
ey do=20
> =A0 happen, that's where you _really_ want the SCM to support you in=20
> =A0 figuring out what happened ]

It would be nice if this was documented in git-log(1), and not only
_partially_ in git-rev-list(1). And it would be nice to have this in th=
e
proposed "Branches and merges" tutorial (part 3?) as well.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

