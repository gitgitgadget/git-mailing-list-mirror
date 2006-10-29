X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Teach git-index-pack how to keep a pack file.
Date: Sun, 29 Oct 2006 11:49:17 +0100
Organization: At home
Message-ID: <ei210e$dfs$1@sea.gmane.org>
References: <20061029094159.GE3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 29 Oct 2006 10:50:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30425>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge8FM-000344-3C for gcvg-git@gmane.org; Sun, 29 Oct
 2006 11:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932173AbWJ2KuS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006 05:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWJ2KuS
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 05:50:18 -0500
Received: from main.gmane.org ([80.91.229.2]:10926 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932173AbWJ2KuR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 05:50:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Ge8F0-00031i-Ly for git@vger.kernel.org; Sun, 29 Oct 2006 11:50:10 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 11:50:10 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 29 Oct 2006
 11:50:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> +--keep::
> +=A0=A0=A0=A0=A0=A0=A0Before moving the index into its final destinat=
ion
> +=A0=A0=A0=A0=A0=A0=A0create an empty .keep file for the associated p=
ack file.
> +=A0=A0=A0=A0=A0=A0=A0This option is usually necessary with --stdin t=
o prevent a
> +=A0=A0=A0=A0=A0=A0=A0simultaneous gitlink:git-repack[1] process from=
 deleting
> +=A0=A0=A0=A0=A0=A0=A0the newly constructed pack and index before ref=
s can be
> +=A0=A0=A0=A0=A0=A0=A0updated to use objects contained in the pack.
> +
> +--keep=3D'why'::
> +=A0=A0=A0=A0=A0=A0=A0Like --keep create a .keep file before moving t=
he index into
> +=A0=A0=A0=A0=A0=A0=A0its final destination, but rather than creating=
 an empty file
> +=A0=A0=A0=A0=A0=A0=A0place 'why' followed by an LF into the .keep fi=
le. =A0The 'why'
> +=A0=A0=A0=A0=A0=A0=A0message can later be searched for within all .k=
eep files to
> +=A0=A0=A0=A0=A0=A0=A0locate any which have outlived their usefulness=
=2E

Wouldn't it be better to use 'git-index-pack', perhaps with source URL =
if
possible, as the default 'why'?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

