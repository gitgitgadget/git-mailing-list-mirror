From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: diff settings
Date: Sun, 25 Jan 2009 13:11:29 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 22:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRCI8-0003RC-R5
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 22:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZAYVLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbZAYVLv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 16:11:51 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:38033 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbZAYVLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 16:11:51 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PLBT9f016615;
	Sun, 25 Jan 2009 13:11:29 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PLBTXR016612;
	Sun, 25 Jan 2009 13:11:29 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <497CD352.2060402@tedpavlic.com>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107104>

On Sun, 25 Jan 2009, Ted Pavlic wrote:

> Mercurial has a "defaults.*" that does exactly what you want. That is, you can
> say
> 
> [defaults]
> diff = -w
> 
> and "hg diff" will automatically do "hg diff -w". Such a feature might be a 
> nice addition to git.

Thank you, that is very interesting.  I just submitted a patch this morning that 
does exactly what you describe, but I called it "primer" instead of "defaults" 
because it seemed more explicit.  Check it out.

                            -- Keith
