From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: as promised, docs: git for the confused
Date: Fri, 9 Dec 2005 00:47:56 +0000
Message-ID: <200512090047.56754.alan@chandlerfamily.org.uk>
References: <20051208063409.31967.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 09 01:49:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkWQR-0007fi-Vm
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 01:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVLIArt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 19:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932745AbVLIArt
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 19:47:49 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:9405
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932695AbVLIArt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 19:47:49 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EkWQO-0000bT-93
	for git@vger.kernel.org; Fri, 09 Dec 2005 00:47:48 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20051208063409.31967.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13407>

On Thursday 08 Dec 2005 06:34, linux@horizon.com wrote:
> As I mentioned with all my questions, I was writing up the answers
> I got.  Here's the current status.  If anyone would like to comment on
> its accuracy or usefulness, feedback is appreciated.
...
> * Background material.
>
> To start with, read "man git".  Or Documentation/git.txt in the git
> source tree, which is the same thing.  Particularly note the description
> of the index, which is where all the action in git happens.
>
> One thing that's confusing is why git allows you to have one version of
> a file in the current HEAD, a second version in the index, and possibly a
> third in the working directory.  Why doesn't the index just contain a copy
> of the current HEAD until you commit a new one?  The answer is merging,
> which does all its work in the index.  Neither the object database nor
> the working directory let you have multiple files with the same name.


If I was a complete newbie, I would be lost right here.  You start refering to 
the term HEAD without any introduction to what it means and (as far as I 
could see on a quick glance - which is what a newbie would do - man git 
doesn't start out here either).

If your audience really is a complete new commer, then as a minimum I think 
you need  to describe to concept of a "branch of development" with a series 
of snapshots of the state, the current of which is called HEAD.  You might 
even at this stage hint about there being several such branches.  The next 
bit, which goes on about the index is great - just put it into context with a 
simple explanation first.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
