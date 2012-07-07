From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Egit/Jgit support for relocated .git directories
Date: Sat, 07 Jul 2012 12:18:12 +0200
Message-ID: <4FF80CE4.60303@dewire.com>
References: <4FE97057.3040609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, jgit-dev@eclipse.org,
	egit-dev@eclipse.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:42:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnSTE-00045z-2u
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 12:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668Ab2GGKma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 06:42:30 -0400
Received: from mail.dewire.com ([83.140.172.130]:2165 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2GGKm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 06:42:29 -0400
X-Greylist: delayed 1452 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2012 06:42:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C4BA58FC8F;
	Sat,  7 Jul 2012 12:18:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qr5b-qhz41xF; Sat,  7 Jul 2012 12:18:13 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id 181258FC97;
	Sat,  7 Jul 2012 12:18:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120529 Thunderbird/13.0
In-Reply-To: <4FE97057.3040609@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201161>

Chris Packham skrev 2012-06-26 10.18:
> Hi,
>
> This is a bit of a secondhand bug report/query so sorry if the details
> are a bit sketchy.
>
> Since git 1.7.8:
>
> ``When populating a new submodule directory with "git submodule init",
> the $GIT_DIR metainformation directory for submodules is created inside
> $GIT_DIR/modules/<name>/ directory of the superproject and referenced
> via the gitfile mechanism. This is to make it possible to switch
> between commits in the superproject that has and does not have the
> submodule in the tree without re-cloning.''
>
> I've had several colleagues at work tell me that with the relocated
> $GIT_DIR the Egit integration with eclipse doesn't work. I can't really
> qualify "doesn't work" but from what I've been told importing the
> project works but blaming/annotating doesn't.
>
> I believe the gitfile mechanism isn't new but it possibly hasn't been
> used by many Egit/Jgit users. Can anyone confirm if it is supported by
> Egit/Jgit (and I'm barking up the wrong tree).

It is supported. There is however a commit as late as in May that relates
to gitfile, so you may need 2.0.

-- robin
