From: Subho Banerjee <subs.zero@gmail.com>
Subject: GSoC Application [ Parallelism + Git.pm ]
Date: Sun, 18 Mar 2012 13:06:17 +0530
Message-ID: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 08:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9Ag1-0004BF-KM
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 08:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab2CRHgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 03:36:38 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:55410 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2CRHgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 03:36:38 -0400
Received: by vcqp1 with SMTP id p1so5471805vcq.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 00:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=cWSzIk1DIi63DF1faOTaGiUaiAUDlUi8W+Vwa+/uaVQ=;
        b=KO+KkckD3ajQOFpAJnsB/U7LYrqWd9Vitvh9Tq4+UlqEeR76KMeM6677oxRr1/0Eb+
         rEdBTSHJNO6juckm63rsDDW5rh+XWhosYQiOFSJVURa+YFZ4R2cmaDVa3MSS9/hh+nIj
         5STVOArKSXnbgUmuW35YOe8ByRE/PslW0OFjBA7UTuWcQjhEyKRNnA97Inj2RUSrhlrK
         ol9gNeI9o6IEZ3Ewa13j8/XH4/a0cW9MNVGG/UYNuFupNkvBWnV+qaj0Ny0MfvGqKDvK
         YSn9sSmUsoAXoM/oiL0MLoyVtVQRi++JMiOQ/GLSw/s5xWw2noTGFwA/bG3kAcLaYxVm
         M4zQ==
Received: by 10.220.141.201 with SMTP id n9mr2877767vcu.66.1332056197295; Sun,
 18 Mar 2012 00:36:37 -0700 (PDT)
Received: by 10.220.46.137 with HTTP; Sun, 18 Mar 2012 00:36:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193373>

Hello,

I am a fourth year undergraduate student of Computer Science and
Engineering at LNMIIT, India. I am extremely comfortable coding in
C/C++ and perl. I am really interested in taking up the Google Summer
of Code program for the "git" project. I have been a git user for a
couple of years now, though I was introduced to github very recently.
Though I have never tried tinkering around with the git source code, I
am a fast learner and I would love to contribute towards making git
better.

I had a look at the "Ideas" page on the GSoC website and I really
liked two particular project ideas, in which I believe I can
contribute to a larger extent.

* Improving parallelism in various commands
* Modernizing and expanding Git.pm


Previously, in the last two summers, I was an intern at the European
Organization for Nuclear Research(CERN). here I worked on mainly two
projects(though none of them used git for version control), whose
experience I believe can be used directly in the tasks I mentioned
above. Firstly, I was working on a HPC monte-carlo simulations and how
to make them faster using pthreads, openmp and cuda.  Secondly, I was
working on a grid middleware solution written completely in perl.

>From what I understand of these tasks --

* In the first one, which wants to parallelize certain commands in
git, I believe  the major challenges will be to actually find a large
list of commands which can be parallelized.In addition to the commands
mentioned in the Ideas page, only other place I currently think of
exploiting parallelism is in traversing the commit tree when one is
cloning a repository. I would really like it if someone can suggest
more places where this sort of parallelism might be usable, so that I
could use that to make a more complete application. I believe one of
the major difficulties I will initially face, is my unfamiliarity with
the code. This makes finding these commands which might have better
performance with parallelism a little difficult.

* For the second one, which aims at improving the Git perl module. I
tried looking around for this one on the net. I was a little confused
since I could not make out which module this was on CPAN. Is this one
of the Git::* modules or is it all of them. Because the the
functionality of the Git::Config and Git::Commit as mentioned in the
Ideas page seems to be there in the Git::Repository module on CPAN.
Could some one please clarify this.

I would really appreciate any ideas or advice for making my
application for GSoC 2012 better.


Cheers,
Subho.
