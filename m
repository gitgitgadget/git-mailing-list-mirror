From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: [ANN] Pyrite prerelease
Date: Thu, 24 Apr 2008 11:10:36 -0500
Message-ID: <5d46db230804240910r2e6d8862h4cefd086b1fa0a2d@mail.gmail.com>
References: <5d46db230804232342q1d92064bq7ea4fdba6f1551b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 18:11:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp42k-0004o1-5F
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 18:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163AbYDXQKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2008 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757765AbYDXQKl
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 12:10:41 -0400
Received: from el-out-1112.google.com ([209.85.162.179]:27345 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757577AbYDXQKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2008 12:10:40 -0400
Received: by el-out-1112.google.com with SMTP id n30so1204594elf.21
        for <git@vger.kernel.org>; Thu, 24 Apr 2008 09:10:38 -0700 (PDT)
Received: by 10.114.57.1 with SMTP id f1mr2005792waa.78.1209053436779;
        Thu, 24 Apr 2008 09:10:36 -0700 (PDT)
Received: by 10.70.13.16 with HTTP; Thu, 24 Apr 2008 09:10:36 -0700 (PDT)
In-Reply-To: <5d46db230804232342q1d92064bq7ea4fdba6f1551b6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80307>

On Thu, Apr 24, 2008 at 1:42 AM, Govind Salinas
<govind@sophiasuchtig.com> wrote:
> The official posting can be seen at
>  http://pyrite.sophiasuchtig.com/2008/04/announce-001prealpha.html
>
>  Hey Everyone,
>
>  I am proud to announce the first pre-release of Pyrite 0.01prealpha. You
>  can pull from git://gitorious.org/pyrite/mainline.git or
>  http://git.gitorious.org/pyrite/mainline.git ( I think I will use gitorious for
>  hosting since tuxfamily doesn't have an http clones, although I will
>  sort-of miss the RSS feed).
>
>  Why such a timid name? This is because it has taken me longer than I
>  wanted to reach a point where I felt others could reasonably use and
>  contribute to the project. There is still much work to be done before it
>  is ready for a general purpose release. However, I need to see if
>  people are really interested in both helping develop and, more
>  importantly, using Pyrite and I feel that getting a release out there will
>  help me gauge that.
>
>  When I started this project, I had a good idea of what I wanted to
>  accomplish but I wasn't entirely sure how I would do it. At this point I
>  have an idea of how the interface should be presented and I will work
>  to get it right. I hope people will have input on what improvements they
>  would like to see to the UI.
>
>  Other things that I want to do before making a general purpose release
>  is to tie up some loose ends like proper rebasing and a graphical merge
>  tool (at least support for external merge tools). That's just the tip of the
>  iceberg though since I have plans to also do a gui and a web interface.
>
>  Feel free to contact me about this if you are interested in using, testing
>  or developing.
>
>  Thanks,
>  Govind.
>

I got several responses about how the announcement was short on
details.  You guys are absolutely right, I blame the benedryl and the late
hour.  Anyways...

Pyrite, in its current form, is a git porcelain.   Its focus is to reduce the
learning curve, increase portability and, basically, make it as easy to
use as possible.  I say "in its current form" because this is simply the
first stage of Pyrite's development.  When Pyrite is complete I expect
that it will a cross between a porcelain and a python re-implementation
(similar to what the egit/jgit folks are doing).

I think Pyrite is a good idea for several reasons.  First and formost,
there are several SCMs out there that are considered more usable
than git.  Hg, bzr and darcs all have a more user friendly reputation
than git.  There are even things to be learned (UI wise) from non
distributed systems. However, git would have a very difficult time
making the sort of changes that would be required because they have
an established user base and many people have gotten used to the way
it works currently.  Such changes would also break a lot of automation.
Also, git is both plumbing and porcelain and a lot of that shows in the
interfaces.  It provides many commands and options that a user would
very likely never use.  A project like Pyrite offers a break from the
interface that people can choose to take, leaving those that are used to
git or like the current way of doing things alone.

I think it also offers advantages in terms of portability and ease of
development.

The foreseeable future of Pyrite is this...

0.01)  Add a couple of bits of functionality that are think are missing for
          general use and make some internal changes to facilitate
          development.   Also, as I stated above, I now have a better picture
          of how I want the command line UI to behave, so I will be changing
          options and other things.

0.02)  Add the GUI.  I have already started work on it, but it is only
          about 1/3 done.

0.03)  Built in webserver.  This is similar to the "hg serve" command.  I
          think this is a good idea because there are times where it just
          isn't worth it to set up a webserver to share your changes.

0.04)  Move to using libgit where possible.

0.05)  See where it makes sense to the git commands I am using as
           python.  Things that are already scripts are obvious candidates,
           but also things that are simple wrappers over other git
           commands.

0.06-1.0)  Get feedback from users, fix bugs, add features and repeat.

I hope I was better able to answer people's questions here than in my
previous mail.

Thanks for the feedback,
Govind.
