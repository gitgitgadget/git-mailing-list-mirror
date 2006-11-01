X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 10:38:57 +0100
Organization: At home
Message-ID: <ei9pv0$m70$1@sea.gmane.org>
References: <200610261641.11239.andyparkins@gmail.com> <81b0412b0610260842x52413570k3971bcdc54b3ccb5@mail.gmail.com> <200610270827.17659.andyparkins@gmail.com> <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se> <20061027081545.GF29057@spearce.org> <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com> <4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net> <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com> <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net> <7vvelz7eg2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 1 Nov 2006 09:39:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30628>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfCYn-0005Vi-LQ for gcvg-git@gmane.org; Wed, 01 Nov
 2006 10:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946732AbWKAJi6 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006 04:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946735AbWKAJi6
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 04:38:58 -0500
Received: from main.gmane.org ([80.91.229.2]:15569 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1946732AbWKAJi5 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 04:38:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GfCYc-0005UC-Id for git@vger.kernel.org; Wed, 01 Nov 2006 10:38:50 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 10:38:50 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 01 Nov 2006
 10:38:50 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Given a commit that is different from the current HEAD, "reset"
> moves the HEAD and depending on hardness of the reset it updates
> the index and the working tree. =A0Currently the command does not
> take paths limiters and means "the whole tree", but asking to
> update only one would logically fall as a natural extension to
> the current command line if we add paths limiters.
>=20
> As an implementation detail of the new "reset", the ls-tree to
> update-index pipe could be used.
=20
On the other hand "reset" moves the HEAD, and with pathspec it wouldn't
do that. But there is the same case for "checkout" with pathspec. And t=
his
would make "reset" and "checkout" more similar...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

