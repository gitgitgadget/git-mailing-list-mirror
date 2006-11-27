X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 15:27:20 +0100
Organization: At home
Message-ID: <ekesgt$6jq$1@sea.gmane.org>
References: <200611271516.30425.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 14:27:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32415>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GohRS-0007DY-Ts for gcvg-git@gmane.org; Mon, 27 Nov
 2006 15:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758229AbWK0O0f convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 09:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758242AbWK0O0e
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 09:26:34 -0500
Received: from main.gmane.org ([80.91.229.2]:27885 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1758229AbWK0O0e (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 09:26:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GohQd-00070B-W1 for git@vger.kernel.org; Mon, 27 Nov 2006 15:25:52 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 15:25:51 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 27 Nov 2006
 15:25:51 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Bruno Haible wrote:

> Is this a bug in git-diff? The git-diff-files.html says:
>=20
> =A0 " When the environment variable GIT_EXTERNAL_DIFF is not set ...
> =A0 =A0 For example, if you prefer context diff:
> =A0 =A0 GIT_DIFF_OPTS=3D-c git-diff-index -p HEAD =A0"
>=20
> This doesn't work for me with git-1.4.4:

Yes, the bug in documentation, I think. There is an option '-c' to git-=
diff,
but it means "combined diff" (for merges), not "context diff".
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

