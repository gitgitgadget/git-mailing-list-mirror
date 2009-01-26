From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Emacs git-mode feature request: support fill-paragraph
         correctly
Date: Mon, 26 Jan 2009 12:15:04 +0000
Message-ID: <808woyz2k7.fsf@tiny.isode.net>
References: <87tz7mth3g.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Mon Jan 26 13:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQUG-0003Lo-A3
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbZAZMVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbZAZMVS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:21:18 -0500
Received: from rufus.isode.com ([62.3.217.251]:32936 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751420AbZAZMVR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 07:21:17 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jan 2009 07:21:17 EST
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SX2pSQB0lBMI@rufus.isode.com>; Mon, 26 Jan 2009 12:15:06 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 26 Jan 2009 12:15:05 +0000
X-Hashcash: 1:20:090126:simons@cryp.to::6WYl1eV3LafwKQc7:000CeEg
X-Hashcash: 1:20:090126:git@vger.kernel.org::pMajuLc8PEFu8DUl:0000000000000000000000000000000000000000001YS3
In-Reply-To: <87tz7mth3g.fsf@write-only.cryp.to> (Peter Simons's message of "Mon\, 26 Jan 2009 12\:57\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107204>

Peter Simons <simons@cryp.to> writes:

[...]

> Other modes, such as message-mode, do support that kind of thing
> correctly, so apparently it is possible to configure what the editor
> considers as a paragraph. Is there some Emacs wizard out there who'd
> be kind enough to improve git-mode accordingly?

I suspect this doesn't directly relate to git-mode.  What mode does
emacs say you're in at this point?  I'm guessing the buffer name is
COMMIT_EDITMSG and the mode is fundamental-mode?

In that case you could stick this in your .emacs if you wanted to use
message-mode:

(setq auto-mode-alist (cons '("COMMIT_EDITMSG" . message-mode) auto-mode-alist))
