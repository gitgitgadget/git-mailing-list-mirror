From: Semen Vadishev <semen.vadishev@tmatesoft.com>
Subject: [ANN] SubGit Early Access Program Build #789
Date: Tue, 22 Nov 2011 20:15:59 +0100
Organization: TMate Software
Message-ID: <4ECBF4EF.7070705@tmatesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: jgit-dev <jgit-dev@eclipse.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 20:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSvpD-00071a-JO
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 20:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab1KVTQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 14:16:05 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55637 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1KVTQD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 14:16:03 -0500
Received: by bke11 with SMTP id 11so616937bke.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 11:16:02 -0800 (PST)
Received: by 10.204.9.209 with SMTP id m17mr20443984bkm.101.1321989362100;
        Tue, 22 Nov 2011 11:16:02 -0800 (PST)
Received: from vs.local ([109.80.120.205])
        by mx.google.com with ESMTPS id k26sm19603314fab.8.2011.11.22.11.16.00
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 11:16:00 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185806>

Hello All,

Let me introduce our new project: SubGit (http://subgit.com/).

SubGit is a tool for smooth migration from Subversion to Git. As well as
from Git to Subversion. Without git-svn insanity.

It works like this:

- Install SubGit into your repository on the server side

- Let initial translation complete (time depends on the size of repository)

- SubGit installs hooks into repository, so it translates every svn
revision and git commit

- Committers may now use either Git or Subversion (or both) with the
tools of their choice

SubGit uses JGit to work with the Git stuff. JGit handles heavy load
perfectly thus fitting our needs, and we appreciate efforts JGit
community put into this excellent library. Thank you, guys!

SubGit EAP builds are free to use, you may try these and let us know
what do you miss, so that we make sure that all the features you need
are included into the final version of SubGit.

SubGit works on Linux, Windows or OS X and requires Java 5 or newer.

Download new SubGit EAP build from http://subgit.com/ and follow us at
@subgit and +subgit.

-- 
Semen Vadishev,
TMate Software,
http://subgit.com/ - Two Way Ticket to The Dark Side
