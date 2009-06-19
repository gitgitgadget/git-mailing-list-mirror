From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Fri, 19 Jun 2009 16:18:33 +0900
Message-ID: <buo7hz8u1x2.fsf@dhlpc061.dev.necel.com>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	<7vk53aymuz.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181030260.4848@intel-tinevez-2-302>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 09:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHYNt-0008DK-TO
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 09:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbZFSHTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 03:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbZFSHTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 03:19:09 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:56433 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZFSHTI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 03:19:08 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n5J7IXku025796;
	Fri, 19 Jun 2009 16:18:53 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Fri, 19 Jun 2009 16:18:34 +0900
Received: from dhlpc061 ([10.114.112.101] [10.114.112.101]) by relay21.aps.necel.com with ESMTP; Fri, 19 Jun 2009 16:18:34 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id C47F252E1E2; Fri, 19 Jun 2009 16:18:33 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <alpine.DEB.1.00.0906181030260.4848@intel-tinevez-2-302>
	(Johannes Schindelin's message of "Thu, 18 Jun 2009 10:33:43 +0200
	(CEST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121884>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Okay, I'll add another point that should convince you that the commit 
> message is not the good place to trigger that behavior:
>
> Interactive rebasing is about having made a quite messy patch series, 
> maybe having a few fixup commits, and then deciding how to clean it up.
>
> The decision how to clean it up is very much a rebase-time decision, not a 
> commit-time decision.

I agree.

Magic commit messages are not good for this kind of thing.

-Miles

-- 
Do not taunt Happy Fun Ball.
