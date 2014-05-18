From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: commit all the untracked files prior adding them to stage using "git add"
Date: Sun, 18 May 2014 04:17:10 +0000 (UTC)
Message-ID: <loom.20140518T060536-509@post.gmane.org>
References: <1878681.dTqGrk8buZ@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 06:17:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlsXP-0006X3-UB
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 06:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaERERY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 00:17:24 -0400
Received: from plane.gmane.org ([80.91.229.3]:33591 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbaERERX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 00:17:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WlsXJ-0006Bf-A1
	for git@vger.kernel.org; Sun, 18 May 2014 06:17:21 +0200
Received: from 117.254.221.43 ([117.254.221.43])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 May 2014 06:17:21 +0200
Received: from tanayabh by 117.254.221.43 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 18 May 2014 06:17:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 117.254.221.43 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249499>

Arup Rakshit <aruprakshit <at> rocketmail.com> writes:


> Now I am looking for a way to add those in stage and commit also in a single 
> line. So I did below :-
> 
> arup <at> linux-wzza:~/Rails/test_app> git commit -m "chapter 19 of Agile Web 
> Development with Rails" -a
> # On branch master
> #
> # Initial commit
> #
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       .gitignore
> #       Gemfile
> #       Gemfile.lock
> #       README.rdoc
> #       Rakefile
> #       app/
> #       bin/
> #       config.ru
> #       config/
> #       db/
> #       lib/
> #       log/
> #       public/
> #       test/
> #       vendor/
> nothing added to commit but untracked files present (use "git add" to track)
> 
> It did not work. Then using `git commit -h` told me, *-a* will work, for 
> *tracked files*. Is there any way to add untracked files in stage, and
commit in 
> a single line ? 
> 

Hi,

git commit -a works for only modified or deleted files, but new files that
you haven't told git about are not affected. What you want is,

$ git add -A && git commit -m "your message"

where git add -A adds all new files to the staging area to track.
A piece of advice, you seem to be new to git, try try.github.com/ for
an interactive tutorial.

Cheers,
Tanay Abhra.
