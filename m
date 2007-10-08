From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Mon, 8 Oct 2007 18:01:23 -0400
Message-ID: <20071008220123.GD31713@thunk.org>
References: <11918785613855-git-send-email-prohaska@zib.de> <20071008215729.GC31713@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 00:01:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If0fO-0005Nl-R7
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 00:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbXJHWB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 18:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXJHWB0
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 18:01:26 -0400
Received: from THUNK.ORG ([69.25.196.29]:44115 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864AbXJHWBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 18:01:25 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1If0ow-00013U-9M; Mon, 08 Oct 2007 18:11:26 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1If0fD-0005Fe-G6; Mon, 08 Oct 2007 18:01:23 -0400
Content-Disposition: inline
In-Reply-To: <20071008215729.GC31713@thunk.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60345>

On Mon, Oct 08, 2007 at 05:57:29PM -0400, Theodore Tso wrote:
> This patch doesn't work the config file doesn't specify an explicit
> mergetool via merge.tool.   The reason for that is this loop:

Err, let me try that again.  "This patch doesn't work IF the config
file doesn't specify an explicit > mergetool via merge.tool."

Sorry about the missing conjuction; the sentence doesn't make much
sense without it...

						- Ted
