From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH RESEND] Git.pm: Always set Repository to absolute path
	if autodetecting
Date: Wed, 27 May 2009 15:46:17 +0200
Message-ID: <20090527134617.GY17706@mail-vs.djpig.de>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de> <1241703688-6892-2-git-send-email-frank@lichtenheld.de> <4A1A49C0.7040102@viscovery.net> <20090527105454.GW17706@mail-vs.djpig.de> <4A1D2100.5040903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 27 15:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9JSj-0000FD-Um
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 15:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762634AbZE0NqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759198AbZE0NqY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 09:46:24 -0400
Received: from pauli.djpig.de ([78.46.38.139]:46982 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762101AbZE0NqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 09:46:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 33BB19007F;
	Wed, 27 May 2009 15:46:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKzCfnxB3nS6; Wed, 27 May 2009 15:46:17 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id B26B69007C;
	Wed, 27 May 2009 15:46:17 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1M9JST-0003bx-J5; Wed, 27 May 2009 15:46:17 +0200
Content-Disposition: inline
In-Reply-To: <4A1D2100.5040903@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120064>

On Wed, May 27, 2009 at 01:16:16PM +0200, Johannes Sixt wrote:
> Frank Lichtenheld schrieb:
> > As for the problems, a part of the public API of the module simply doesn't work
> > (i.e. wc_chdir) which I fixed. If we can't fix it we should at least not pretend
> > that it works.
> 
> Since you keep repeating "does not work", without any specifics, I can't
> help (and I'm not going to find out myself what "does not work").

Oh, sorry, I thought that the core problem would be obvious from the related test
suite changes. I can elaborate on that later this evening when I'm not at work.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
