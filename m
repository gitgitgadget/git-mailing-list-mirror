From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Minimum required version of subversion for git-svn?
Date: Sat, 17 Jan 2009 02:58:11 -0800
Message-ID: <20090117105811.GB15801@dcvr.yhbt.net>
References: <496722CF.1060802@statsbiblioteket.dk> <20090112010354.GB23377@yp-box.dyndns.org> <496AF964.1070208@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Sat Jan 17 11:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO8tv-0006WY-7x
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 11:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745AbZAQK6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 05:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757408AbZAQK6O
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 05:58:14 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:37048 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756920AbZAQK6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 05:58:12 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE0C1F44D;
	Sat, 17 Jan 2009 10:58:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <496AF964.1070208@statsbiblioteket.dk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106041>

"Tom G. Christensen" <tgc@statsbiblioteket.dk> wrote:
> Eric Wong wrote:
>> "Tom G. Christensen" <tgc@statsbiblioteket.dk> wrote:
>>> Hello,
>>>
>>> With git 1.6.0.5 I was able to run git-svn with subversion 1.1.4 on
>>> RHEL4/i386 but with 1.6.0.6 and 1.6.1 the testsuite now fails in the new
>>> test t9104.10:
>>
>> ...
>>
>>> With 1.6.1 I also see t9129.10-12 failing with subversion 1.1.4:
>>> * FAIL 10: ISO-8859-1 should match UTF-8 in svn
>>
>> ...
>>
>>> * failed 3 among 12 test(s)
>>> make[2]: Leaving directory `/builddir/build/BUILD/git-1.6.1/t'
>>> make[2]: *** [t9129-git-svn-i18n-commitencoding.sh] Error 1
>>>
>>> I see in git-svn.perl that only SVN::Core 1.1.0 is required. Is it still
>>> the intention that git-svn should work with subversion 1.1.x?
>>>
>>> If you're going to bump the minimum requirement I would ask that you
>>> atleast keep 1.3.x as supported. This is the last release of subversion
>>> where RHEL3 can satisfy the dependencies out of the box and I've
>>> verified that the testsuite will pass with 1.3.2.
>>
>> It's still my intention that SVN 1.1.x is supported; but I haven't had
>> the chance to test those versions in a while.
>>
>> Can you rerun the tests that failed with "sh -x t91..." ?
>>
> I've run the tests from 1.6.1 with -v, sh -x and sh -x + -v and dumped  
> the results at http://jupiterrise.com/tmp
>
> You'll find results from one more test (t9106) which I didn't mention  
> and which is also giving me problems but only with rhel4/x86_64 and svn  
> 1.1.4. It should be noted that this test has never worked for me with  
> this config.

Thanks, I'll try to setup an environment that lets me test older
SVN builds over the weekend.

-- 
Eric Wong
