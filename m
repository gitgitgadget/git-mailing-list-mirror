X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Wed, 01 Nov 2006 02:08:08 +0100
Organization: At home
Message-ID: <ei8s19$e04$1@sea.gmane.org>
References: <20060925044641.GB15757@spearce.org> <20061031174225.3c7c1e77.vsu@altlinux.ru> <7vac3covlf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 1 Nov 2006 01:08:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 22
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-116.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30615>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf4aV-0000Wc-VV for gcvg-git@gmane.org; Wed, 01 Nov
 2006 02:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423824AbWKABIN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 20:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423906AbWKABIN
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 20:08:13 -0500
Received: from main.gmane.org ([80.91.229.2]:60133 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423824AbWKABIM (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 20:08:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gf4aL-0000UZ-Jb for git@vger.kernel.org; Wed, 01 Nov 2006 02:08:05 +0100
Received: from host-81-190-18-116.torun.mm.pl ([81.190.18.116]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 02:08:05 +0100
Received: from jnareb by host-81-190-18-116.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 01 Nov 2006
 02:08:05 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Sergey Vlasov <vsu@altlinux.ru> writes:
>  
>> BTW, I was thinking about the possibility to save removed refs under,
>> e.g., refs/old/`date -I`/; maybe even non-fast-forward refs could be
>> saved there - this will ensure that no object will ever disappear from
>> the mirror, no matter what is done on the master side.  Obviously, in
>> this case remote refs like refs/old/* should be filtered.
> 
> I do not think that belongs to git-mirror.  It might be better to
> have that option in update-ref machinery so that you would even
> be protected from a `git branch -d` ran by mistake.

Perhaps just don't remove log when branch is deleted. I tend for example
to be careful when reordering commits on a branch, and use git branch -f
instead of deleting and recreating branch to not lose reflog.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

