From: Junio C Hamano <gitster@pobox.com>
Subject: Re: markdown 2 man, was Re: Git Community Book
Date: Thu, 31 Jul 2008 17:45:29 -0700
Message-ID: <7vvdylv9zq.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <20080729170955.GK32184@machine.or.cz>
 <d411cc4a0807291130p228f77d5r1f390090ec29aef4@mail.gmail.com>
 <7vwsj4edm1.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0807291957410.1779@reaper.quantumfyre.co.uk>
 <alpine.LSU.1.00.0807301514280.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vy73j418t.fsf@gitster.siamese.dyndns.org> <4891A0D0.6060503@lyx.org>
 <20080731130101.GC18106@leksak.fem-net> <4891CD34.1070308@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Scott Chacon <schacon@gmail.com>, Petr Baudis <pasky@suse.cz>
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 02:46:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOinA-0007fO-Lk
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 02:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYHAApr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 20:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752671AbYHAApr
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 20:45:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYHAApp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 20:45:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68FA9446C1;
	Thu, 31 Jul 2008 20:45:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B9D2C446B9; Thu, 31 Jul 2008 20:45:32 -0400 (EDT)
In-Reply-To: <4891CD34.1070308@lyx.org> (Abdelrazak Younes's message of "Thu,
 31 Jul 2008 16:33:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C7ECD68-5F63-11DD-A85F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91013>

Abdelrazak Younes <younes@lyx.org> writes:

> I just had a look at the user manual and, well unless you have a
> special emacs mode or whatever that can automate the markup tag
> insertion, I wonder how can anybody think that writing with this
> markup language is easier than within LyX, really (genuine question,
> not sarcasm).

How greppable and "log -p"-able is the documentation written in LyX?

 * Where in the documentation do I have to change the description of
   "--parents" option?

 * When did the description of "--cc" for diff families last changed, by
   whom and why?

Eas of doing these is mostly why we chose AsciiDoc to begin with.  Any
alternative you are going to suggest should not make these two things
impossible or very harder to do.
