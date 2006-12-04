X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] gitfs pre-release 0.04
Date: Mon, 04 Dec 2006 20:40:38 +0100
Organization: At home
Message-ID: <el1tg0$n07$1@sea.gmane.org>
References: <20061204194011.GW47959@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 19:40:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33228>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJfk-0000K7-F1 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937319AbWLDTkN convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 14:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759457AbWLDTkM
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:40:12 -0500
Received: from main.gmane.org ([80.91.229.2]:39992 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1759442AbWLDTkK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:40:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrJfW-0007ga-3z for git@vger.kernel.org; Mon, 04 Dec 2006 20:40:03 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 20:40:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 20:40:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Mitchell Blank Jr wrote:

> =A0 * At the top of each tree there's now a synthetic ".git" director=
y
> =A0 =A0 which includes some symlinks and a "HEAD" file that points to
> =A0 =A0 the currently viewed root. =A0The idea is to allow some simpl=
e git
> =A0 =A0 commands to work inside of a gitfs directory. =A0Unfortunatel=
y this doesn't
> =A0 =A0 work yet since git no longer recognizes a non-symbolic ref in=
 "HEAD".
> =A0 =A0 I'll try to work around this soon.

Not true. Symlink HEAD still works, and we have even core.preferSymlink=
Refs
configuration variable.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

