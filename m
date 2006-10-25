X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] git-split: Split the history of a git repository by subdirectories and ranges
Date: Wed, 25 Oct 2006 02:19:15 +0200
Organization: At home
Message-ID: <ehmah3$rkj$2@sea.gmane.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net> <453C96C9.4010005@freedesktop.org> <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org> <453D17B5.6070203@freedesktop.org> <7vu01tfe6u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 00:20:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30020>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcWVD-0006ni-0J for gcvg-git@gmane.org; Wed, 25 Oct
 2006 02:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422856AbWJYAUJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 20:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422858AbWJYAUJ
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 20:20:09 -0400
Received: from main.gmane.org ([80.91.229.2]:36999 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1422856AbWJYAUH (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 20:20:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GcWV0-0006mT-HW for git@vger.kernel.org; Wed, 25 Oct 2006 02:20:02 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 02:20:02 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 02:20:02 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> So one potential action item that came out from this discussion
> for me is to either modify --pretty=3Draw (or add --pretty=3Drawish)
> that gives the rewritten parents instead of real parents? =A0With
> that, you can drop the code to simplify ancestry by hand in your
> loop, and also you do not have to do the grafts inforamation
> yourself either?
>=20
> If that is the case I'd be very happy.
>=20
> The only thing left for us to decide is if reporting the true
> parenthood like the current --pretty=3Draw makes sense (if so we
> need to keep it and introduce --pretty=3Drawfish).
>=20
> The only in-tree user of --pretty=3Draw seems to be git-svn but it
> only looks at path-unlimited log/rev-list from one given commit,
> so the only difference between dumping what is recorded in the
> commit object and listing what parents we _think_ the commit has
> is what we read from grafts. =A0I think we are safe to just "fix"
> the behaviour of --pretty=3Draw
>=20
> Comments?

The name --pretty=3Draw suggest output of info directly from commit obj=
ect,
but perhaps that just me (--pretty=3Drawish or =3D=3Dpretty=3Dheaders).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

