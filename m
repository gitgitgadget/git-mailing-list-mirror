From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: Announcing nntpgit
Date: Fri, 24 Feb 2012 14:43:09 -0700
Organization: LWN.net
Message-ID: <20120224144309.4657052e@dt>
References: <20120224133942.49a7a420@dt>
	<7v62evykrq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:43:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12vI-0005LW-KO
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757286Ab2BXVnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:43:12 -0500
Received: from tex.lwn.net ([70.33.254.29]:38363 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766Ab2BXVnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:43:11 -0500
Received: from dt (localhost.localdomain [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by vena.lwn.net (Postfix) with ESMTP id 6D36B154005A;
	Fri, 24 Feb 2012 14:43:10 -0700 (MST)
In-Reply-To: <7v62evykrq.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191487>

On Fri, 24 Feb 2012 13:38:33 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> How do you handle message threading (References: and In-Reply-To:)?
> 
> Would a commit on the "mainline" (a rough approximation of it would be
> "log --first-parent" starting from the tip) form the discussion starter
> article, and any side branch that fork from them would be a discussion
> thread starting at the commit?

There's really no threading at all at this point; it's just a linear
series of commits-as-messages as provided by a vanilla "git log".  I could
certainly see trying to do something fancier, if it were useful, but it's
not something I've thought about much yet.

Like I said, it's really young stuff :)

jon
