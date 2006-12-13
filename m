X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Dec 2006 23:48:44 +0100
Organization: At home
Message-ID: <elpvro$rvj$1@sea.gmane.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 13 Dec 2006 22:46:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34245>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gucs8-0003wz-Hm for gcvg-git@gmane.org; Wed, 13 Dec
 2006 23:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751705AbWLMWqi convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWLMWqi
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 17:46:38 -0500
Received: from main.gmane.org ([80.91.229.2]:53383 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751704AbWLMWqh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 17:46:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gucrt-0008Eo-8s for git@vger.kernel.org; Wed, 13 Dec 2006 23:46:29 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 13 Dec 2006 23:46:29 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 13 Dec 2006
 23:46:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> This is what I have in my "niggles" list. =A0These are surface level =
things that=20
> I think are easy to fix. =A0A large part of the scariness is (I think=
) git's=20
> unfriendly output. =A0Too many messages require understanding of git =
internals.

Nice list, although I'd rather add extra output only if command is used
with -v/--verbose (or -V/--verbose) option; if not, then add -q/--quiet
(or -s/--silent) option to be used in scripts. I'm partial to --verbose
solution, as advanced users are not interested in any output; they know
the commands, and want them to be fast. C.f GNU tar: it outputs somethi=
ng
only with -v/--verbose option.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

