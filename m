From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 22:30:58 +0100
Message-ID: <43F24C12.3090108@iaglans.de>
References: <43F20532.5000609@iaglans.de> <43F20D4B.3060606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 14 22:32:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F97mv-00059Y-IG
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 22:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWBNVcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWBNVcm
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 16:32:42 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:56837 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422798AbWBNVcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 16:32:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 93E783E92
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 22:32:40 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07318-09 for <git@vger.kernel.org>;
	Tue, 14 Feb 2006 22:32:39 +0100 (CET)
Received: from [192.168.100.26] (unknown [10.0.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 67A0D3E6B
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 22:32:38 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
In-Reply-To: <43F20D4B.3060606@op5.se>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16179>

Andreas Ericsson wrote:
> 
> git will recognize the merge-base as being the current HEAD and simply
> sets HEAD to point to that of topic-branch. This is why it's called a
> fast-forward, since no heavy computing needs to be done to combine the
> two development tracks.

well finaly, if nothing happened in one of the lines, then the two lines
become the same, when merging back into one line. and the two lines
overlay each other. That is what i saw during playing with git-merge,
git-pull and git-reset.. ok.

> 
>> do you have to make a new private branch out of the tag 1.1.6?
>>
> 
> No, you don't, but you can if you wish. It's nifty if you want to fork
> the development from a particular branch. In your case, if you really,
> really *want* the arrows pointing to one line, you can do
> 
> $ git branch topic-branch HEAD^
> # work, work, work
> $ git checkout master
> $ git pull . topic-branch
> 
> That would create one pretty arrow. When multiple tracks of development
> (rather than just two) are combined into one it's called an octopus
> merge. Unless you really know what you're doing, you should try to avoid
> those for small projects, and doing it just for the pretty arrows is....
> well, let's call it "interesting from the behaviour science scholars
> point of view".

its just the thought "cool, it looks like there at the git repo"... just
to realize "ok, that happens, when i merge two trees.

>> i used svn and there i could go back some revisions. I haven't found
>> such a feature in git, yet... but i think i am blind all the time.
>>
> 
> Most likely. I believe at least the reset command is mentioned in the
> tutorial. I trust you've read it before asking, so something is amiss
> either with your eyesight or the tutorial.

well the namespace of the references confused me, before i realized,
that HEAD finally points to an sha1sum (which symbolizes a certain commit)

mh.. I use pull if i want to get an external development tree, right? I
still search for a possibility to replace the svn:externals, which were
quite handy some times.

lets imagine, i want to reuse work i did in another repository, then I
can easily pull from that repository, which my work i want to reuse is
stored at... i see... i just will have to pull frequently.... and hope
there is no conflict between some files.


once more... thank you all and good work.

Nicolas
