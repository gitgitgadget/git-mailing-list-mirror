From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 16 Feb 2009 22:12:40 +0100
Message-ID: <op.upgqjej6a8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
 <op.uo9hiqqqa8ed4e@dellschleppa>
 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:14:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZAnD-0005Ak-DR
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbZBPVMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbZBPVMo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:12:44 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:29881 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754504AbZBPVMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1234818761; l=3245;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:Cc:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH:
	DomainKey-Signature;
	bh=Cb42xwnhTrDh9vDdzyCqgyp6ZwY/QpRssCrT1DSCCHA=;
	b=PZZkpGFovUQB7Uc6HWNwBwqfACi3I+wmnhntmI8JyXdeemBd7gAlcUESbloCs6ieein
	4nGki/kj8Mf5YpCsGfpIWiX55b1qRCiuMIIzPeblN5mbzXm6imc3/BjViR/Bog/VajAyM
	9Q78Q7CdPFvJhHDKXuk7080jfTsh9sEp/ko=
DomainKey-Signature: a=rsa-sha256; s=domk; d=tilo-schwarz.de; c=nofws; q=dns;
	h=X-RZG-AUTH:X-RZG-CLASS-ID:Date:To:Subject:From:Cc:Content-Type:
	MIME-Version:References:Content-Transfer-Encoding:In-Reply-To;
	b=lcRN/vAR2klNLcQpXVYuy1B1iXcN4P8Xpm2oseizoLr6HC3CIJEDyu25mRvRPwV39jA
	JdQMAqcmJKUgxz8AM2E4YR/hArU9Rg5krw55ygf3owG+r9ARVGBCRBkUIQaypEWhqYgix
	awWHx1qss9atKGoJwCJndVL8HcFfwMMtaZ4=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsdx1cxOGaI=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CD3A5.dip.t-dialin.net [84.156.211.165])
	by post.strato.de (fruni mo21) (RZmta 18.18)
	with ESMTP id 600be1l1GL1m31 ; Mon, 16 Feb 2009 22:12:40 +0100 (MET)
In-Reply-To: <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110242>

On Mon, 16 Feb 2009 00:47:05 +0100, Jonas Fonseca  
<jonas.fonseca@gmail.com> wrote:

> On Fri, Feb 13, 2009 at 00:14, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
>> Then I have another question: Did you ever thought of a branch view,  
>> where
>> you can see, create, delete and merge the different branches which are  
>> in a
>> git project.
>
> I have thought about it. The question is if a separate view is
> necessary or if the main view would do. For example, I sometimes use
> gitk when I need to rename branches or prepare for rebasing a
> patchset. One idea I would like to explore is to provide a compressed
> version of the main view, where "intermediate" commits are hidden,
> this way you could easily get a view of the relationship between
> branches.

I'm not sure if I understood it correctly. Do you mean, only commits are  
shown, which are heads of some branch? If so, what if more than one head  
points to the same commit?

The branch thing came into my mind, because it's the only thing which  
keeps me from using tig exclusively. I sometimes switch to git-gui to do  
the branch handling. Since I really like those "one key press is one  
command" kind of programs like tig (or mc, aptitude, mocp, ...), it would  
be really nice to have the branches in tig too. The nice thing of programs  
like tig is (matter of taste of course), that once you get used to the  
keys, you don't have to think about commands anymore, you just do them.

I think I would prefer a branch view, because then one could also have a  
branch-view keymap with specialized commands. One possibility would be  
(just as example):

The view shows something like this (here an example from the tig git  
repository)

   master
* my_feature_bar
X my_feature_foo
   origin/HEAD
   origin/master
   origin/release

The current branch is marked by '*'. Now let's assume, I am with my cursor  
on the line with the 'X', I could think of the keys

d (d)elete the X-marked branch, given is has already been merged into  
another branch
n create a (n)ew branch, based on the X-marked branch,
   ask for the new name and (maybe checkout the new branch)
c (c)heckout the branch
r (r)ename the branch
R (r)eset branch
...

I don't think it's necessary to reproduce all the nice options git-gui  
has, but if there would be a branch view with the most used 5 commands /  
work steps, it would cover 95% of the daily "branch work" which is needed.  
And it would be simply awesome, if we could do this without leaving tig,  
but instead use this very nice and fast "one key, one command" also for  
the branches. Of course the more complicated and special cases can be  
always handled by tig by pressing ':' and entering a git command.

> The simplest thing to make it easier to experiment with new features
> would probably be to introduce a new external command specifier:
> %(prompt:<msg>), possibly with some regex for validation. Then you
> could add in your ~/.tigrc:
>
> bind main A !git branch %(prompt:^wip/[a-z-]+$:Name) %(commit)

Ahh, ok, so tig would issue a prompt and ask me for the name?


Thanks for the great program!


BTW, is the git list the right list to discuss bugs / patches for tig?

Best regards,

     Tilo
