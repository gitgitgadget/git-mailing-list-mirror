X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: (unknown)
Date: Wed, 25 Oct 2006 16:53:14 +0200
Organization: At home
Message-ID: <ehntnv$b1k$1@sea.gmane.org>
References: <E1Gck2K-0003H4-00@dvr.360vision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 14:53:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30063>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gck86-00079f-6P for gcvg-git@gmane.org; Wed, 25 Oct
 2006 16:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932444AbWJYOxO convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 10:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWJYOxO
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 10:53:14 -0400
Received: from main.gmane.org ([80.91.229.2]:4762 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932444AbWJYOxN (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 10:53:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gck7s-000788-5O for git@vger.kernel.org; Wed, 25 Oct 2006 16:53:04 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 16:53:04 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 25 Oct 2006
 16:53:04 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

andyparkins@gmail.com wrote:

> To easily differentiate the read-only upstream branches, from normal =
branches,
> default to cloning them with the prefix "up/" added to their branch n=
ames.
> This also abandons the idea of an "origin" branch which is now simply
> "up/master" and hence removes the special treatment that master was g=
etting.
> (cherry picked from 33d89375652222c41fbf225f1e1c3bfb38b755b2 commit)
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> I'm sure this will be an unwanted patch. =A0However, I really do thin=
k it's=20
> important to highlight these upstream branches in some way. =A0I real=
ise=20
> renaming "origin" is probably not going to fly, but perhaps it would =
be okay=20
> to have at least the non-origin branches prefixed?

Check if "git clone --use-separate-remote" isn't what you want.

And please correct mail sending.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

