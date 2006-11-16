X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 02:53:08 +0100
Organization: At home
Message-ID: <ejgg7l$3gb$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 01:52:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31541>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkWQN-0000W3-Ol for gcvg-git@gmane.org; Thu, 16 Nov
 2006 02:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162153AbWKPBwQ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 20:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162154AbWKPBwQ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 20:52:16 -0500
Received: from main.gmane.org ([80.91.229.2]:47303 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1162153AbWKPBwQ (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 20:52:16 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GkWQC-0000P4-Vv for git@vger.kernel.org; Thu, 16 Nov 2006 02:52:10 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 16 Nov 2006 02:52:08 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006
 02:52:08 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> FWIW, I regularly mess up with the differences between fetching, pull=
ing=20
> and merging. =A0In particular, having to do a two step process to get=
=20
> remote changes in,
>=20
> =A0 =A0git pull url-to-server master:master
> =A0 =A0 =A0 ..error message about not being a fast-forward..
>=20
> =A0 =A0git pull --update-head-ok url-to-server master:master
> =A0 =A0 =A0 ..still an error message about update not being a fast-fo=
rward..

What about:

     git pull --update-head-ok url-to-server +master:master

(or --force, but be careful with that one)?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

