From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: strange behavior when pulling updates / get uptodate with git.git
Date: Sat, 08 Apr 2006 21:57:00 +0200
Message-ID: <4438158C.1080208@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Apr 08 22:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSJbQ-00054Z-Gq
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 22:00:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWDHUAE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Apr 2006 16:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWDHUAE
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Apr 2006 16:00:04 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:5131 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751382AbWDHUAC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Apr 2006 16:00:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 7C7B23E9C
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 22:00:00 +0200 (CEST)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11609-03 for <git@vger.kernel.org>;
	Sat, 8 Apr 2006 21:59:56 +0200 (CEST)
Received: from [192.168.100.26] (hermes.lan.home.vilz.de [192.168.100.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 6F3A83E71
	for <git@vger.kernel.org>; Sat,  8 Apr 2006 21:59:55 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18523>

Hello guys,

I experience a loss of tags- and branch-updates, when I try to update my
repository.

I normaly do following

git checkout master
git pull origin

my .git/remotes/origin-file looks like this:

URL: git://git.kernel.org/pub/scm/git/git.git
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/todo:refs/heads/todo
Pull: refs/heads/maint:refs/heads/maint
Pull: refs/heads/pu:refs/heads/pu
Pull: refs/heads/man:refs/heads/man
Pull: refs/heads/next:refs/heads/next
Pull: refs/heads/html:refs/heads/html

so i suppose, if i try to pull origin, and i am in master, i should be
able to pull these remote heads each in the correct local head...

But I obviously don't.

after deleting the actual git-repository directory and recloning with

git clone <url>

I have obviously more tags than git was trying to merge before at git
pull origin..

I use git version 1.3.0.rc1.g4c0f (located in the next-tree).

Any hints how this could be better on my system?

Sincerly
Nicolas
