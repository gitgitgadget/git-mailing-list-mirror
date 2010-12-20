From: "George Spelvin" <linux@horizon.com>
Subject: Re: Basic Git Questions
Date: 20 Dec 2010 14:21:52 -0500
Message-ID: <20101220192152.4509.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: paragkalra@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 20 20:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUlPS-0003ki-Mr
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 20:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765Ab0LTT2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 14:28:34 -0500
Received: from science.horizon.com ([71.41.210.146]:41761 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932730Ab0LTT2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 14:28:33 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Dec 2010 14:28:33 EST
Received: (qmail 4510 invoked by uid 1000); 20 Dec 2010 14:21:52 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164007>

> 1. I generally add the files in my working directory using "git add
> .". But sometimes you want to add all the files except 1 or 2 file. Is
> there a shortcut way we can tell git to add all the files but exclude
> a particular file.

Others have pointed out the general techniques, but a few additional
things that may be useful in some situations:

1) .gitignore.  If the files are such that you never want git to pay
   attention to them, you can add them to the .gitignore file.
2) "git add -u".  This adds only files that git is already tracking,
   and ignores truly new files.
3) "git add -i".  This lets you pick the files to be added from a list.
4) "git gui".  This lets you click on the files to be added.
   It's my preferred way to do a selective commit.
