From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 10:41:07 +0200
Message-ID: <cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <faurcl$p0o$1@sea.gmane.org>
	 <46D38B3D.6070809@vilain.net> <85absc6we7.fsf@lola.goethe.zz>
	 <cb7bb73a0708280209r36136128x7bce310bf4fd4f66@mail.gmail.com>
	 <86sl64nhc1.fsf@lola.quinscape.zz>
	 <cb7bb73a0708280237v6f248517h183174bc41296df3@mail.gmail.com>
	 <46D4A664.4070007@vilain.net>
	 <cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	 <46D4ECE2.9020806@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:41:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQJ7E-0007ga-0m
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 10:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799AbXH2IlL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 04:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbXH2IlK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 04:41:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:19507 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804AbXH2IlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 04:41:08 -0400
Received: by wa-out-1112.google.com with SMTP id v27so112270wah
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 01:41:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h6N+HNi7PFgh61PWztCbuSZOyju6jiTZ6S5peuX6hexbBup9CXnPLk5vEt7kb3qNtgecfXyVa2LcYA+02JoBsTqA7fe+x4vKyZ2FQBjH6abJpT+q45rtz7nxRb/VrCunAKs/P/+XJqlIe9139NKY/sX/kcRH6q9hvuQdnUJ9GY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UOuWgKAZDsgz9vw6O8j96LuS+Jy8l6sSqhfB6XTsNYOfYzswNQ7xK6E/nOp9670EW8L1mrjBml79SwNt7Uag0cD/jamA2m7Ygsyy4IDp34xhUYP1RHzwToQRF6sZaesW/lEpyQ0VTfaqUi0BsTX+lxKU4DsWOT/Vr7tttqLJ76Y=
Received: by 10.114.75.1 with SMTP id x1mr183800waa.1188376867161;
        Wed, 29 Aug 2007 01:41:07 -0700 (PDT)
Received: by 10.114.58.14 with HTTP; Wed, 29 Aug 2007 01:41:07 -0700 (PDT)
In-Reply-To: <46D4ECE2.9020806@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56911>

On 8/29/07, Sam Vilain <sam@vilain.net> wrote:
> Giuseppe Bilotta wrote:

> > I gather from the man page that doing this is highly frowned upon, and
> > requires manual intervention from all the poor souls that pulled in
> > the mean time.
>
> Right, but I think the bad practice should be propagated anyway.  It
> will affect virtually no-one, and serves to make it the case that even
> if such a thing happened, then just fetching the tag gives the expected
> behaviour.
>
> However I'd be prepared to accept that perhaps new tags should be made,
> eg "tags/svntagname.r1234", to reflect the fact there are there multiple
> tags with the same name but different contents.

Urgh. I think I like this idea even less. just use the tag 'tagname'
and move it around then :)

BTW can git have a tag and a branch with the same name? If not, I
would recomment the use of 'name' for the tag, 'name-branch' for the
branch, and 'tag-name-branch' for the branch under the tag.

> > I've been looking through the git-svn code to see if I could try an
> > implementation myself, but I must confess that the task seems way over
> > me ... I can't really wrap my mind around the git-svn code enough to
> > implement it.
>
> Coming up with agreed test cases is half (indeed sometimes most of) the
> work.

The only two svn projects I cooperate with don't have this particular
situation. IIRC David mentioned the case?

-- 
Giuseppe "Oblomov" Bilotta
