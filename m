From: Zack Rusin <zack@kde.org>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 08:55:39 -0400
Message-ID: <200708290855.39505.zack@kde.org>
References: <200708290348.02853.zack@kde.org> <7vfy22squc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 14:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQN2w-0000va-Av
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 14:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbXH2Mwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 08:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758831AbXH2Mwi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 08:52:38 -0400
Received: from esparsett.troll.no ([62.70.27.18]:59980 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759473AbXH2Mwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 08:52:31 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 21EAD7427C; Wed, 29 Aug 2007 14:52:30 +0200 (CEST)
Received: from pixel.local (unknown [10.3.5.243])
	by esparsett.troll.no (Postfix) with ESMTP
	id 0EDC27426D; Wed, 29 Aug 2007 14:52:30 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vfy22squc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56941>


Thanks a lot for the comments.

On Wednesday 29 August 2007 04:11:07 am Junio C Hamano wrote:
> - Recommended form for diff between 1 and 2 is "git diff $id1
>   $id2", not dotted form "$id1..$id2"

Fixed. 

> + "git log -p $file" gives a false impression that it is about a
>   single file.  Better written as "git log -p $file $dir/ec/tory/"
>   to suggest both usage.

Fixed.


> - Although they do the same thing ("annotate" is there only for
>   backward compatibility) "git blame" is recommended over "git
>   annotate", if only because that's the command name more often
>   talked about in the community.  If you are going to list only
>   one, blame is the name to keep.

Fixed.

> + To start from a particular revision, use "git blame $version $file".

I'm not quite sure where to squeeze it though :)

> - "git reset --hard HEAD"; you do not have to write HEAD there.

The reason I left HEAD in there was because I wanted to let people know they 
can reset to any id, but come to think of it, I failed at that (and only at 
that, everything else in my life is a success... cough, cough) so I removed 
HEAD.

> - "Revert" has a specific meaning to git but people from
>   different background interpret the word differently.  Both
>   "git revert HEAD" and "git revert $id" are about creating a
>   new commit to reverse the effect of the named commit.

I added a note to let people know it creates a new commit.

> * "git pull $branch1 $branch2" is wrong.  If you are merging
>   branch1 into branch2, you need to be on branch2 (i.e. have
>   done "git checkout branch2") and then say "git merge branch1".

Ah, thanks! Fixed. 

> + "git commit" is not about publishing at all.  A major point
>   about distributed SCMs is that unlike centralized systems, the
>   act of committing is separate from the act of publishing.
>   IOW, you can make commits without having to worry about
>   publishing that to the public, and that allows you to more
>   freely experiment.

The reason I put it in publishing was because if I added another section I'd 
have to resize the font to about 2pt to fit it all which in turn would imply 
that everyone trying to read the sheet would be crosseyed (and given my 
strong support for beauty in the community, I just couldn't do that). 

> + A new section "Making Progress" and include commit, merge and
>   rebase there, perhaps?

Yeah, lack of rebase in the sheet bothers me a bit, since it's quite 
important. Maybe I could remove the "useful commands" section and put 
something in there...

Also I think that it's very important to specify what a "cheat sheet" is for. 
It's not a replacement for a tutorial. I don't think it's reasonable to 
expect anyone to print this sheet without reading any tutorials/documentation 
and be riding the Git wave. It nicely complements the tutorial, especially in 
the beginning phases of learning something new. 
So what I wanted to have on this sheet is list of thingies (technical term) 
people will use on a daily basis. In cases they need a specific permutation 
of them they can always look at the documentation.
So in my opinion (and that's a wicked good opinion) the scenario we should be 
aiming at with a cheat sheet is:
1) a person hears about Git in an online dating forum
2) a person takes a deep breath and changes pants
3) a person reads the tutorial
4) a person prints a cheat sheet and begins using Git

While I think 1 and 2 will change and are fairly optional, I think 3 
absolutely has to come before 4. 
Basically I wanted this to be a road-sign that would point people in the right 
direction (and I know that people from Brooklyn, are all confused right now 
because every roadsign they've ever seen points the wrong direction, but they 
can trust me, outside Brooklyn roadsigns actually point in the right 
direction).

I'm not sure if I should put the sheet in some more visible place, so for now 
the updated svg and png's are at:
http://ktown.kde.org/~zrusin/git/git-cheat-sheet.svg
http://ktown.kde.org/~zrusin/git/git-cheat-sheet-medium.png
http://ktown.kde.org/~zrusin/git/git-cheat-sheet-large.png

z
