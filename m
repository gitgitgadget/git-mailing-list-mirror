From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] t/test-lib.sh: support Korn shell by converting GIT_EXIT_OK to GIT_EXIT_CODE
Date: Sat, 10 Oct 2009 14:24:40 +0200
Message-ID: <m2eipbphbr.fsf@igel.home>
References: <1eweIwf5YoFwmLPWwEFN69a2f-EUnj_kgiagVJoVQYfNQeLjlpm12U84RKxhzjh0NJv36SqO12lAX2c_x0WSgA@cipher.nrlssc.navy.mil>
	<20091010120121.GA16336@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Oct 10 14:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwb4U-00015A-D4
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 14:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760860AbZJJMZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 08:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760531AbZJJMZm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 08:25:42 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55737 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758431AbZJJMZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 08:25:41 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D806E1C15301;
	Sat, 10 Oct 2009 14:24:42 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id C048E901FE;
	Sat, 10 Oct 2009 14:24:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id 9vG3bhTTY8YS; Sat, 10 Oct 2009 14:24:41 +0200 (CEST)
Received: from igel.home (DSL01.83.171.147.187.ip-pool.NEFkom.net [83.171.147.187])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 10 Oct 2009 14:24:41 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 29D5710C5B3; Sat, 10 Oct 2009 14:24:40 +0200 (CEST)
X-Yow: Now, let's SEND OUT for QUICHE!!
In-Reply-To: <20091010120121.GA16336@localhost> (Clemens Buchacher's message
	of "Sat, 10 Oct 2009 14:01:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129881>

Clemens Buchacher <drizzd@aon.at> writes:

> Hi,
>
> On Fri, Oct 09, 2009 at 01:39:56PM -0500, Brandon Casey wrote:
>
>> For the Korn shell, $? has the value of the last executed statement
>> _before_ the call to exit.
>
> I just installed ksh/stable (version 93s+ 2008-01-31) on Debian and it
> behaves correctly. Maybe you need to upgrade? This really looks like a bug
> in your shell to me.

According to the autoconf docs this bug is also present in the Solaris
/bin/sh (and autoconf generated scripts use some elaborated workaround).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
