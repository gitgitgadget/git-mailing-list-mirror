From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 02:35:30 +0530
Message-ID: <CALkWK0kQSuvv9owUYxatKTKW+GEpR0kL6XsyrOJD66yfodycUQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <rmisj0vnorm.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:06:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkhNv-0001yG-Ig
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755338Ab3FFVGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 17:06:11 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:38690 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab3FFVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:06:10 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so8600161ief.12
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QrxdaCws0jq1DrHrEmDNNXJnkZR+VJrJF7kGoOEtwqE=;
        b=v1+Yh2eHd5rbtlqWf9rU+k5KXxMfhvirvMEEP75wqhxfk8bkr4ufw4v92+KuybfkIA
         gs4XsMenBvqfvaQUHN2x9mdmyuoNfxHHH4L9LjaovFxOzgWMWSJ7OlAaJ17T6L4kPK/B
         /zx41f5pj/qYTzDtek0jsuQ1NMosyQIi2wPqfXrK20fgfBGVi56Muo7AmFWTKH/J7ViB
         BJ2sIvlLygTodkskJ3KLLT4NuEMIDzzwu3/UI955s/uPZcs2WHba136jf8pUD9r56w+6
         YpUoMvZlwsL6gCEwfk0yb5JdUfp8cYIxn6dF8gLGAfdcrdQVRjDpxDiG0aZQgAuzHcIt
         PGIQ==
X-Received: by 10.42.95.147 with SMTP id f19mr18087721icn.24.1370552770264;
 Thu, 06 Jun 2013 14:06:10 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Thu, 6 Jun 2013 14:05:30 -0700 (PDT)
In-Reply-To: <rmisj0vnorm.fsf@fnord.ir.bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226558>

Greg Troxel wrote:
> It's not about what I want.  It's about making choices that affect other
> people, and trying to find a plan that will be overall reasonable;
> that's the essence of stewardship in packaging.  Compiling for just
> myself is far easier.

Have you asked the SBCL or Google-Chrome package maintainers what they
have to deal with?  I believe they're packaging nightmares.  GHC/
Haskell projects aren't far behind.  Git is probably the _last_ thing
to be complaining about when it comes to packaging.

Sure, people want to run Git on embedded devices like Rpi.  The core
is already in C and Bourne Shell, and I don't see anyone rewriting
that in Ruby.  No cause for concern.

> That ignores the 99% of people who use packaged versions.  The question
> is really "Should the standared approach for building be to use or not
> use dependency X?".  Really this should be expressed in the README, and
> it creates expectations for someone who just installs the git package in
> terms of whether pieces of functionality are there.  Packagers generally
> should be reading the README and including required/recommended
> dependencies and not including optional dependencies (in the main
> package).  The information in INSTALL is pretty reasonable, but it
> doesn't really clearly say "if you hand someone git built without perl,
> it is { perfectly ok but missing a fringe optional feature | deficient
> because "git add -p" won't work }.   I'm leaning towards the "deficient"
> camp.

So whom is this extra dependency affecting, if 99% of users are using
packaged versions?  So, it's just extra burden for the package
maintainers (and users on source-based distributions)?  git-svn and
git-send-email are already separate packages on Ubuntu/Debian because
they depend on lots of CPAN packages that can be non-trivial to
install for new users.  If we do get one important Ruby script, ship
it as a separate package: done?

At the moment, there's just contrib/git-related that depends on ruby.
Can we just stop planning centuries in advance, and tackle the problem
when it arises?  It remains to be determined whether or not git.git
will grow a healthy ruby sub-ecosystem.  If it does, package
maintainers will be inconvenienced slightly.  Otherwise, we'll just
throw out the ruby code that's rotting in our tree, and get on with
our lives.

The direction of the project is not decided on the basis of some vague
future packaging expectations.  It's decided on the basis of what
patches come in from contributors, and everything else is secondary.
If people want to write ruby, they will write ruby.  Whether or not
the git project welcomes their contributions.
