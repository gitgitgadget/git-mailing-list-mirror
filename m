From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH v1 2/2] travis-ci: enable sequential test execution for
 t9113 and 9126
Date: Sun, 22 May 2016 20:26:17 +0000
Message-ID: <20160522202617.GA1866@dcvr.yhbt.net>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
 <1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
 <20160519100658.GA20225@dcvr.yhbt.net>
 <xmqqwpmqj7m1.fsf@gitster.mtv.corp.google.com>
 <7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 22 22:27:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ZyA-0004VD-Fr
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 22:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbcEVU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 16:26:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44838 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbcEVU0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 16:26:18 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51E961FCB1;
	Sun, 22 May 2016 20:26:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7A9DE9C1-4AC7-4FF3-B8B1-26DE84BA625B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295291>

Lars Schneider <larsxschneider@gmail.com> wrote:
> > On 19 May 2016, at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Wong <e@80x24.org> writes:
> > 
> >> Anyways, how about making the tests run on separate ports and
> >> not worry about serializing them at all?
> > 
> > Yeah, that does sound like a more sensible approach.
> 
> Makes sense. However, it's not something I will tackle soon.
> Would you be willing to pick up $gmane/295048 (the first patch) as is 
> and drop $gmane/295050 (the patch discussed here)? Then the majority
> of Git SVN tests would run on Travis CI.

Sure, patch 1/2 is signed-off and pushed to my repo.  Thanks.

I'll try to take a look at parallelizing the other tests instead
of marking them sequential some other time.

Junio:

The following changes since commit 3916adf9978b020f9a9b165f4c1c109046899560:

  Sync with 2.8.3 (2016-05-18 15:33:57 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-travis

for you to fetch changes up to e7e9f5e7a1d39bf210c59428cd2a98f0a6abba0b:

  travis-ci: enable Git SVN tests t91xx on Linux (2016-05-22 20:20:28 +0000)

----------------------------------------------------------------
Lars Schneider (1):
      travis-ci: enable Git SVN tests t91xx on Linux

 .travis.yml | 1 +
 1 file changed, 1 insertion(+)
