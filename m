From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 17:41:27 +0200
Message-ID: <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
	 <20070417104520.GB4946@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pietro Mascagni" <pietromas@gmail.com>
To: "Tomash Brechko" <tomash.brechko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpoE-0001vH-Mz
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030672AbXDQPla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbXDQPla
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:41:30 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:21101 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030672AbXDQPl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:41:28 -0400
Received: by an-out-0708.google.com with SMTP id b33so2266956ana
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 08:41:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YTbn/XmYmENcen6F6pisfJHda8GJ5sW8pM/uUxp8C4lUxfi4Dq7SYuNdKpYcV0NoeLDa3IFo+UxtnYHkTaKAmJOC+8rWLQdPENKDlMVfQfzaxFduTxyeg0mgszg/hXirRsNGBR70DxoFIrkxR3V3/bjGUbBOc4eOOLtJljttWBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pv5GXcngcMkFuYlbyvRkhlbwJM3Puviyp5JOHOpe5oIKl8eOZhyNgv0OboF2bAyJTTo8R0S6qxvZZhbRCQtsN79Kc8VGc4z9xlGGIL5r4v5xTDV+M3ke0vWgvY2zvHcVSlQzK6YFPxr11Oc3W9n7YbnQ3nZJsf8C72bEW9xUiQo=
Received: by 10.100.137.18 with SMTP id k18mr5563314and.1176824487565;
        Tue, 17 Apr 2007 08:41:27 -0700 (PDT)
Received: by 10.100.44.7 with HTTP; Tue, 17 Apr 2007 08:41:27 -0700 (PDT)
In-Reply-To: <20070417104520.GB4946@moonlight.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44781>

I'm new to Git, but completly crazy of it.

In my point of view, in corporate team, lot of people does not
want/need the power offered by Git.
So, my conclusion is the better model in a corporate is a centralyzed
repo with some users using Git as "frontend". Other people will simply
use the native tools for accessing the repo.

I didn't try Git with CVS repo but seems less usable in day to day
work than a SVN repo with git-svn FANTASTIC tool.

So the problem is simply now: how to convince people to migrate from
CVS to SVN. This will be really less difficult as CVS and SVN are
quite similar.

On 4/17/07, Tomash Brechko <tomash.brechko@gmail.com> wrote:
> On Tue, Apr 17, 2007 at 10:02:18 +0100, Pietro Mascagni wrote:
> > So, in 15 seconds, how does one argue that GIT is vastly superior to
> > other version control software, especially CVS.
>
> I think you are not talking about choosing SCM for a new project, as
> it is even _hard to imagine_ that one would consider CVS nowadays :).
> And if you are trying to convince people to do the migration from CVS
> to GIT, then technical points alone won't probably help you.  GIT, and
> actually most modern SCMs, are superior to CVS not simply because they
> have some CVS's features improved, and some nice features added.
> Modern SCMs implement completely different workflow model.  GIT's own
> power in its rich toolset, but until people learn (or at least are
> willing to learn) what the workflow is, and how it is supported by
> these tools, there's little advantage in migration.  You can't really
> explain why 'git commit; git push' into some central repository is
> better than 'cvs commit', and pushing after every commit is what
> people will be doing at first ;).  You should also realize that the
> whole process is probably already built around CVS (CVS-specific
> hooks, scripts that access CVS, say, for nightly testing, etc), that
> would also have to be reimplemented.
>
> You may consider another route: create a GIT mirror of CVS repository,
> and update it, say, daily, with git-cvsimport.  Clone from this
> mirror, and work with your own GIT tree, pushing back to CVS with
> git-cvsexportcommit.  Yes, you will be dealing with problems that
> wouldn't be there in the first place if everyone would use GIT, and
> you will basically use CVS workflow, but still, this way is quite
> manageable.  Then approach the most promising guy in the company, and
> explain to him how you benefit from using GIT (gitk/qgit, git-bisect,
> StGIT are among your friends here :)).  As the saying goes, "Better to
> see once, then to hear about a hundred of times".  You are not
> interested in instant migration, and then being blamed if anything
> would go wrong.  When you will grow sufficient number of GIT experts
> in your company, then you will raise the migration question again.
>
>
> Good luck!
>
> --
>    Tomash Brechko
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
