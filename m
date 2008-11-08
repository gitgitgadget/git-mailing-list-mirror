From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: How it was at GitTogether'08 ?
Date: Fri, 7 Nov 2008 21:08:27 -0800
Message-ID: <ee77f5c20811072108o21f97c97i8174f4f7ecd67030@mail.gmail.com>
References: <200811080254.53202.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 06:10:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyg5L-0008Ue-VH
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYKHFIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 00:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYKHFIa
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 00:08:30 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:62637 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbYKHFI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 00:08:29 -0500
Received: by ey-out-2122.google.com with SMTP id 6so672895eyi.37
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 21:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=exty367asv0YVTBSCJPAf5d12gycdzwXTIahplEhBMI=;
        b=Pz84Wu+R1iBEksGg/9AQ/eFpLCxAqm9MQsEZgEiGkYgTSbZ9HvBHnWgurOkAGIUYeS
         GJwEI+BPv5yd29mHlrvavMt+B5b+CiQ4UF9MBOTwxUX5mD65rltRSajeB5Pm6DWy993t
         4G/9+/rhf2xyUMfmJ9i/cUF+nc7fjdWcp8Hmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lu2MvSFajHpxxViK20iE9+LuT3nxrz6LcMr6h4Z5SF3+FPBYJ3x0h0rFePcVpZgNBD
         K7ZDUFrUI/cPvpcsgnBJChn1wdYVD7cOyXWICc3QJrEOzrypd+li+sdrHL2A9a9wrO2U
         /riy4rMZPjV3LPXoS1L1OovQSOb+RpDPoJhyM=
Received: by 10.210.127.10 with SMTP id z10mr4757038ebc.195.1226120907743;
        Fri, 07 Nov 2008 21:08:27 -0800 (PST)
Received: by 10.210.51.7 with HTTP; Fri, 7 Nov 2008 21:08:27 -0800 (PST)
In-Reply-To: <200811080254.53202.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100379>

On Fri, Nov 7, 2008 at 5:54 PM, Jakub Narebski <jnareb@gmail.com> wrote:

Here's my thoughts on some of these talks.

> Mon, Oct 27, 2008
> -----------------
> * Dscho: Contributing with Git
>  http://www.youtube.com/watch?v=j45cs5_nY2k

It was a good intro, but I was expecting a few more non-GitTogether
people. We had quite a large room, but there was only about a dozen
other people who came along. I don't know whether that was the fault
of the timing, lack of advertising, or a lack of interest.

> * Junio: Git Chronicle
>
>  blog: Junio went though a sort of statistical history of the Git project
>  that was fascinating (turns out there are still about 220 lines of code
>  still around from Linus original first commit).

This was really interesting. It would be great to put this on a
general web page instead of in a PDF.

> * Petr: Renames Again and Again and Again
>
>  IRC: detection of wholesame renames of directories (WIP) and '--follow'
>  limitation were mentioned, but outcome is unclear; pasky plans to hack
>  together some patch implementing explicit renames hinting

One thing I didn't get around to bringing up: one of the benefits of
diff-time rename detection that is often touted is that algorithms can
improve over time. Do folk here know whether that has actually
happened recently, in a general way? Do people actually expect major
improvements in the future?

> * Tom: GitHub
>
>  IRC: a tour, some history, and insight into how it works; some nice
>  gimmicks, such as "gist" (a git backed pastebin), or like network graphs
>  (look graphically at forks of a repository).
>
>  blog: Tom got to demonstrate GitHub and Gist to the group, most of whom
>  are very command line oriented and had not used either before.

The demo of iGitHub (an iPhone app that can act as a clone/push
target) looked really cool, if it can get further development. It
could potentially be really handy for travellers who could push to
their iPhone, and then push from there to an internet server.

> * Scott: Linkable Library
>
>  blog: got to talk about the need for a linkable git library
>
>  http://thread.gmane.org/gmane.comp.version-control.git/99608

It's good to see this starting to get wider traction. I think we
discussed that there could be benefits to git itself, beyond just
helping other programs access git repositories faster than fork/exec.

> * Sam: perl.git
>
>  blog: Sam demonstrated the work he went through to import 20 years of Perl
>  history into the git repository that the Perl team is just now finishing
>  transitioning to from Perforce.
>
>  http://utsl.gen.nz/talks/perl-history/slides/

It was very cool to see old-school email addresses like <isis!aburt>
in git, handled just fine.

> * Tim: Git as a Media Repository
>  http://www.thousandparsec.net/~tim/media+git.pdf

This has kicked off some mailing list discussion; I think this can be
a major weak point for git, since checking out only a subtree (and
only the latest revision) is the common SVN way, which copes with
media repositories and the like just fine.


> * JH: $$$ discussion
>
>  IRC: It was about the Google Summer of Code 2008 mentor money. It was
>  decided (given most of the mentors were there) to use it to help a few
>  folks cover their travel expenses to the GitTogether. Most folks actually
>  had their costs covered by their employer (yay for some big companies!)
>  but a few paid out of pocket, so we are helping them defray it a bit. and
>  the rest is being used to order and distribute some git t-shirts.

Yes, how are the t-shirts going? I seem to remember JH had volunteered
to do the logistics there.


Dave.
