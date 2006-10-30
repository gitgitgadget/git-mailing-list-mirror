X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Progress reporting (was: VCS comparison table)
Date: Mon, 30 Oct 2006 11:18:56 +0100
Organization: At home
Message-ID: <ei4jia$vj0$1@sea.gmane.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org> <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 30 Oct 2006 10:21:21 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.bazaar-ng.general,gmane.comp.version-control.git
Original-Lines: 30
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30491>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeUG3-0002rx-5n for gcvg-git@gmane.org; Mon, 30 Oct
 2006 11:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161202AbWJ3KUk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006 05:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWJ3KUj
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 05:20:39 -0500
Received: from main.gmane.org ([80.91.229.2]:44686 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1161202AbWJ3KUi (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 05:20:38 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GeUFP-0002hz-IE for git@vger.kernel.org; Mon, 30 Oct 2006 11:20:03 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 30 Oct 2006 11:20:03 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 30 Oct 2006
 11:20:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Ilpo Nyyss=F6nen wrote:

>> 3. Understanding output
>>=20
>> G: Speaks a language of its own, hard to understand. No progress
>> reported for long lasting operations.
>>=20
>> B: Could maybe speak a bit more. Progress reporting is quite good.
>=20
> Which long lasting operations lack progress bar/progress reporting?
> "git clone" and "git fetch"/"git pull" both have progress report
> for both "smart" git://, git+ssh:// and local protocols, and "dumb"
> http://, https://, ftp://, rsync:// protocols. "git rebase" has
> progress report. "git am" has progress report.

I was bitten lately by git lack of progress reporting for git-push.
While it nicely reports local progress (generating data) it unfortunate=
ly
lacks wget like, "curl -o" like or scp like pack upload progress
reporting. And while usually push is fast, initial push of whole
project to empty repository can be quite slow on low-bandwidth link
(or busy network).

git version 1.4.3.3 on local side, git+ssh:// protocol, git version
1.4.3.3.g9ab2 on the remote side (repo.or.cz).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

