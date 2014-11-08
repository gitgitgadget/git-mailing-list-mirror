From: Thomas Quinot <thomas@quinot.org>
Subject: Re: [PATCH] git_connect: allow passing arguments to ssh in
 GIT_SSH_ARGS
Date: Sat, 8 Nov 2014 13:35:54 +0100
Message-ID: <20141108123554.GA90057@melamine.cuivre.fr.eu.org>
References: <20141108104439.GA89717@melamine.cuivre.fr.eu.org>
 <20141108110958.GB20750@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 08 13:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn5FO-0008It-Ir
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 13:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaKHMf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 07:35:57 -0500
Received: from houdart.cuivre.fr.eu.org ([81.57.40.110]:14380 "EHLO
	melamine.cuivre.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbaKHMf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 07:35:57 -0500
Received: by melamine.cuivre.fr.eu.org (Postfix, from userid 1000)
	id A2AF6359F5; Sat,  8 Nov 2014 13:35:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20141108110958.GB20750@peff.net>
X-message-flag: WARNING! Using Outlook can damage your computer.
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff,

Thanks for your feedback!

* Jeff King, 2014-11-08 :

> What do you think of adding an alternate variable that is not ssh
> _arguments_, but rather just a full shell command for running ssh?
> I'm not sure what it could be called (GIT_SSH_SH is probably too
> confusing).

Interesting idea, I had not thought of this, but I agree that it looks
nicer and more flexible from the user's point of view. In addition, it
turns out that it makes the implementation even simpler! I suggest
'GIT_SSH_CMD' for the variable name; patch v2 coming...

Thomas.
