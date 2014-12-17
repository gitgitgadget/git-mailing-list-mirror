From: John Tapsell <johnflux@gmail.com>
Subject: Improving git branch
Date: Wed, 17 Dec 2014 11:10:10 +0000
Message-ID: <CAHQ6N+qBUcBcG8RC6Co+k_GmJDXCynmyfZmvTjz4bQyH1wG3DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 12:11:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1CVD-0008Pf-44
	for gcvg-git-2@plane.gmane.org; Wed, 17 Dec 2014 12:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbaLQLKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 06:10:32 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:58579 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaLQLKb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 06:10:31 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so3133787obc.10
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 03:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=yxVelZQscr2Td3SEk/rDk5fV+nDJQRGVIWVOJ2YsUuQ=;
        b=pXzJFYJn5e9BbIxWtFahNU4HHmqZ8Bed4M8uJPb6AKUS+Xg6QI7hyNUk+FYFKnsKwB
         B1FNqNVObqRGrDjqqTNfNSCDSzeJwlHIQAWDe/YRlFTeMVW+rrJGRQsLuA329y5LuALz
         D5HaiqUqAazZQQ3WJ3K/A8rxKtWgsmh/lX5Q5qlQphD5RgctnyC8mfEdBSQ1YFyyb40D
         KZowvTYAo/iHKZlymLKt1lgaOPO5TvuJ0IM4K1lzqgz6uh+EIeFcj7cljki/8LVN11q9
         a1AA+UzxNCROOouzKoc+Dq4J0b29uhfikInKYnyGi1rPG5Pcr2MAbNFYreoqq659Km7X
         4wVQ==
X-Received: by 10.202.80.21 with SMTP id e21mr24449645oib.65.1418814631064;
 Wed, 17 Dec 2014 03:10:31 -0800 (PST)
Received: by 10.60.25.6 with HTTP; Wed, 17 Dec 2014 03:10:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261479>

Hi all,

  I'm interested in putting in some time and effort into improving the
output of "git branch".

  What I'm thinking is an output like this:

$ git branch

2014-12-17 * (detached from origin/master)     deaba04 Do stuff
2014-12-15   john.ta/add_timing_info                6edbcfa  Add timing stuff
2014-12-14   master                                          8537316
[origin/master: ahead 1, behind 16] Some stuff
2014-12-12   john.ta/new_reduce_memory       99d84db Reintroduce: memory stuff
2014-12-05   john.ta/bugfixes                            e15c95e Add stuff
2014-12-03   john.ta/container                           e9fd4e5 This
branch is a test bed for containers


(These columns are supposed to be all aligned nicely..)

So, features:

1. Show the date of the last commit
2. Sort by date.  Most recently used branches at the top
3. Show the branch name, including your current "branch", with a * to
indicate that it's checked out.
4. Show the sha
5. Show the branch DESCRIPTION - and if that's not available, show the
short-line of the most recent commit.

There is also a small amount of color here that I can't paste here, to
follow the coloring in the current git branch.

Before I start making patches etc, what do people think?  Would I have
a chance of getting this in?  Should I change some aspects etc?

Thanks,

John Tapsell
