X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Cleanup git-diff documentation
Date: Fri, 15 Dec 2006 11:03:19 +0100
Organization: At home
Message-ID: <eltroi$b4q$3@sea.gmane.org>
References: <7vr6v2aofs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612140957590.3635@wbgn013.biozentrum.uni-wuerzburg.de> <9A80051B-1F6B-4FFD-B33F-84121D3A422F@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 15 Dec 2006 10:05:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 31
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34488>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv9wH-0001Ul-TH for gcvg-git@gmane.org; Fri, 15 Dec
 2006 11:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751696AbWLOKFK convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006 05:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWLOKFK
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 05:05:10 -0500
Received: from main.gmane.org ([80.91.229.2]:44370 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751696AbWLOKFI
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 05:05:08 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gv9w5-00018y-Sb for git@vger.kernel.org; Fri, 15 Dec 2006 11:05:01 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 11:05:01 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 11:05:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Brian Gernhardt wrote:

> -This command shows changes between four combinations of states.
> +Show changes between two trees, a tree and the working tree, a
> +tree and the index file, or the index file and the working tree.
> +The combination of what is compared with what is determined by
> +the number of trees given to the command.

You talk here about "number of _trees_" while later you use <commit>,
not <tree> or <tree-ish>. Only at the very end you say that <commit>
(<commit-ish> because you can use tags as well) can be replaced by
any <tree-ish>.

That said, I like this clarification, especially the fact that
I don't have to go to git-diff-tree(1) to find diff options.

> 'git-diff' [--options] [--] [<path>...]::
> @@ -25,11 +28,11 @@ This command shows changes between four =A0
> combinations of states.
> 'git-diff' [--options] --cached [<commit>] [--] [<path>...]::
> =A0=A0=A0=A0=A0=A0=A0=A0This form is to view the changes you staged f=
or the next
> -=A0=A0=A0=A0=A0=A0=A0commit relative to the named <tree-ish>. =A0Typ=
ically you
> +=A0=A0=A0=A0=A0=A0=A0commit relative to the named <commit>. =A0Typic=
ally you
> =A0=A0=A0=A0=A0=A0=A0=A0would want comparison with the latest commit,=
 so if you
> =A0=A0=A0=A0=A0=A0=A0=A0do not give <commit>, it defaults to HEAD.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

