From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:03:43 -0600
Message-ID: <17855.38543.761930.929267@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<epo1tn$9sl$1@sea.gmane.org>
	<17855.35845.922009.364704@lisa.zopyra.com>
	<20070130182237.GC26415@spearce.org>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:06:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HByHM-0002Sp-6a
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbXA3TEX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbXA3TEX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:04:23 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60227 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbXA3TEW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:04:22 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UJ44u00312;
	Tue, 30 Jan 2007 13:04:04 -0600
In-Reply-To: <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38186>

On Tuesday, January 30, 2007 at 10:41:03 (-0800) Linus Torvalds writes:
>On Tue, 30 Jan 2007, Bill Lear wrote:
>...
>> This repository was created like this:
>> 
>> % mkdir /repos/git/project
>> % cd /repos/git/project
>> % git --bare init-db --shared
>>[% GIT_DIR=. git fetch git://source/public/project topic:topic]
>
>...but you don't _have_ any such branch. You only have a "topic" branch.

Hmm, so I did this:

% cd /repos/git/project
% GIT_DIR=. git branch
  topic

And then, tried it all again:

% cd ..
% rm -rf project
% mkdir project
% cd project
% git --bare clone --shared
% GIT_DIR=. git fetch git://source/public/project
warning: no common commits
remote: Generating pack...
remote: Done counting 1148 objects.
remote: Deltifying 1148 objects.
remote:  100% (1148/1148) done
Unpacking 1148 objects
remote: Total 1148, written 1148 (delta 632), reused 1020 (delta 534)
 100% (1148/1148) done
% GIT_DIR=. git branch
[eh?  No branches??]
% cat HEAD
ref: refs/heads/master

So, where are my branches?  And don't tell me I don't need no
steenking branches...


Bill
