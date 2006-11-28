X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 11:50:10 +0100
Organization: At home
Message-ID: <ekh45n$rfc$1@sea.gmane.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611260241320.20138@iabervon.org> <456C0313.3020308@op5.se> <200611281029.11918.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 28 Nov 2006 10:48:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32507>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0W2-0000uF-Au for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935844AbWK1Ksj convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006 05:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935845AbWK1Ksj
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:48:39 -0500
Received: from main.gmane.org ([80.91.229.2]:60328 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935844AbWK1Ksi (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:48:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp0Vu-0000t0-Va for git@vger.kernel.org; Tue, 28 Nov 2006 11:48:34 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 11:48:34 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 11:48:34 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

>                                  How does the supermodule know which=20
> branch to track in the submodule? =A0Does it simply track HEAD or whe=
n the=20
> submodule is added to the supermodule is it told which branch to trac=
k? =A0I=20
> suppose it's got to be HEAD really hasn't it?

I think that the proper place for that would be supermodule _index_.
The supermodule tree would have commit entry, and the index would have
symbolic branch (and perhaps some infor about where to find refs for
submodule).

This I guess breaks index abstraction slightly, but on the other hand
allows for tracking non-HEAD branch of submodule, and for submodule to
not know about supermodule at all...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

