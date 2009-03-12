From: Miles Bader <miles@gnu.org>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Thu, 12 Mar 2009 19:52:29 +0900
Message-ID: <buomybrqahe.fsf@dhlpc061.dev.necel.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	<7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
	<20090310100400.GC11448@pvv.org>
	<7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
	<20090312120109.6117@nanako3.lavabit.com>
	<20090312102243.GA27665@pvv.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Thu Mar 12 11:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhiYx-0005J0-EB
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 11:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbZCLKxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 06:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbZCLKxV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 06:53:21 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:37423 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbZCLKxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 06:53:20 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2CAqUYo016927;
	Thu, 12 Mar 2009 19:52:30 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Thu, 12 Mar 2009 19:52:30 +0900
Received: from dhlpc061 ([10.114.114.241] [10.114.114.241]) by relay21.aps.necel.com with ESMTP; Thu, 12 Mar 2009 19:52:29 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B881C52E277; Thu, 12 Mar 2009 19:52:29 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20090312102243.GA27665@pvv.org> (Finn Arne Gangstad's message of
	"Thu, 12 Mar 2009 11:22:43 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113040>

Finn Arne Gangstad <finnag@pvv.org> writes:
> The main problem with all these examples is that the underlying
> assumption is that you can always use the same branch name locally and
> remotely.

Presumably the push --track option would be used with an explicit branch
name given to push anyway, right?  Then it can use that info to set up
the tracking flexibly (and with sane defaults).

E.g.,, simple case:

    git push --track SOME_REMOTE BRANCH_NAME

complex case:

    git push --track SOME_REMOTE MY-BRANCH:REMOTE-BRANCH

-Miles

-- 
=====
(^o^;
(()))
*This is the cute octopus virus, please copy it into your sig so it can spread.
