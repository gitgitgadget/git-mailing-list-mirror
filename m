From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Feature Proposal: Track all branches from a given remote
Date: Sun, 26 Oct 2014 12:18:33 +0100
Message-ID: <87a94j3wqe.fsf@igel.home>
References: <CAEFop41rvXCAawW7zWGzT251zWyyoMhQbg=5vtHzQrbk4W6D_Q@mail.gmail.com>
	<20141026001610.GK312818@vauxhall.crustytoothpaste.net>
	<CAEFop40qOPaq-6QrvNR0_MsgTv4K0jDNqb+m=BUZzFSXQ35YSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
To: Scott Johnson <jaywir3@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 12:18:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiLqL-00041a-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 12:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbaJZLSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 07:18:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46785 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbaJZLSg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 07:18:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jQcB26sZPz3hjGk;
	Sun, 26 Oct 2014 12:18:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jQcB22fjdzvh1t;
	Sun, 26 Oct 2014 12:18:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id c3wXjRc7TCU4; Sun, 26 Oct 2014 12:18:33 +0100 (CET)
X-Auth-Info: 3h7PMF8mfXP7eP80gqyrQBVGaPCCtBV2MM9XyA5kobVIO7UjGLknBcZKwLNDC25M
Received: from igel.home (ppp-93-104-158-8.dynamic.mnet-online.de [93.104.158.8])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 26 Oct 2014 12:18:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 32BD82C19C5; Sun, 26 Oct 2014 12:18:33 +0100 (CET)
X-Yow: I just forgot my whole philosophy of life!!!
In-Reply-To: <CAEFop40qOPaq-6QrvNR0_MsgTv4K0jDNqb+m=BUZzFSXQ35YSQ@mail.gmail.com>
	(Scott Johnson's message of "Sun, 26 Oct 2014 02:57:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Scott Johnson <jaywir3@gmail.com> writes:

> Do you think there would be any interest in a patch that added this as
> a simple command line option, though? I guess the idea of this patch
> then would simply change this line in the .git/config file for the
> length of the operation (and specified remote), execute the git pull
> command, and then reset the configuration after the command finished.

There is no need to modify the configuration, you can pass the fetch
spec on the command line.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
