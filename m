From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] pager: default to LESS=FRX not LESS=FRSX
Date: Tue, 27 Mar 2007 10:54:19 +0400
Message-ID: <20070327065419.GB51155@codelabs.ru>
References: <20070326073502.GD44578@codelabs.ru> <7vwt14xvaw.fsf@assigned-by-dhcp.cox.net> <20070326083617.GG13247@spearce.org> <7v8xdkxukt.fsf@assigned-by-dhcp.cox.net> <17928.7076.871485.136142@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 08:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW5Zi-0000mg-Sl
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbXC0Gyb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 02:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbXC0Gyb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:54:31 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:57488 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbXC0Gya (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 02:54:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=c4aCGHuQttAIQv0vsHaTzAsV8/zEdft2eJH3/z8dWW5Uqo3P0C1iZBKOOY+wFD1R+PwvpcX57hITPkUbjRJZsXMEwA8/gsBKizzPCCm62Zizaji8YqmWJv7BgaIaHvRzvN16/Vkbe05s60kqiT+v7Iq3d6SphUpCjjzuevf3xVQ=;
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HW5ZY-000DKS-73; Tue, 27 Mar 2007 10:54:24 +0400
Content-Disposition: inline
In-Reply-To: <17928.7076.871485.136142@lisa.zopyra.com>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43234>

Bill, good day.

Mon, Mar 26, 2007 at 01:14:44PM -0600, Bill Lear wrote:
> > (1) Learn to use left/right arrow keys under "less -S" if you
> >     have occasional lines that are too long.
> 
> Hmm, looking at the code: why, if the environment variable LESS is
> already set, should this all be worth talking about?  Shouldn't the
> user be able to set LESS to whatever they want, once, and be done with
> it?  The current setenv() call to set up the pager does this, correct?

If it was named GIT_LESS, then yes, I could set it to the defaults
that are sane for me with Git. But I do not like the idea of setting
-F, -R and -X for all less invocations. But OK, the 'l' and 'h'
bindings for less movements are fine with me. I do not like scrolling
very much (using 14400 modem lines sometimes, so it is a bit slow),
but if 'FRSX' are good defaults that people are used to, then I
should live with them. Or probably start the git-FRX toolchain ;))

OK, I feel that this thread is exhausted itself, so I am shutting up.
-- 
Eygene
