X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 10:41:29 +0100
Organization: At home
Message-ID: <ejk01n$l9u$1@sea.gmane.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 09:45:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31682>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl0Ha-0007gQ-8D for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755619AbWKQJpJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 04:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755628AbWKQJpJ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:45:09 -0500
Received: from main.gmane.org ([80.91.229.2]:37530 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755619AbWKQJpF (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:45:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gl0HO-0007dY-GE for git@vger.kernel.org; Fri, 17 Nov 2006 10:45:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 10:45:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 10:45:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

> There is always a current head, known as HEAD. =A0(This is actually a
> symbolic link, .git/HEAD, to a file like refs/heads/master.)

Usually this is symref, not symlink, i.e. .git/HEAD (or rather
$GIT_DIR/HEAD) is a file which contains single line like this:

  ref: refs/heads/master

There is a talk about relaxing HEAD restriction to allow it to contain =
ref
to tag, or bare SHA1 id for "seeking"; you are forbidden to commit to s=
uch
state.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

