From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC/PATCH 4/5] Documentation: reset: describe new "--keep" option
Date: Sat, 02 Jan 2010 10:06:34 +0100
Message-ID: <m2vdfkanad.fsf@igel.home>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
	<20100102053934.30066.76552.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 10:07:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQzx7-0005Sc-Q0
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 10:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0ABJGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 04:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593Ab0ABJGm
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 04:06:42 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:54997 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab0ABJGk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 04:06:40 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4FF421C001A2;
	Sat,  2 Jan 2010 10:06:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 3F5F1901B9;
	Sat,  2 Jan 2010 10:06:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Wf3llGpfAbjX; Sat,  2 Jan 2010 10:06:35 +0100 (CET)
Received: from igel.home (DSL01.83.171.173.176.ip-pool.NEFkom.net [83.171.173.176])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  2 Jan 2010 10:06:35 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 0F4EDCA28C; Sat,  2 Jan 2010 10:06:34 +0100 (CET)
X-Yow: ..  my NOSE is NUMB!
In-Reply-To: <20100102053934.30066.76552.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 02 Jan 2010 06:39:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136025>

Christian Couder <chriscool@tuxfamily.org> writes:

> +--keep::
> +	Resets the index to match the tree recorded by the named commit,
> +	but keep changes in the working tree. Aborts if the reset would
> +	change files that are already changes in the working tree.

s/changes/changed/ in the last sentence.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
