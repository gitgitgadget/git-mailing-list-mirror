From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Gnome chose Git
Date: Thu, 19 Mar 2009 14:33:45 +0100
Message-ID: <49C249B9.7010001@drmicha.warpmail.net>
References: <877i2lbvt7.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Mar 19 14:35:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkIPQ-0008Bi-Uh
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 14:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZCSNeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 09:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZCSNeE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 09:34:04 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:36962 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754370AbZCSNeD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 09:34:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D651C2F6F6E;
	Thu, 19 Mar 2009 09:33:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 19 Mar 2009 09:33:59 -0400
X-Sasl-enc: 52/LT31py+BVtubpvyRKcd7Hacreii/kecUTbfmsE7zx 1237469639
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 30E8C389D2;
	Thu, 19 Mar 2009 09:33:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090319 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <877i2lbvt7.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113769>

Teemu Likonen venit, vidit, dixit 19.03.2009 12:23:
> FYI: The Gnome release team just announced that Gnome will migrate from
> Subversion to Git:
> 
>     http://thread.gmane.org/gmane.comp.gnome.infrastructure/1134

Good choice :)

Interestingly, they seem to go the svn-all-fast-export route.

Also, they need push tracking for pushing through ssh, which is a common
requirement for many large projects. Do we have something to support
that? git-notes comes to my mind.

Their current approach is writing to a single log file (receive-hook).
That may support a linear push history best, but looking up who pushed
what, given "what"?

Michael
