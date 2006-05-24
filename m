From: Jeff King <peff@peff.net>
Subject: Re: Incremental cvsimports
Date: Wed, 24 May 2006 08:22:46 -0400
Message-ID: <20060524122246.GA3997@coredump.intra.peff.net>
References: <93c3eada0605240046t10e00119n4cfc39ec33fe1d92@mail.gmail.com> <46a038f90605240121o117fadb6vf3ce910a3ad3e90@mail.gmail.com> <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 14:22:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FisO5-0005QE-Qh
	for gcvg-git@gmane.org; Wed, 24 May 2006 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWEXMWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 08:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWEXMWs
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 08:22:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:62445 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932295AbWEXMWr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 08:22:47 -0400
Received: (qmail 80207 invoked from network); 24 May 2006 12:22:46 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 24 May 2006 12:22:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 May 2006 08:22:46 -0400
To: geoff@austrics.com.au
Mail-Followup-To: geoff@austrics.com.au,
	Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <93c3eada0605240419o48891cdle6c100fc0ac870ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20680>

On Wed, May 24, 2006 at 08:49:03PM +0930, Geoff Russell wrote:

> I did have to change 2 lines in git-cvsimport to get it to run with my
> 5.8.0 perl (problems with POSIX errno). I've attached a patch but my
> work around isn't as quick as what it replaced.

Can you describe your problem in more detail? The POSIX errno constants
have been available since long before 5.8.0, so we should be able to use
them.

(btw, the change was introduced in my commit() cleanups:
  e73aefe4fdba0d161d9878642c69b40d83a0204c).

-Peff
