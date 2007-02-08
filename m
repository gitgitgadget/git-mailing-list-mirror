From: Bill Lear <rael@zopyra.com>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 17:40:37 -0600
Message-ID: <17867.46325.433406.974582@lisa.zopyra.com>
References: <17866.27739.701406.722074@lisa.zopyra.com>
	<Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org>
	<17867.40122.51865.575762@lisa.zopyra.com>
	<Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org>
	<17867.45437.922483.805945@lisa.zopyra.com>
	<20070208233324.GA1556@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:40:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIsi-0007D4-8j
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965667AbXBHXkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbXBHXko
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:40:44 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61936 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965667AbXBHXko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:40:44 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l18NedL05917;
	Thu, 8 Feb 2007 17:40:39 -0600
In-Reply-To: <20070208233324.GA1556@spearce.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39128>

On Thursday, February 8, 2007 at 18:33:24 (-0500) Shawn O. Pearce writes:
>Bill Lear <rael@zopyra.com> wrote:
>> With regard to the new version and old repos, am I correct in assuming
>> that we can upgrade our old repo (a bare one) to the new git by first
>> installing the new git, and then doing this:
>> 
>> % cd /repos/git
>> % mv project project.old_git
>> % git --bare clone project.old_git project
>> 
>> or is there something else we must do?
>
>In the case of a bare repo, there isn't anything to do.

So, I assume I need to tell our developers that once we have installed
the new git, they will need to set aside their old repos and just
clone again from our company repo?


Bill
