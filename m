From: Artem Khodush <greenkaa@gmail.com>
Subject: Re: [wish] Auto-generate gitk's pretty pictures
Date: Sat, 14 Jan 2006 19:26:04 +0300
Message-ID: <40b2b7d90601140826k7c30ce7bk3a259061cb333133@mail.gmail.com>
References: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>
	 <40b2b7d90601131414o20eae573r23256ff2dfbeffa5@mail.gmail.com>
	 <46a038f90601131444m32a1a8b8w7ab16617f15ab93b@mail.gmail.com>
	 <40b2b7d90601131905s6bb9954fk8e359e3f066ce0c2@mail.gmail.com>
	 <43C8FE6F.4050206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 17:26:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExoEH-0001Vv-6v
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 17:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWANQ0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 11:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWANQ0H
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 11:26:07 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:57065 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964805AbWANQ0F convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 11:26:05 -0500
Received: by uproxy.gmail.com with SMTP id s2so216147uge
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 08:26:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dOK2neJi7mvdXGqz/ujoruWJD55kWXBmHs08r/7V3FRLT/W/TqQ7Rje3D79OquHJ7DqsaRZxH7LBu1zCZ0SjWRh2RL2ueme4XsElOmpLInjVkEmluWjrXBN+agAo/Tu5/sCdvydwIPJ+lRf1790xLqG9UY7pEkvNBOsCpriguSE=
Received: by 10.49.28.3 with SMTP id f3mr132495nfj;
        Sat, 14 Jan 2006 08:26:04 -0800 (PST)
Received: by 10.48.216.3 with HTTP; Sat, 14 Jan 2006 08:26:04 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43C8FE6F.4050206@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14668>

On 1/14/06, Andreas Ericsson <ae@op5.se> wrote:
> Artem Khodush wrote:
> But, the next feature I plan to add
> > is to show commits in the same window in a way like gitk does.
> >
>
> Why not just have a separate frame for the commits and load gitweb.cgi
> there?

Mainly because gitweb can't show the commit in most
convenient (IMHO) way, with everything on one screen.
I like the way gitk does it, when you can see all at once -
list of changed files in the lower right pane and commit message
with links to parent and child commits and diff in the left.

And with gitweb, those links to related commits must allow somehow
to highlight those commits on the diagram, wich means that gitweb
must be made aware of the frame that it's embedded in, and must
be able to call some javascript there. Eventually I will add interaction
with gitweb in some way or another, but for now, it's easier for me
to just show the commit.
