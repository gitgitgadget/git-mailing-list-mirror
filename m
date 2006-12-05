X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] read-tree: further loosen "working file will be lost" check.
Date: Tue, 05 Dec 2006 02:21:50 +0100
Organization: At home
Message-ID: <el2hfe$oi0$2@sea.gmane.org>
References: <7vlklnkv39.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 5 Dec 2006 01:20:33 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33283>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrOyt-0006Ov-EH for gcvg-git@gmane.org; Tue, 05 Dec
 2006 02:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967960AbWLEBUV convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 20:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967963AbWLEBUV
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 20:20:21 -0500
Received: from main.gmane.org ([80.91.229.2]:44006 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S967960AbWLEBUU
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 20:20:20 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrOyY-0004Pw-4K for git@vger.kernel.org; Tue, 05 Dec 2006 02:20:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 02:20:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 02:20:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> A new option "--ignore=3D.gitignore" can be used to tell the
> "git-read-tree" command that the user does not mind losing
> contents in untracked files in the working tree if it needs to
> be overwritten by a merge (either a two-way "switch branch"
> merge, or a three-way merge).
[...]
> =A0builtin-read-tree.c =A0 =A0 =A0 =A0 | =A0 20 ++++++++++
> =A0dir.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-
> =A0dir.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 ++
> =A0t/t1004-read-tree-m-u-wf.sh | =A0 82 +++++++++++++++++++++++++++++=
+++++++++----
> =A0unpack-trees.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 ++++++++++---
> =A0unpack-trees.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A06 files changed, 119 insertions(+), 15 deletions(-)

Documentation, please?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

