From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 18:17:20 +0100
Message-ID: <m2r5b6y40v.fsf@igel.home>
References: <loom.20110217T074533-358@post.gmane.org>
	<20110217103431.GA8308@elie> <loom.20110217T130405-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 18:17:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq7UF-0002zk-Cz
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 18:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab1BQRR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 12:17:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:46191 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755357Ab1BQRRY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 12:17:24 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id F1CBF188B596;
	Thu, 17 Feb 2011 18:17:21 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3DB861C00164;
	Thu, 17 Feb 2011 18:17:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id n0+GX+8M5vp8; Thu, 17 Feb 2011 18:17:21 +0100 (CET)
Received: from igel.home (ppp-93-104-144-34.dynamic.mnet-online.de [93.104.144.34])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 17 Feb 2011 18:17:21 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C716CCA2A0; Thu, 17 Feb 2011 18:17:20 +0100 (CET)
X-Yow: Can I have an IMPULSE ITEM instead?
In-Reply-To: <loom.20110217T130405-970@post.gmane.org> (Chunlin Zhang's
	message of "Thu, 17 Feb 2011 12:06:33 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167094>

Chunlin Zhang <zhangchunlin@gmail.com> writes:

> use this command for example:
> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" cat-file blob 
> HEAD:Android.mk>Android.mk

You won't need --work-tree any more, since cat-file only looks at the
object database.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
