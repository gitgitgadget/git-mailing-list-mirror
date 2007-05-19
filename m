From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Git branching & pulling
Date: Sat, 19 May 2007 01:49:36 -0400
Message-ID: <20070519054936.GC2679@fieldses.org>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sat May 19 07:49:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHp0-0000a8-GQ
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbXESFti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbXESFti
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:49:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43542 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbXESFth (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 01:49:37 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HpHou-0007Kj-8j; Sat, 19 May 2007 01:49:36 -0400
Content-Disposition: inline
In-Reply-To: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47719>

On Fri, May 18, 2007 at 10:40:17PM -0700, Wink Saville wrote:
> Hello,
> 
> I'm having trouble understanding branching and pull.
> 
> Using git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> I can create a branch off the master and do a pull:
> 
> wink@ic2d1:~/linux/linux-2.6$ git-checkout master
> Switched to branch "master"
> wink@ic2d1:~/linux/linux-2.6$ git-checkout -b test
> Switched to a new branch "test"
> wink@ic2d1:~/linux/linux-2.6$ git-pull
> Already up-to-date.
> 
> 
> 
> But from some reason using
> git://git.kernel.org/pub/scm/linux/kernel/git/avi/kvm.git
> the following happens
> 
> wink@ic2d1:~/linux/kvm-linux-2.6$ git-checkout master
> Already on branch "master"
> wink@ic2d1:~/linux/kvm-linux-2.6$ git-checkout -b test
> Switched to a new branch "test"
> wink@ic2d1:~/linux/kvm-linux-2.6$ git-pull
> Warning: No merge candidate found because value of config option
>         "branch.test.merge" does not match any remote branch fetched.
> No changes.

The differences you describe are almost certainly due to differences in
the git version, not the cloned repository.  Are you sure git wasn't
ugpraded between the two tests?

--b.
