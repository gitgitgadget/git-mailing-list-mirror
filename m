From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Dealing with many many git repos in a /home directory
Date: Thu, 04 Feb 2010 16:32:41 +0100
Message-ID: <m24olxuicm.fsf@igel.home>
References: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 16:32:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd3hL-0003Lz-Hr
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 16:32:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691Ab0BDPcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 10:32:45 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:55781 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278Ab0BDPco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 10:32:44 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id CEE891C1555B;
	Thu,  4 Feb 2010 16:32:42 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.166])
	by mail.m-online.net (Postfix) with ESMTP id C6D1190073;
	Thu,  4 Feb 2010 16:32:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.6.166]) (amavisd-new, port 10024)
	with ESMTP id wh6CKGxDe53f; Thu,  4 Feb 2010 16:32:41 +0100 (CET)
Received: from igel.home (DSL01.83.171.156.41.ip-pool.NEFkom.net [83.171.156.41])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  4 Feb 2010 16:32:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 71809CA294; Thu,  4 Feb 2010 16:32:41 +0100 (CET)
X-Yow: Hey, I LIKE that POINT!!
In-Reply-To: <9b18b3111002040029x1c7de0afw4a5ef883588f7a18@mail.gmail.com>
	(demerphq@gmail.com's message of "Thu, 4 Feb 2010 09:29:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138968>

demerphq <demerphq@gmail.com> writes:

> At $work we have a host where we have about 50-100 users each with
> their own private copies of the same repos. These are cloned froma
> remote via git/ssh and are not thus automatically hardlinking their
> object stores.
>
> This is starting to take a lot of space.

Create local mirrors of the remote repos (and update them regularily)
and ask the users to borrow from them.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
