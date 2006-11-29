X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Wed, 29 Nov 2006 14:46:40 +0100
Organization: At home
Message-ID: <ekk2sh$8ja$1@sea.gmane.org>
References: <87wt5rffbm.fsf@rho.meyering.net> <7virgz1bz7.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0611291040590.30004@wbgn013.biozentrum.uni-wuerzburg.de> <87u00imsin.fsf@rho.meyering.net> <Pine.LNX.4.63.0611291220130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 29 Nov 2006 13:46:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 21
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32639>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpPky-0007kt-1M for gcvg-git@gmane.org; Wed, 29 Nov
 2006 14:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966604AbWK2Npb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006 08:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935623AbWK2Npb
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 08:45:31 -0500
Received: from main.gmane.org ([80.91.229.2]:53949 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935588AbWK2Npa (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 08:45:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpPkN-0007d4-PJ for git@vger.kernel.org; Wed, 29 Nov 2006 14:45:12 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 14:45:11 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 29 Nov 2006
 14:45:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

>> Without even considering any other option, I chose to use a lightwei=
ght
>> tag for that purpose, since I have a conceptual view that it's a lab=
el I
>> can move from one referent to another. =A0It strikes me as counter-i=
ntuitive
>> to use a temporary git "branch" that way. =A0Would that even work, r=
emoving
>> it and recreating it all the time?
>=20
> Yes, it would. Remember: a branch in git is just a named ref. It=20
> literally used to be a 41-byte file pointing to the tip of the branch=
 in=20
> the ancestor graph. And you can update it with git-update-ref.
>=20
> So, a branch in git is very much the movable label you are looking fo=
r.

And even if cvs-head does not fast-forward, remember that pu branch als=
o
doesn't fast-forward (usually).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

