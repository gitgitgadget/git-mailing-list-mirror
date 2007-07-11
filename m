From: "Bradford Smith" <bradford.carl.smith@gmail.com>
Subject: Re: user manual wrong about remote branches?
Date: Wed, 11 Jul 2007 11:34:26 -0400
Message-ID: <f158199e0707110834sdaa29f2x65df784f4b3a6b5e@mail.gmail.com>
References: <f158199e0707110821k50a55e66p8fb0b92a3dec9ed2@mail.gmail.com>
	 <20070711152816.GB4138@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 17:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8eD5-0003qm-2D
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103AbXGKPeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755248AbXGKPeb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:34:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32531 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbXGKPea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:34:30 -0400
Received: by ug-out-1314.google.com with SMTP id j3so139212ugf
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 08:34:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fv3ByHb5bq24i3Ha17vRXvwm6N4Y4HGJAfh/u9j1j2x2dGRSgX6gcrjyYrWmGLutSYk2WUtNopbBKnh1QSS+b1Xt2z9w20HlJ3T6/x6Y+jHSUZLqohhnToKQ+FIEUUpBqiR1JUhYol/+KT8EPK6SQ6GaXZziQqMwodrVOgKPFq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EfhJ2A4Jz6uDp3l1un4ydHwd6FdxtPcPh/Xi8oTBiNDs6epKG7MZ1zwcnfXpVX/O/qHIZUQXypMngiazEfRRH7hw1pk9jNF6m83ZDoGkMDLUbwtHQyOPl4o0izTsQrbpI9v28LutdClJadlwUj8qOdGHohyOj/D2fBOSwOa3js0=
Received: by 10.78.162.4 with SMTP id k4mr2451840hue.1184168066094;
        Wed, 11 Jul 2007 08:34:26 -0700 (PDT)
Received: by 10.78.178.10 with HTTP; Wed, 11 Jul 2007 08:34:26 -0700 (PDT)
In-Reply-To: <20070711152816.GB4138@fieldses.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52171>

OK, the problem was the old version of git (1.4.4.2) I used to do the
original clone.  Cloning with the latest version gives me what the
manual says I should get.

Thanks!

Bradford C. Smith

On 7/11/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> On Wed, Jul 11, 2007 at 11:21:53AM -0400, Bradford Smith wrote:
> > I got the latest git source like this:
> >
> > git clone git://git.kernel.org/pub/scm/git/git.git
>
> What version of git did you do this first clone with?
>
> > Then I did:
> >
> > make prefix=/usr/local all doc
> > make prefix=/usr/local install install-doc
> >
> > So my current version is:
> >
> > git version 1.5.3.rc0.gbaa79
> >
> > Now, Documentation/user-manual.txt says I should be able to see the
> > remote branch I cloned from when I do this in the source directory.
> >
> > git branch -r
> >
> > However, this command gives no output at all.  What gives?  Does this
> > mean git-fetch and git-pull won't work properly to keep me up-to-date
> > with the main repository?
>
> The remote branch setup  is done on the initial clone.  So if you clone
> again with the newly installed version of git, you'll probably see
> what's expected.
>
> --b.
>
