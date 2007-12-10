From: Wink Saville <wink@saville.com>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 09 Dec 2007 18:29:10 -0800
Message-ID: <475CA476.6070507@saville.com>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home> <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org> <475C7DD5.9040209@saville.com> <Pine.LNX.4.64.0712091942520.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 10 03:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1YOl-0007PY-NK
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 03:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbXLJC3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 21:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXLJC3O
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 21:29:14 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:21485 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXLJC3N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 21:29:13 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1446994rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 18:29:13 -0800 (PST)
Received: by 10.140.179.18 with SMTP id b18mr3958670rvf.1197253751881;
        Sun, 09 Dec 2007 18:29:11 -0800 (PST)
Received: from ?192.168.0.133? ( [70.91.206.233])
        by mx.google.com with ESMTPS id b2sm4728771rvf.2007.12.09.18.29.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 18:29:11 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0712091942520.5349@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67669>

Daniel Barkalow wrote:
> On Sun, 9 Dec 2007, Wink Saville wrote:
>   
> <snip>
>   

I got submodule working, buy following the tutorial here:
http://git.or.cz/gitwiki/GitSubmoduleTutorial#preview.

As well as looking at:
http://jonathan.tron.name/articles/2007/09/15/git-1-5-3-submodule
http://en.wikibooks.org/wiki/Source_Control_Management_With_Git/Submodules_and_Superprojects#endnote_lie_parent
http://kerneltrap.org/mailarchive/git/2007/10/19/348810
http://kerneltrap.org/mailarchive/git/2007/10/19/348829

I'd say the current documentation in git needs to improve at least
for neophytes. The first step would be to include the GitSubmoduleTutorial.
Also, I think the second paragraph of the tutorial is very important and
something like it should probably be the first paragraph of the 
git-submodule
man page:

"Submodules maintain their own identity; the submodule support just 
stores the submodule repository location and commit ID, so other 
developers who clone the superproject can easily clone all the 
submodules at the same revision."

My interpretation of the paragraph and how submodules might be used
is that the "supermodule" provides tags for a set of repositories.
I see that as important, especially for large projects which could use
multiple repositories for sub-projects and then use a "supermodule"
for test and release management.

That isn't what I really wanted to do. As a one man band I was looking
to actually "combine" several repositories into one logical repository
to simplify commits, pushes, pulls to my own backup repositories.
I now see that that wasn't the purpose of submodule.

Anyway, that is the perspective of this neophyte and I learned something
new which is a primary goal of mine.

Finally, I'm back to my original question how to combine repositories? As
I said in my response to Alex, the multiple branches I got working but that
isn't what I want.

What I think I now want is to create a new repository which contains my
other repositories as sub-directories (with their histories) after combining
them I would delete the old repositories. I expect the resulting history
to be sequential, with the sequence defined by the order I combine them,
but maybe there is another choice?


Cheers,

Wink Saville
