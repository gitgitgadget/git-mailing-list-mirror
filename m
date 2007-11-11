From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 12:34:37 -0800
Message-ID: <7vhcjscyhu.fsf@gitster.siamese.dyndns.org>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	<7vabpliz13.fsf@gitster.siamese.dyndns.org>
	<46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Yin Ping" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:35:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrJWM-0006pS-He
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104AbXKKUep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 15:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757267AbXKKUep
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 15:34:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60542 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbXKKUeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 15:34:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id F33252F0;
	Sun, 11 Nov 2007 15:35:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 857F594717;
	Sun, 11 Nov 2007 15:35:02 -0500 (EST)
In-Reply-To: <46dff0320711102218h259199e3g2b4a4d3b73202cdb@mail.gmail.com>
	(Yin Ping's message of "Sun, 11 Nov 2007 14:18:11 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64509>

"Yin Ping" <pkufranky@gmail.com> writes:

> I think it's this kind of case in most open-source project. However,
> in a company environment, superprojects may be not so super.

Let's not say "most open-source" nor "company", because I think
nobody said anything that substantiates that the commit density
characteristics I described is typical for most open-source, nor
what you said is typical for corporate development projects, in
this thread so far.

If "superprojects is not so super", why are you using submodule
to bind these, instead of using a single project that tracks
developments of such closely tied parts?

I am not saying that it is wrong to use submodule to track such
groups of source trees whose versions are very closely tied
together.  At least not yet.

I am just trying to find out what benefit you are getting out of
the submodule support, after rejecting one of the most visible
and advertised benefit of submodule support, which is to enable
binding "related but not that closely tied together" projects.
