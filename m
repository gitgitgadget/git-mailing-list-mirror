From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git status "short circuit"?
Date: Fri, 13 Feb 2009 09:36:15 -0800
Message-ID: <20090213173615.GA30949@spearce.org>
References: <BF509531-D8A4-4F5F-894F-735252AA4C26@bunster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jordi Bunster <jordi@bunster.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 18:38:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1yy-0005QM-Or
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbZBMRgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbZBMRgR
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:36:17 -0500
Received: from george.spearce.org ([209.20.77.23]:39377 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbZBMRgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:36:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C174338210; Fri, 13 Feb 2009 17:36:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BF509531-D8A4-4F5F-894F-735252AA4C26@bunster.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109765>

Jordi Bunster <jordi@bunster.org> wrote:
> I have a prompt snippet that shows me if there's something staged/ 
> changed/untracked (as different characters).
>
> It parses the output of git status. Since I don't really need to know  
> *all* that is staged/dirty/untracked, I was wondering if there's  
> something faster I could use. Something that stops at the first  
> occurrence of each category, perhaps.
>
> Any ideas?

Latest version of the bash completion package has a dirty prompt
setting you can enable.  Grab it out of the git repository and try
it out.

-- 
Shawn.
