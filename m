From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: defined behaviour for multiple urls for a remote
Date: Fri, 14 Oct 2011 09:36:10 +0000 (UTC)
Message-ID: <loom.20111014T113208-660@post.gmane.org>
References: <CAMK1S_jZJuqC6_-eVT7LJFh+DEphbsypS6f4nRb6Qc4-xBa_wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 14 11:40:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REeFU-0001o8-09
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 11:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab1JNJkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 05:40:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:36867 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab1JNJkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 05:40:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1REeFL-0001le-MM
	for git@vger.kernel.org; Fri, 14 Oct 2011 11:40:07 +0200
Received: from 217.148.215.10 ([217.148.215.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 11:40:07 +0200
Received: from Kirill.Likhodedov by 217.148.215.10 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 11:40:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.148.215.10 (Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; ru) Presto/2.9.168 Version/11.51)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183561>

Sitaram Chamarty <sitaramc <at> gmail.com> writes:

> What's the defined behaviour if I do this:
> 
> [remote "both"]
> 	url = https://code.google.com/p/gitolite/
>         url = git <at> github.com:sitaramc/gitolite.git
> 
> I know what I'm seeing (a fetch only goes to the first URL, and does a
> HEAD->FETCH_HEAD because I didn't provide a refspec line, while a push
> seems to push all to both), but I was curious what the official
> position is, because I couldn't find it in the docs.

Please see the message from Linus about that: http://marc.info/?l=git&m=116231242118202&w=2

You also may check how Git understands your remotes by running
  git remote -v
It will show, where it is going to fetch from and push to.

I agree though, that documentation should be updated.
