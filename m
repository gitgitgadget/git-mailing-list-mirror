From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Add path_info tests to
	t/t9500-gitweb-standalone-no-errors.sh
Date: Thu, 2 Oct 2008 17:07:25 +0200
Message-ID: <20081002150725.GP10544@machine.or.cz>
References: <20081002145010.19247.44420.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 17:11:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPnD-0000go-OS
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 17:08:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYJBPH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 11:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754302AbYJBPH1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 11:07:27 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44097 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbYJBPH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 11:07:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1571F3939B47; Thu,  2 Oct 2008 17:07:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081002145010.19247.44420.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97353>

On Thu, Oct 02, 2008 at 04:52:20PM +0200, Jakub Narebski wrote:
> Note that those tests only that there are no errors nor warnings
> from Perl; they do not check for example if gitweb doesn't use
> ARRAY(0x8e3cc20) instead of correct value in links, etc.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This is the test thans to which I have dicovered errors in git_tree()
> fixed in previous email. Nevertheless those two patches are unrelated,
> so they are not numbered.
> 
> Those tests check _current_ situation, without $action, not
> $hash_parent parameters possible in path_info.

I didn't test the patch but it all looks sensible.

Acked-by: Petr Baudis <pasky@suse.cz>
