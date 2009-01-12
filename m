From: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
Subject: Re: Minimum required version of subversion for git-svn?
Date: Mon, 12 Jan 2009 09:03:48 +0100
Message-ID: <496AF964.1070208@statsbiblioteket.dk>
References: <496722CF.1060802@statsbiblioteket.dk> <20090112010354.GB23377@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMHnc-00023d-S1
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011AbZALIDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001AbZALIDy
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:03:54 -0500
Received: from sbexch03.sb.statsbiblioteket.dk ([130.225.24.68]:13106 "EHLO
	sbexch03.sb.statsbiblioteket.dk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754981AbZALIDx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 03:03:53 -0500
Received: from [130.225.25.159] (130.225.25.159) by
 sbexch03.sb.statsbiblioteket.dk (130.225.24.68) with Microsoft SMTP Server id
 8.1.336.0; Mon, 12 Jan 2009 09:03:48 +0100
User-Agent: Thunderbird 2.0.0.18 (X11/20081124)
In-Reply-To: <20090112010354.GB23377@yp-box.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105300>

Eric Wong wrote:
> "Tom G. Christensen" <tgc@statsbiblioteket.dk> wrote:
>> Hello,
>>
>> With git 1.6.0.5 I was able to run git-svn with subversion 1.1.4 on
>> RHEL4/i386 but with 1.6.0.6 and 1.6.1 the testsuite now fails in the new
>> test t9104.10:
> 
> ...
> 
>> With 1.6.1 I also see t9129.10-12 failing with subversion 1.1.4:
>> * FAIL 10: ISO-8859-1 should match UTF-8 in svn
> 
> ...
> 
>> * failed 3 among 12 test(s)
>> make[2]: Leaving directory `/builddir/build/BUILD/git-1.6.1/t'
>> make[2]: *** [t9129-git-svn-i18n-commitencoding.sh] Error 1
>>
>> I see in git-svn.perl that only SVN::Core 1.1.0 is required. Is it still
>> the intention that git-svn should work with subversion 1.1.x?
>>
>> If you're going to bump the minimum requirement I would ask that you
>> atleast keep 1.3.x as supported. This is the last release of subversion
>> where RHEL3 can satisfy the dependencies out of the box and I've
>> verified that the testsuite will pass with 1.3.2.
> 
> It's still my intention that SVN 1.1.x is supported; but I haven't had
> the chance to test those versions in a while.
> 
> Can you rerun the tests that failed with "sh -x t91..." ?
> 
I've run the tests from 1.6.1 with -v, sh -x and sh -x + -v and dumped 
the results at http://jupiterrise.com/tmp

You'll find results from one more test (t9106) which I didn't mention 
and which is also giving me problems but only with rhel4/x86_64 and svn 
1.1.4. It should be noted that this test has never worked for me with 
this config.

-tgc
