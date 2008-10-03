From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Numeric Revision Names?
Date: Fri, 03 Oct 2008 13:44:10 +0100
Message-ID: <80r66x7srp.fsf@tiny.isode.net>
References: <19796862.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marceloribeiro <marcelo@sonnay.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 14:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klk2F-0007rX-AT
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 14:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYJCMoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 08:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYJCMoO
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 08:44:14 -0400
Received: from rufus.isode.com ([62.3.217.251]:48460 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYJCMoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 08:44:13 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SOYTmgA4AWBp@rufus.isode.com>; Fri, 3 Oct 2008 13:44:10 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Fri, 03 Oct 2008 13:44:10 +0100
X-Hashcash: 1:20:081003:marcelo@sonnay.com::gMhdtLdJo356qS6r:00000000000000000000000000000000000000000003VZB
X-Hashcash: 1:20:081003:git@vger.kernel.org::RCe4AiapZrE1wfdA:0000000000000000000000000000000000000000003iFd
In-Reply-To: <19796862.post@talk.nabble.com> (marceloribeiro's message of "Fri\, 3 Oct 2008 05\:37\:07 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97423>

marceloribeiro <marcelo@sonnay.com> writes:

[...]

> Is there any way to configure it to start a projects revisions on
> lets say, revision 0, and keep incrementing it after each commit?

No.

[...]

(There's no such numbering system that would work entirely
satisfactorily in a distributed system.  Some systems have numbering
schemes that are perhaps easier to use (at least for some purposes)
than the underlying hashes, but no such scheme is used in git.)
