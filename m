From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git svn fetch fails with Temp file with moniker 'svn_delta'already
 in use
Date: Wed, 08 Jul 2009 15:22:52 +0200
Message-ID: <4A549DAC.6010206@viscovery.net>
References: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD5C1@IBCPTEX01.intecbilling.com> <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE025132AF@IBCPTEX01.intecbilling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Marcus Griep <marcus@griep.us>
To: Andre Mostert <Andre.Mostert@intecbilling.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:24:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOX7C-0003dI-4Z
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 15:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZGHNXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 09:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbZGHNXH
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 09:23:07 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44318 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753935AbZGHNXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 09:23:06 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOX6x-0005OC-HJ; Wed, 08 Jul 2009 15:23:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8C17D4E4; Wed,  8 Jul 2009 15:22:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE025132AF@IBCPTEX01.intecbilling.com>
X-Spam-Score: -0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122897>

Andre Mostert schrieb:
> /usr/local/apr/lib/libapr-1.so.0(apr_allocator_destroy+0x1d)[0x7fd7f450794d]
> /usr/local/apr/lib/libapr-1.so.0(apr_pool_terminate+0x34)[0x7fd7f4508494]
> /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Core/_Core.so(_wrap_apr_terminate+0x53)[0x7fd7f5eb19a3]
> /usr/bin/perl(Perl_pp_entersub+0x56a)[0x46663a]

Are you sure that your /usr/local/apr is compatible with your /usr/bin/perl?

-- Hannes
