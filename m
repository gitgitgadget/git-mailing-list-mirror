From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Wed, 18 Oct 2006 11:28:32 +0200
Message-ID: <845b6e870610180228m39829c49nf37e07e76e744250@mail.gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610171555.56778.jnareb@gmail.com> <vpqr6x711cm.fsf@ecrins.imag.fr>
	 <200610171641.04455.jnareb@gmail.com>
	 <20061018000026.GH20017@pasky.or.cz> <45357596.8050702@utoronto.ca>
	 <20061018003920.GK20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	bazaar-ng@lists.canonical.com,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 18 11:29:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7jC-0000Pd-Ru
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 11:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWJRJ2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 05:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWJRJ2f
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 05:28:35 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:30376 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932148AbWJRJ2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 05:28:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so290073pyg
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 02:28:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m4KfM7xAPd7f5ahk8tXedv+ksMcXhjq/ScbN/YQ2ieKW3oH8NwgEIrrm/8AlfBCQEML8F/5eh0kfF2d0RmAFSNWH8aX8g5s4o6jV+ovIF/wCGLWKej5Mw8Z1B8SBlAIOnsNRoqd4fzxU+HP1YzIZHqQpMlkoZL/MZXx6pfehnfE=
Received: by 10.35.102.1 with SMTP id e1mr17322697pym;
        Wed, 18 Oct 2006 02:28:33 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Wed, 18 Oct 2006 02:28:32 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20061018003920.GK20017@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29212>

On 10/18/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Oct 18, 2006 at 02:30:14AM CEST, I got a letter
> where Aaron Bentley <aaron.bentley@utoronto.ca> said that...
> > Petr Baudis wrote:
> > > Another aspect of this is that Git (Linus ;) is very focused on getting
> > > the history right, nice and clean (though it does not _mandate_ it and
> > > you can just wildly do one commit after another; it just provides tools
> > > to easily do it).
> >
> > Yes, rebasing is very uncommon in the bzr community.  We would rather
> > evaluate the complete change than walk through its history.  (Bundles
> > only show the changes you made, not the changes you merged from the
> > mainline.)
> >
> > In an earlier form, bundles contained a patch for every revision, and
> > people *hated* reading them.  So there's definitely a cultural
> > difference there.
>
> BTW, I think what describes the Git's (kernel's) stance very nicely is
> what I call the Al Viro's "homework problem":
>
>         http://lkml.org/lkml/2005/4/7/176
>
> If I understand you right, the bzr approach is what's described as "the
> dumbest kind" there? (No offense meant!)

Yes and no, The bundle includes both the full final thing, and each
step along the way. Each step along the way is something you'll get
when you merge it.

Once merged, it will be "next one" in the description above. It would
typically look something like this in "bzr log"(shortened)  In this
example, doing C requires doing A and B as well...

committer: foobar@foobar.com
message: merged in C
      -------
      committer: bar@bar.com
      message: opps, fix bug in A
      -------
      committer: bar@bar.com
      message: implement B
      -------
      committer: bar@bar.com
      message: implement A

So, you'll get full history, including errors made :)  You can also
see who approved it to this branch (foobar) and who did the actual
work (bar)

/Erik
