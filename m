X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] git-show: also handle blobs
Date: Sun, 03 Dec 2006 20:03:30 +0100
Organization: At home
Message-ID: <ekv721$5el$1@sea.gmane.org>
References: <Pine.LNX.4.63.0612031952050.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 19:04:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33129>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqwd5-0004em-3t for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759995AbWLCTDz convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 14:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759996AbWLCTDz
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:03:55 -0500
Received: from main.gmane.org ([80.91.229.2]:1228 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1759995AbWLCTDy (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:03:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gqwcu-0005mh-AF for git@vger.kernel.org; Sun, 03 Dec 2006 20:03:48 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 20:03:48 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 03 Dec 2006
 20:03:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> =A0
> =A0DESCRIPTION
> =A0-----------
> -Shows commit log and textual diff for a single commit. =A0The
> -command internally invokes 'git-rev-list' piped to
> -'git-diff-tree', and takes command line options for both of
> -these commands. It also presents the merge commit in a special
> -format as produced by 'git-diff-tree --cc'.
> +Shows a commit or blob. In case of a commit it shows the
> +log message and textual diff for a single commit. It also
> +presents the merge commit in a special format as produced by
> +'git-diff-tree --cc'.
> =A0
> =A0This manual page describes only the most frequently used options.
> =A0

This loses the information that you can use all the options
of git-diff-tree and all the options of git-rev-list in git-show.

But I agre that technical information should not be in DESCRIPTION
section of manpage... perhaps later, if it is needed.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

