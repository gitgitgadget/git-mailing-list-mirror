From: "Goo GGooo" <googgooo@gmail.com>
Subject: Re: 2.6.17-rc6-mm2
Date: Fri, 16 Jun 2006 13:14:09 +1200
Message-ID: <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 03:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr2uj-0007vw-Tl
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 03:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWFPBOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbWFPBOL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 21:14:11 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:10210 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750935AbWFPBOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 21:14:09 -0400
Received: by wr-out-0506.google.com with SMTP id 36so495154wra
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 18:14:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENv8IakfR6QzgBDzhGQbIUAQUFC5pK5W3NuZzobJvtM5NJ3sXdAKkA0K+HmCgxnHNasoIT0G1/PkU6MfJ2lo7MBxhgboDz9OtPoRzvJgdbbmLoh9wYwhfS66X8VxmFgWkSlj3ENqpw+L0oMFFg31edA/qhrzAOdl+4g5UhXS2Kw=
Received: by 10.64.184.8 with SMTP id h8mr2178025qbf;
        Thu, 15 Jun 2006 18:14:09 -0700 (PDT)
Received: by 10.65.110.6 with HTTP; Thu, 15 Jun 2006 18:14:09 -0700 (PDT)
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
In-Reply-To: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21924>

On 6/15/06, Goo GGooo <googgooo@gmail.com> wrote:
> Andrew Morton wrote:
>
> > - To fetch an -mm tree using git, use (for example)
> >
> >  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git
> > v2.6.16-rc2-mm1
>
> I'm not able to get -mm tree from GIT. In
> http://git.kernel.org/.../smurf/linux-trees.git/refs/tags/ I can see
> the most recent tags like v2.6.17-rc6-mm2 but cg-clone
> http://git.kernel.org/.../smurf/linux-trees.git gives me only
> 2.6.16-rc3 :(
>
> I tried "cg-fetch v2.6.17-rc6-mm2" which seemed to fetch some more
> tags, then played with git-checkout & friends but still can't get the
> most recent source tree.

All right, finally this worked out:
git pull rsync://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git \
      tag v2.6.17-rc6-mm2

Strange enough with http:// instead of rsync:// I got some message
about nonexistent tag.

Now when I try git pull with http:// again it says the tree is up to
date. However with git:// it started downloading more things and tags.

That's confusing - I believed all protocols should behave the same way...?

Goo
