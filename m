From: Johan Herland <johan@herland.net>
Subject: Listing commits that are _exclusively_ available on a given branch
Date: Fri, 23 Mar 2012 15:36:33 +0100
Message-ID: <CALKQrge-=XExhwxuC14uynpuuO3W+f4YO4=X7kFUx33F3HtnyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 15:36:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB5bh-0003Ru-6T
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 15:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab2CWOgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 10:36:39 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:51944 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753340Ab2CWOgi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 10:36:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1SB5bY-000FSI-Mf
	for git@vger.kernel.org; Fri, 23 Mar 2012 15:36:36 +0100
Received: by gghe5 with SMTP id e5so2783065ggh.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 07:36:33 -0700 (PDT)
Received: by 10.50.214.36 with SMTP id nx4mr2314048igc.2.1332513393143; Fri,
 23 Mar 2012 07:36:33 -0700 (PDT)
Received: by 10.43.52.6 with HTTP; Fri, 23 Mar 2012 07:36:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193761>

Hi,

I'm trying to figure out how to list commits on a given branch that
are not available on any other branch, i.e. the commits that are
exclusive to my branch.

So far I only have this somewhat brute-force alternative:

  git rev-list refs/heads/mybranch --not $(git show-ref --heads | grep
-v refs/heads/mybranch)

Is it possible to phrase this query in a simpler manner? Preferably by
not having to list all refs and then run grep on it...

(I've already tried playing around with "git show-branch" and its
options, but to no avail.)


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
