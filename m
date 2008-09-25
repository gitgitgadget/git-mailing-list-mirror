From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 15:33:21 +0200
Message-ID: <20080925133320.GK10360@machine.or.cz>
References: <200809251230.11342.jnareb@gmail.com> <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 15:35:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kir0M-00012U-9n
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 15:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315AbYIYNdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 09:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbYIYNdY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 09:33:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58552 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497AbYIYNdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 09:33:23 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 616923939B2D; Thu, 25 Sep 2008 15:33:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96763>

On Thu, Sep 25, 2008 at 03:19:09PM +0200, Wincent Colaiuta wrote:
> One which I'm looking at doing is supporting reading the "README.html" from 
> the tree indicated by the current HEAD instead of reading it from a file in 
> the .git directory.
>
> This should make tracking and updating such READMEs a little easier as all 
> that'll be required is a "push" to advance the HEAD and the new README goes 
> live.
>
> Obviously, will have to make this optional and configurable. I'm thinking 
> of providing a means of specifying the filename to look for (no filename, 
> the default, means don't look), and also a setting to indicate the content 
> type of the file (either plain text, which would be wrapped in a 
> <pre></pre> block with HTML entities used where appropriate, or HTML which 
> would be included verbatim).

In my queue and something I will hopefully get to submit tomorrow or at
the beginning of next week is actually support for full-blown templating
of gitweb pages (customization of the summary page, even adding extra
project actions) based on gitconfig-style specification within the
project HEAD. In its simplest variant, this could be used for including
a README from the HEAD tree as well, I think. But it's in the same class
as the git-gui support for the 'publish' dialog, something potentially
useful for others, but not *universally* useful and in this case,
unfortunately somewhat invasive.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
