From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to update? (git Changed but not updated)
Date: Sun, 22 Feb 2009 01:10:20 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngq19fs.vna.sitaramc@sitaramc.homelinux.net>
References: <49A070B5.90909@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 02:12:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb2sy-0006il-7Z
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 02:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbZBVBKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 20:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754869AbZBVBKc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 20:10:32 -0500
Received: from main.gmane.org ([80.91.229.2]:32818 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754862AbZBVBKb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 20:10:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lb2rV-0004ev-7h
	for git@vger.kernel.org; Sun, 22 Feb 2009 01:10:29 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 01:10:29 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 01:10:29 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110988>

On 2009-02-21, Reto S. News <retoh@dplanet.ch> wrote:
> Beginner question: "How to update the pushed changes on the master?"
>
> On Slave Host (a Developer that receives a working copy of a project):
>
> $ git clone git://master.example.net/test myrepo
> $ cd myrepo   # ... here I see all received files from the master
> $ Changing file "foo.txt"
> $ git add .   # ... for whatever reason this is necessary
> $ git commit -m 'I changed this file'
> $ git push
>
> On Master Host (master.example.net):
>
> # git status # Shows me correctly foo.txt has been changed by the"Slave"
> # git show   # Shows me even the made changes in a diff style!

I'll bet the changes shown are 'reversed'...

> Now I have to update the fresh content produced by the "Slave". As an
> ugly work-around, I'm currently cloning it again from localhost :-|
>
> Any suggestions are very appreciated.

Your master is a non-bare repo.  Try
http://git.or.cz/gitwiki/GitFaq#non-bare .

I also wrote up a much more detailed description of this at
http://sitaramc.github.com/concepts-and-tips/0-terminology.html#a5
-- I hope it helps you.

Regards,

Sitaram
