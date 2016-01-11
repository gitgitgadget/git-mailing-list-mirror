From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Adding a commit to the front of my branch?
Date: Mon, 11 Jan 2016 15:11:25 +0100
Message-ID: <1mgv8hf.iib6fg1g9uszaM%lists@haller-berlin.de>
References: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
To: rcdailey.lists@gmail.com (Robert Dailey), git@vger.kernel.org (Git)
X-From: git-owner@vger.kernel.org Mon Jan 11 15:20:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIdKX-0000NQ-3b
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 15:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932829AbcAKOUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 09:20:10 -0500
Received: from server90.greatnet.de ([178.254.50.90]:39929 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267AbcAKOUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 09:20:09 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jan 2016 09:20:09 EST
Received: from [10.1.0.114] (nat1.ableton.net [217.110.199.117])
	by server90.greatnet.de (Postfix) with ESMTPA id B11002B414F;
	Mon, 11 Jan 2016 15:11:20 +0100 (CET)
In-Reply-To: <CAHd499B8gRMVWnUBZ0aO2RtokYqTm6fO7+7zfbsJNTnKw4MVsQ@mail.gmail.com>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.11.2 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283652>

Robert Dailey <rcdailey.lists@gmail.com> wrote:

> Normally to add commits on my branch, I perform an interactive rebase:
> 
> $ git rebase -i origin/master
> 
> I mark the commit I want to put the new commit on top of as 'edit'.
> However, if I want to add a commit to the front of my branch, I don't
> really have a commit to mark as "edit".

Instead of marking commits as edit, I usually add "x false" at the place
where I want to add a commit. With this I find it easier to see where
the new commit goes, and it also works before the first commit.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
