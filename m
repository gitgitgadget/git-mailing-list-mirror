From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Minimum required version of subversion for git-svn?
Date: Sun, 11 Jan 2009 17:03:54 -0800
Message-ID: <20090112010354.GB23377@yp-box.dyndns.org>
References: <496722CF.1060802@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Mon Jan 12 02:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBF2-0000oZ-6O
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbZALBDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZALBDz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:03:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37932 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbZALBDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:03:54 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498821FE52;
	Mon, 12 Jan 2009 01:03:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496722CF.1060802@statsbiblioteket.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105263>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> wrote:
> Hello,
>
> With git 1.6.0.5 I was able to run git-svn with subversion 1.1.4 on
> RHEL4/i386 but with 1.6.0.6 and 1.6.1 the testsuite now fails in the new
> test t9104.10:

...

> With 1.6.1 I also see t9129.10-12 failing with subversion 1.1.4:
> * FAIL 10: ISO-8859-1 should match UTF-8 in svn

...

> * failed 3 among 12 test(s)
> make[2]: Leaving directory `/builddir/build/BUILD/git-1.6.1/t'
> make[2]: *** [t9129-git-svn-i18n-commitencoding.sh] Error 1
>
> I see in git-svn.perl that only SVN::Core 1.1.0 is required. Is it still
> the intention that git-svn should work with subversion 1.1.x?
>
> If you're going to bump the minimum requirement I would ask that you
> atleast keep 1.3.x as supported. This is the last release of subversion
> where RHEL3 can satisfy the dependencies out of the box and I've
> verified that the testsuite will pass with 1.3.2.

It's still my intention that SVN 1.1.x is supported; but I haven't had
the chance to test those versions in a while.

Can you rerun the tests that failed with "sh -x t91..." ?

Thanks.

-- 
Eric Wong
