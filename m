From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn fetch fails with Temp file with moniker
	'svn_delta'already in use
Date: Wed, 8 Jul 2009 11:51:15 -0700
Message-ID: <20090708185115.GA14522@dcvr.yhbt.net>
References: <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE024DD5C1@IBCPTEX01.intecbilling.com> <B4BD8C6031F4EC4DAD8EABAB3ABA6CFE025132AF@IBCPTEX01.intecbilling.com> <4A549DAC.6010206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Marcus Griep <marcus@griep.us>
To: Andre Mostert <Andre.Mostert@intecbilling.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOcEm-0005dR-De
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 20:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756137AbZGHSvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 14:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbZGHSvQ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 14:51:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54458 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbZGHSvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 14:51:16 -0400
Received: from localhost (unknown [12.186.229.34])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id DDCD01F604;
	Wed,  8 Jul 2009 18:51:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A549DAC.6010206@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122911>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Andre Mostert schrieb:
> > /usr/local/apr/lib/libapr-1.so.0(apr_allocator_destroy+0x1d)[0x7fd7f450794d]
> > /usr/local/apr/lib/libapr-1.so.0(apr_pool_terminate+0x34)[0x7fd7f4508494]
> > /usr/lib/perl5/site_perl/5.10.0/x86_64-linux/auto/SVN/_Core/_Core.so(_wrap_apr_terminate+0x53)[0x7fd7f5eb19a3]
> > /usr/bin/perl(Perl_pp_entersub+0x56a)[0x46663a]
> 
> Are you sure that your /usr/local/apr is compatible with your /usr/bin/perl?

Not only that is suspicious, it seems Andre is mixing the SVN Perl
modules (presumably from the distro, Ubuntu, in /usr/lib/) with SVN
libraries in /usr/local, which I doubt was provided by the distro.
AFAIK Ubuntu (like Debian) doesn't touch /usr/local at all.

-- 
Eric Wong
