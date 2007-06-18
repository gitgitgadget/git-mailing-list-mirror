From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: make Apple's FileMerge available as a merge_tool
Date: Mon, 18 Jun 2007 09:18:00 -0400
Message-ID: <20070618131800.GA30244@thunk.org>
References: <11820959413590-git-send-email-prohaska@zib.de> <B12626B9-766E-4EA4-888F-B3E2DA889D15@zib.de> <20070617181200.GA15218@thunk.org> <42FEB11E-426D-4B44-9E7E-0E35032CB1B0@zib.de> <467652BC.4050900@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Mon Jun 18 15:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0H7Y-0000KK-0L
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 15:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761263AbXFRNSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 09:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759450AbXFRNSL
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 09:18:11 -0400
Received: from thunk.org ([69.25.196.29]:39095 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbXFRNSK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 09:18:10 -0400
Received: from root (helo=tinytim.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1I0HEy-0001Md-6h; Mon, 18 Jun 2007 09:25:56 -0400
Received: from tytso by tinytim.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1I0H7I-0007tk-Dl; Mon, 18 Jun 2007 09:18:00 -0400
Content-Disposition: inline
In-Reply-To: <467652BC.4050900@slamb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50395>

On Mon, Jun 18, 2007 at 02:39:08AM -0700, Scott Lamb wrote:
> I propose a simpler test:
> 
>     if [ -n "$TERM_PROGRAM" ]; then
>         echo local
>     else
>         echo remote
>     fi
> 
> This environment variable seems to be set by Terminal.app and even two
> alternatives I just tried (iTerm.app and GLterm.app). It's not
> transmitted across ssh unless you stick an AcceptEnv in sshd_config.

Thanks, that's just what I was looking for!

						- Ted
