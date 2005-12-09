From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: [PATCH 6/17] Document the [<head>...] and -- arguments to git-prune.
Date: Fri, 9 Dec 2005 01:50:25 +0100
Message-ID: <20051209005025.GA8932@puritan.petwork>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org> <1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org> <7v4q5jb149.fsf@assigned-by-dhcp.cox.net> <7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 09 01:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkWT1-0008H5-Gv
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 01:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbVLIAu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 19:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbVLIAu0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 19:50:26 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:21984 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932770AbVLIAu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 19:50:26 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051209005024.VTAN676.mxfep01.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 01:50:24 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id 5D63EADFE5; Fri,  9 Dec 2005 01:50:25 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzmnb9m7w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13408>

Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:

> > Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org> writes:

> > > The documentation for git-prune was lacking descriptions of the head
> > > arguments and the -- option.
> > >
> > > +<head>...::
> > > +        The heads to look for unreachable objects in.  This is
> > > +        relative to $GIT_DIR (e.g., "HEAD", "refs/heads/master").
> > > +        When unspecified, all heads are updated to match the
> > > +        remote repository.

> > ? updated to match???

> Come to think of it, why would anybody want to pass heads explicitly?
> It seems to me that it would allow you to _lose_ objects referenced
> only from omitted branches...
 
Sorry.  I have no idea why I pasted in that description.  How about:

<head>...::
        A head to use for an unreachability trace.

(This mimics the description of <object> in git-fsck-objects.)

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
