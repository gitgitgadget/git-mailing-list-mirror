X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 02 Dec 2006 14:14:54 +0100
Organization: At home
Message-ID: <ekru4l$6nh$2@sea.gmane.org>
References: <20061130170625.GH18810@admingilde.org> <200612011917.19252.andyparkins@gmail.com> <20061201193802.GI18810@admingilde.org> <200612012104.39897.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 2 Dec 2006 13:13:31 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33022>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqUgJ-0008Ps-5C for gcvg-git@gmane.org; Sat, 02 Dec
 2006 14:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163000AbWLBNNK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 08:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163002AbWLBNNK
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 08:13:10 -0500
Received: from main.gmane.org ([80.91.229.2]:5306 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1163000AbWLBNNG (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 08:13:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqUfq-0008KE-Qu for git@vger.kernel.org; Sat, 02 Dec 2006 14:12:58 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 14:12:58 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 14:12:58 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

>> You still don't have a totally separated repository then, because
>> you can't do a reachability analysis in the submodule repository alo=
ne.
>=20
> I'm going to guess by reachability analysis, you mean that the submod=
ule=20
> doesn't know that some of it's commits are referenced by the supermod=
ule. =A0As=20
> I suggested elsewhere in the thread, that's easily fixed by making a=20
> refs/supermodule/commitXXXX file for each supermodule commit that ref=
erences=20
> as particular submodule commit. =A0Then you can git-prune, git-fsck w=
henever=20
> you want.

I think it would be better resolve this in universal way by adding
to git repository layout the optional "borrowers" file, which would
protect against pruning objects that are referenced by repositories
which have given repository as one of the "alternates".

By the way, how to slurp all the objects from alternates into repo
object repository?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

