From: "Govind Salinas" <blix@sophiasuchtig.com>
Subject: Re: [PYRITE] Status update and call for information.
Date: Fri, 23 May 2008 07:36:25 -0500
Message-ID: <5d46db230805230536r18ac606j93a210d0b2864719@mail.gmail.com>
References: <5d46db230805222318j25657c10t2955fbdf1aa5c003@mail.gmail.com>
	 <20080523064541.GA31315@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 23 14:37:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzWWY-000306-Kt
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 14:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbYEWMgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 May 2008 08:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbYEWMgj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 08:36:39 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:45249 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYEWMgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 08:36:38 -0400
Received: by yw-out-2324.google.com with SMTP id 9so365301ywe.1
        for <git@vger.kernel.org>; Fri, 23 May 2008 05:36:25 -0700 (PDT)
Received: by 10.151.84.12 with SMTP id m12mr1684747ybl.2.1211546185499;
        Fri, 23 May 2008 05:36:25 -0700 (PDT)
Received: by 10.150.181.17 with HTTP; Fri, 23 May 2008 05:36:25 -0700 (PDT)
In-Reply-To: <20080523064541.GA31315@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Google-Sender-Auth: d2bd457a0a47ed58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82698>

On Fri, May 23, 2008 at 1:45 AM, Karl Hasselstr=F6m <kha@treskal.com> w=
rote:
> On 2008-05-23 01:18:42 -0500, Govind Salinas wrote:
>
>> Some functionality isn't for everyone. I have just put into my next
>> branch an addon that gives git revision numbers. Why, because other
>> SCMs that are supposed to be more user friendly have them. Because
>> people have been asking for them. Because they are easier to
>> remember. The concept is this. A given commit encapsulates its
>> parantage, so if I have commit XYZ, I can always say that XYZ is
>> so-many commits away from the first commit. The question is how you
>> determine that number and that you always do it the same. If we just
>> define the revision number to be the place of the commit in the list
>> of "git rev-list --topo-order --reverse SHA1" then we can get a
>> consistant number semi-meaningful number, which is all people really
>> want.
>
> You do realize that no matter how you define your sequential numbers,
> they can't be both globally consistent and unique? (That is, either
> different repositories will assign different numbers to the same
> commit, or the same number could be assigned to more than one commit.=
)
>
> For a simple reason: A numbering that's both globally consistent and
> unique can only look at a commit's ancestry (and the commit itself)
> when assigning a number to a commit. But in order to get _sequential_
> numbers, you need to look at the commit's siblings as well, and the
> set of siblings can be different from repository to repository.
>
> This has already been discussed to death elsewhere in this list at
> least once (see the list archives), but your next paragraph suggests
> you think it's only a performance issue, which is why I brought it up=
:
>

Of course, no one makes the claim that rev numbers are unique or
even that a commit has the same revision number between branches
in the same repository.   Hg states that flat out and I believe bzr say=
s
the same, although I am pretty sure they determine their numbers some
other way.  I make no such claim.  What I do claim is that for a given
branch, a commit should always have the same revision number.  Sure,
If you merge a commit from another branch, it's revnum might change,
but that is ok.  As long as, assuming you have not re-written master,
10:master will always point to the same commit I think I am providing
something worth while.  Also, AFAIK the order of parentage is part of
the hash that makes a commit ID, so if my master is a clone of your
master, it should share revision numbers.

Thanks,
Govind.
