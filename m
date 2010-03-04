From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: How do I get the correct modification status after running git diff?
Date: Thu, 04 Mar 2010 17:39:00 +0100
Message-ID: <m2lje8avob.fsf@igel.home>
References: <27782430.post@talk.nabble.com> <27782895.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 17:39:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnE4u-00025O-Co
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 17:39:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab0CDQjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 11:39:07 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:41428 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755375Ab0CDQjF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 11:39:05 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 077071C00210;
	Thu,  4 Mar 2010 17:39:02 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.166])
	by mail.m-online.net (Postfix) with ESMTP id F0E1F901B1;
	Thu,  4 Mar 2010 17:39:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.6.166]) (amavisd-new, port 10024)
	with ESMTP id TbFxicfvtGeL; Thu,  4 Mar 2010 17:39:01 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.30.ip-pool.NEFkom.net [83.171.145.30])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  4 Mar 2010 17:39:00 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 8F8E6CA297; Thu,  4 Mar 2010 17:39:00 +0100 (CET)
X-Yow: A dwarf is passing out somewhere in Detroit!
In-Reply-To: <27782895.post@talk.nabble.com> (jateeq's message of "Thu, 4 Mar
	2010 08:11:13 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141533>

jateeq <jawad_atiq@hotmail.com> writes:

> Renaming flie:
> mv randomfile.xml random.xml
>
> Diffing:
> git diff -M --name-status HEAD
>
> Output:
> D      randomfile.xml

random.xml is an untracked file, thus ignored.  You need to add -N it
first.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
