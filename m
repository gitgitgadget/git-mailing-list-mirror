From: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
Subject: Re: git rebase --interactive problems
Date: Mon, 7 Sep 2009 13:04:09 +0000
Message-ID: <20090907130409.GA10879@sajinet.com.pe>
References: <1252326716.7497.1333578429@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Rodgman <dav1dr@eml.cc>
X-From: git-owner@vger.kernel.org Mon Sep 07 15:04:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkdtK-0000mM-Fv
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 15:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397AbZIGNEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 09:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbZIGNEH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 09:04:07 -0400
Received: from sajino.sajinet.com.pe ([76.74.239.193]:50173 "EHLO
	sajino.sajinet.com.pe" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZIGNEH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 09:04:07 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Sep 2009 09:04:07 EDT
Received: by sajino.sajinet.com.pe (Postfix, from userid 1000)
	id 6B8CFA581DC; Mon,  7 Sep 2009 13:04:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1252326716.7497.1333578429@webmail.messagingengine.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127927>

On Mon, Sep 07, 2009 at 01:31:56PM +0100, Dave Rodgman wrote:
> 
> Am I doing something wrong, or is this a bug? I am using git 1.6.4.2

can you do before running the rebase (assuming a bourne shell) :

  unset GREP_OPTIONS

this looks like the bug I just send a patch to the list to fix and
which seems to be also reported in Ubuntu as :

  https://bugs.launchpad.net/ubuntu/+source/git-core/+bug/398393

Carlo
