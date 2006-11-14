X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 22:01:50 +0100
Organization: At home
Message-ID: <ejdapj$vc0$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 21:01:48 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31376>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5PI-0005ZU-Fv for gcvg-git@gmane.org; Tue, 14 Nov
 2006 22:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966351AbWKNVBE convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 16:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966354AbWKNVBE
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 16:01:04 -0500
Received: from main.gmane.org ([80.91.229.2]:50148 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966351AbWKNVBB (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 16:01:01 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gk5Od-0005PH-8s for git@vger.kernel.org; Tue, 14 Nov 2006 22:00:43 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 14 Nov 2006 22:00:43 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 14 Nov 2006
 22:00:43 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicolas Pitre wrote:

> If the fetch+merge behavior (which I think should really be refered a=
s=20
> pull+merge) is still desirable, then it should be called git-update a=
nd=20
> be no more than a single shell script line such as
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git_pull && git_merge"
>=20
> This is really what most people expect from such a command name based=
=20
> on obvious historical reasons. =A0The lack of any branch argument to=20
> git-pull and git-merge could be defined as using the first defined=20
> remote branch by default. =A0But having git-pull performing merges is=
 IMHO=20
> overloading the word and goes against most people's expectations.

By the way, is anyone doing _remote_ octopus pull (true pull, not with =
=2E as
repository)?

We can always have --merge arguments to git-pull, and --fetch argument =
to
git-merge.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

