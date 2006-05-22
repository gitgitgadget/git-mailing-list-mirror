From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 2/3] tutorial: expanded discussion of commit history
Date: Mon, 22 May 2006 10:18:34 -0400
Message-ID: <20060522141834.GA17461@fieldses.org>
References: <1148255528.61d5d241.0@fieldses.org> <1148255528.61d5d241.1@fieldses.org> <e4rsef$v34$1@sea.gmane.org> <7vzmhacuso.fsf@assigned-by-dhcp.cox.net> <e4ruku$5uk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 16:18:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiBF0-0006gY-Cp
	for gcvg-git@gmane.org; Mon, 22 May 2006 16:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWEVOSf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 10:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWEVOSf
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 10:18:35 -0400
Received: from mail.fieldses.org ([66.93.2.214]:61380 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750846AbWEVOSf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 10:18:35 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.62)
	(envelope-from <bfields@fieldses.org>)
	id 1FiBEw-0004uG-4L; Mon, 22 May 2006 10:18:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e4ruku$5uk$1@sea.gmane.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20507>

On Mon, May 22, 2006 at 11:01:20AM +0200, Jakub Narebski wrote:
> Junio C Hamano wrote:
> > I do not think being able to do diff with arbitrary stage is
> > often used in practice.  By definition, you would want to do
> > diff with a stage during a conflicted merge, and most of the
> > time the default combined diff without any colon form should
> > give you the most useful results.  Also, ":<path>" to mean the
> > entry in the index is often equivalent to "git diff --cached".
> > 
> > IOW, these are obscure special purpose notation, and I do not
> > think tutorial is a good place to cover them.
> 
> Hmmm... perhaps in tutorial-3.txt, covering merges and how to resolve
> conflicted merge, cherry picking, reverting and rebasing.

Even then I had the impression that stages were pretty much invisible to
users.  So that should stay in core-tutorial.txt.  Which could use some
revision (Junio had some ideas) but I'm personally more interested in
end-user documentation than developer documentation for now.

So I'd imagined future tutorial parts cannibalizing everyday.txt and the
howto's.

--b.
