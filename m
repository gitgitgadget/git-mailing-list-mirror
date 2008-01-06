From: David Brown <git@davidb.org>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 00:04:15 -0800
Message-ID: <20080106080415.GA15268@old.davidb.org>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Jon Hancock <redstarling@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 09:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBQV1-0007oZ-8c
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 09:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYAFIER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 03:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYAFIER
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 03:04:17 -0500
Received: from mail.davidb.org ([66.93.32.219]:34509 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbYAFIER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 03:04:17 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1JBQUR-00042p-UP; Sun, 06 Jan 2008 00:04:15 -0800
Mail-Followup-To: Jon Hancock <redstarling@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69714>

On Sun, Jan 06, 2008 at 03:55:22PM +0800, Jon Hancock wrote:

> So, do I need to use git's mv and rm commands?  Can't I just rename,  
> add, and remove files using any means I like and then just ensure my  
> "index" is staged properly when I do a commit?

Yes.  You can use either git-rm or 'git-commit -a' to remove files.  To
rename, you can use git-mv, or you can rename the file yourself, git-add
the new name, and git-rm the old name.

There is no metadata stored with git-mv and git-rm, they just update the
tree and the index.

Dave
