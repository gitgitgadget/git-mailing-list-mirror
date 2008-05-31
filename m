From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] Add test cases for git-am
Date: Sun, 1 Jun 2008 00:07:24 +0200
Message-ID: <20080531220723.GD5907@leksak.fem-net>
References: <20080530140447.GB10514@leksak.fem-net> <7vy75rh25i.fsf@gitster.siamese.dyndns.org> <20080531024027.GB5907@leksak.fem-net> <7viqwuffdy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 00:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ZFU-0003sW-2T
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 00:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbYEaWHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 18:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbYEaWHf
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 18:07:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:50818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753790AbYEaWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 18:07:35 -0400
Received: (qmail invoked by alias); 31 May 2008 22:07:33 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp027) with SMTP; 01 Jun 2008 00:07:33 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+FRVQdCKqFPTOcLTQ3AFM2KshL/bAMNDpRepNCjc
	ukoypAW+pyo8z7
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K2ZES-0003cm-0H; Sun, 01 Jun 2008 00:07:24 +0200
Content-Disposition: inline
In-Reply-To: <7viqwuffdy.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83407>

Hi,

> "git grep 'tail.*+' -- '*.sh'" says that this will the first and only
> instance of "tail -n +<number>".  The syntax may be POSIX but not all
> /usr/bin/tail unfortunately knows about it.
> 
> I tend to prefer "sed -n -e '3,$p'" for things like this for portability.

I'm fine with that, but I sometimes wonder if systems that do not like
"tail -n +3" really tend to like a "sed -n -e '3,$p'" :)

Well,
Patch v2 follows. (Let's give git-send-email a chance.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
