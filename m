From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: [PATCH] Fix cg-status with recent git versions
Date: Fri, 28 Apr 2006 01:46:22 +0200
Message-ID: <20060427234621.GA13896@vsectoor.geht-ab-wie-schnitzel.de>
References: <20060427223826.10772.55883.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 28 01:47:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGCT-0005hq-Du
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 01:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWD0XrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 19:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWD0XrG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 19:47:06 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:52753 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751756AbWD0XrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 19:47:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 9C4673E67
	for <git@vger.kernel.org>; Fri, 28 Apr 2006 01:47:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jD7NP0b566u6 for <git@vger.kernel.org>;
	Fri, 28 Apr 2006 01:46:26 +0200 (CEST)
Received: by vsectoor.geht-ab-wie-schnitzel.de (Postfix, from userid 1000)
	id CE69C3F7C; Fri, 28 Apr 2006 01:46:23 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060427223826.10772.55883.stgit@dv.roinet.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19253>

On Thu, Apr 27, 2006 at 06:38:26PM -0400, Pavel Roskin wrote:
> From: Pavel Roskin <proski@gnu.org>
> 
> git-diff-index checks the arguments by lstat(), so an empty string would
> fail to be recognized as a file.  Use "--" to separate files from
> revisions, and also use "." instead of the empty string.

Thank you very much for recognizing... i was tempted to report that
bug... but was not sure if it is fixed yet...

Sincerly
Nicolas
