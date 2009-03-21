From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked branch
Date: Sat, 21 Mar 2009 01:35:33 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903210135.33729.agruen@suse.de>
References: <200903181448.50706.agruen@suse.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org> <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Mar 21 01:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkpFh-0001ip-RJ
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 01:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbZCUAiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 20:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbZCUAiS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 20:38:18 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42081 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbZCUAiS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 20:38:18 -0400
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 798C679727;
	Sat, 21 Mar 2009 01:38:15 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0903202300330.13726@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114019>

On Saturday, 21 March 2009 0:08:42 Julian Phillips wrote:
> How about adding a generic escape hatch, that would cover this and
> future extensions?
>
> Let a ref that starts with a single quote be taken as given and not
> processed.  You have to escape it to get it past the shell, but that makes
> it rather unlikely that anyone has used a name that starts with a quote -
> and if they have you can still use this mechanism to rename it.

To me the most obvious escape sequence would be \x for disabling whatever 
special meaning x has (for non-alphabetic x). With quoting you likely 
eventually end up needing  \' in some cases anyway...

Andreas
