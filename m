From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Delete a commit
Date: Mon, 21 Dec 2009 19:17:51 +0100
Message-ID: <m2bphsdwds.fsf@igel.home>
References: <20091219233957.GC29111@marge.bs.l> <hgjpqu$dos$1@ger.gmane.org>
	<20091220004340.GA30440@marge.bs.l> <hgocfi$pge$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan 't Hart <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:18:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMmpV-0003n1-VY
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 19:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635AbZLUSR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbZLUSR4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 13:17:56 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:52479 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZLUSRz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 13:17:55 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4994E1C001D7;
	Mon, 21 Dec 2009 19:17:53 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 4267690137;
	Mon, 21 Dec 2009 19:17:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id 4zCcPrDUEfxj; Mon, 21 Dec 2009 19:17:52 +0100 (CET)
Received: from igel.home (DSL01.83.171.179.141.ip-pool.NEFkom.net [83.171.179.141])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon, 21 Dec 2009 19:17:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id BD82CCA28C; Mon, 21 Dec 2009 19:17:51 +0100 (CET)
X-Yow: Thousands of days of civilians ...  have produced a...
 feeling for the aesthetic modules --
In-Reply-To: <hgocfi$pge$1@ger.gmane.org> (Johan t. Hart's message of "Mon, 21
	Dec 2009 18:49:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135562>

Johan 't Hart <johanthart@gmail.com> writes:

> Bertram Scharpf schreef:
>> Hi,
>
>>   % git fsck --lost-found
>>   dangling commit 6abc221327e896c850c56dafae92277bcfe68e2b
>>
>> It is still there. This is the one I want to delete.
>
> It is not in the history of any head anymore, so you could consider it
> deleted. ('git log' does not show this commit)

Except through the reflog, most likely.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
