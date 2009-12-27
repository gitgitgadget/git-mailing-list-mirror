From: <mysql.jorge@decimal.pt>
Subject: Re: Newbie to git
Date: Sun, 27 Dec 2009 17:45:29 +0000
Message-ID: <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 27 18:50:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOxGJ-0000wN-Qg
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 18:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbZL0Rp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 12:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbZL0RpZ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 12:45:25 -0500
Received: from mailrly03.isp.novis.pt ([195.23.133.213]:51946 "EHLO
	mailrly03.isp.novis.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbZL0RpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 12:45:25 -0500
Received: (qmail 7315 invoked from network); 27 Dec 2009 17:45:20 -0000
Received: from unknown (HELO mailfrt06.isp.novis.pt) ([195.23.133.198])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailrly03.isp.novis.pt with compressed SMTP; 27 Dec 2009 17:45:20 -0000
Received: (qmail 28943 invoked from network); 27 Dec 2009 17:45:20 -0000
Received: from unknown (HELO web.decimal.pt) (Sent_by_authenticated_user_nm087018@[195.23.114.74])
          (envelope-sender <mysql.jorge@decimal.pt>)
          by mailfrt06.isp.novis.pt with SMTP; 27 Dec 2009 17:45:20 -0000
Received: from webmail.decimal.pt (localhost [127.0.0.1])
	by web.decimal.pt (Postfix) with ESMTP id 4DA3EEB68
	for <git@vger.kernel.org>; Sun, 27 Dec 2009 17:45:29 +0000 (WET)
In-Reply-To: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
X-Sender: mysql.jorge@decimal.pt
User-Agent: RoundCube Webmail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135708>

> I'm a using of git for several time, but now I have the need to a git
> server.
> My question, where can get a howto for reallyyyy newbies on git server?

One question:

I've created a project on the server with:

mkdir project.git
cd project.git
git init

-and now locally, created a directory, and cloned this, it said that i was
cloning an empty repo, fine about that.
-now i added something locally, i get: (locally this is on a windows
machine with tortoiso git)

--
git.exe push  --tags  "origin" master:git://192.168.1.206/projects.git

error: src refspec master:git does not match any.
error: failed to push some refs to 'git://192.168.1.206/projects.git'
--

I've read somewhere that i have to init both repos, remote and local to
the same branch, is it correct?

My idea is:

- clone remote repo
- add projects locally and commit them to remote

how can this be done easylly?
