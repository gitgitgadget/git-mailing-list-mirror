From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 23:11:32 +1300
Message-ID: <46a038f90610240311n29d0561ek7dc52dc3d34c2f76@mail.gmail.com>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	 <87zmbozau2.wl%cworth@cworth.org>
	 <20061022185350.GW75501@over-yonder.net>
	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
	 <46a038f90610231739x5beffc90u33c6a81f461974ec@mail.gmail.com>
	 <845b6e870610240052l70ad72f4ma30065f151828dfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Jakub Narebski" <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 12:11:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcJG2-0001xm-0F
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 12:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWJXKLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 06:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWJXKLi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 06:11:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4304 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965126AbWJXKLh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 06:11:37 -0400
Received: by nf-out-0910.google.com with SMTP id c2so165971nfe
        for <git@vger.kernel.org>; Tue, 24 Oct 2006 03:11:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IJKZf0Fx/LlUHxU2ZXpFfH7SXfaIOV2aYZqHsm5XWK/PLRh2hHcE7blEdwWBZw9zrKRPvJ0wmylDKHk2eFD0UuwVYhzbWgDOAwikg3m7K8KzBHp52T4Sc4SJ94RowWzRg8azp+f8t8TszxxX5TILTdDjRU/RHRTuUcbzDlkjo1g=
Received: by 10.48.48.13 with SMTP id v13mr890873nfv;
        Tue, 24 Oct 2006 03:11:32 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Tue, 24 Oct 2006 03:11:32 -0700 (PDT)
To: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
In-Reply-To: <845b6e870610240052l70ad72f4ma30065f151828dfd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29959>

On 10/24/06, Erik B=E5gfors <zindar@gmail.com> wrote:
> It's Erik :)

Sorry Erik!

> Let's make one thing clear.  Revnos are NOT stored with the revision,
> they are not "names" of the revision.  They are basically just
> shortcuts to specific revisions, that only makes sence in the context
> of a branch.

My bad. The revnos examples discussed looked quite Arch-like. As Arch
took them seriously, I thought bzr did too.

Probably quite a few people here thought as much, and got hot under
the t-shirt about it ;-)

Now, the thing about they shorthand is that we have quite a few means
of using shorthand in GIT that don't rely on revnos. We have the whole
^branchname stuff. And when you are looking at gitk it's pretty
obvious which are your recent "local" commits.


=2E..


> 2. treating "leftmost" parrent special is bad/good

> 2. This is something I do care about.  For me, this is the only
> logical way of doing it. It might be because I am used to it now, but
> when I started to look at bzr/hg/git/darcs/etc, I just got a so much
> more clear view of the history when running a standard log command,
> that it was one of the first things that attracted me to bzr. This is
> just a user talking.
> There might be technical reasons why it's better to not do it, but fo=
r
> me it works the way I expect, therefore I'm happy

Can you give us a quick example of why you got such a clearer picture?

> 3. plugins are useless/useful

Hmmmm. It's more of a unix/C/pipes tradition vs dynamically typed &
compiled scripting language tradition.

> 4. And now, storing branch information should be done manually (if
> wanted) and not automatically.

> 4. No comment.

Probably not. But if someone is using branchnames to identify "lines
of work" and hoping that metadata will remain attached there, it's
probably a bad long-term approach.

But following what you said earlier about that info being transient
and "local", then I was 200% wrong, and thinking of Arch/Bazaar usage
patterns.

cheers,


martin
