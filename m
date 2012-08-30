From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Thu, 30 Aug 2012 06:37:07 +0200
Message-ID: <503EEDF3.2080202@alum.mit.edu>
References: <5030F0BF.2090500@alum.mit.edu> <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu> <7vmx1exmde.fsf@alter.siamese.dyndns.org> <503DCFAE.6060307@alum.mit.edu> <7vy5kxwtdo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 06:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6wW5-0007IR-Dd
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 06:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802Ab2H3EhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 00:37:13 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:64641 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750767Ab2H3EhM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 00:37:12 -0400
X-AuditID: 1207440e-b7f036d0000008b5-54-503eedf727fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CB.4A.02229.7FDEE305; Thu, 30 Aug 2012 00:37:11 -0400 (EDT)
Received: from [192.168.69.140] (p57A257F6.dip.t-dialin.net [87.162.87.246])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7U4b8EC004510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Aug 2012 00:37:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vy5kxwtdo.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqPv9rV2Awb1OMYuuK91MFg29V5gt
	jp6ysFj/7iqzA4vHzll32T0uXlL2+LxJLoA5itsmKbGkLDgzPU/fLoE7o2nVVOaCLaoVfUum
	MzYwNsh1MXJySAiYSKyeeoQRwhaTuHBvPVsXIxeHkMBlRonfR09DOWeYJDpuzWEBqeIV0JZ4
	df8cmM0ioCrROncWM4jNJqArsainmQnEFhUIkVjzbQojRL2gxMmZT8DqRQTUJCa2HQKzmQVK
	JL6/ncoKYgsLeEj8PbCOCWLZHiaJf4/ngSU4Bcwk3i7cwQ7RoCPxru8BM4QtL7H97RzmCYwC
	s5DsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI31cjNL9FJTSjcxQsKYbwdj
	+3qZQ4wCHIxKPLyzAu0ChFgTy4orcw8xSnIwKYnyTn0DFOJLyk+pzEgszogvKs1JLT7EKMHB
	rCTCu+MuUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMGbDDJUsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSt8cXAeAVJ8QDt/Q3SzltckJgLFIVoPcVo
	yfH/5Mm7jByfn4LIybfO3mUUYsnLz0uVEue9AtIgANKQUZoHtw6WzF4xigN9L8w7AaSKB5gI
	4aa+AlrIBLRwv6I1yMKSRISUVAPjMokmDvdDi3d8zhVW220WZryn7YPK5l3GElmcN9veP3Q7
	XnH69dOjEftZ7392D4jnluZnyHF6leC+wcWCL+pk9I6szcdXLVJ1urz5d+qRdfyR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204522>

On 08/29/2012 06:33 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 08/29/2012 08:06 AM, Junio C Hamano wrote:
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>> It is in fact the whole approach that I object to.
>> ...
>>> What exactly is broken in CEILING?
>>
>> CEILING is used in setup_git_directory_gently_1() when trying to find
>> the GIT_DIR appropriate for the current directory.  The entries in
>> CEILING are compared textually to getcwd(), looking for the entry that
>> is the longest proper prefix of PWD.  This is then used to limit a loop
>> that is vaguely
>>
>>     while (!is_git_directory())
>>             chdir("..");
>>
>> The problem, as I understand it, is that when the tests are run with
>> root set to a path that includes a symlink, then test and
>> TRASH_DIRECTORY are set to the textual value of "$root/trash
>> directory.tXXXX", but then a little bit later test-lib.sh chdirs into
>> the trash directory using "cd -P $test" (thereby resolving symlinks).
>> So, taking my concrete example "--root=/dev/shm" where /dev/shm is a
>> symlink to /run/shm, we have
>>
>>     test="/dev/shm/trash directory.tXXXX"
>>     TRASH_DIRECTORY="$test"
>>     ...
>>     cd -P "$test"
>>
>> which results in PWD being "/run/shm/trash directory.tXXXX".
> 
> The components of CEILING should be adjusted to strip the symlink so
> that it begins with "/run/shm/" before it is used; otherwise it
> would not work.  As the current code does not do that at runtime (I
> am describing the situation, not justifying), it won't match if
> CEILING is built out of $TRASH_DIRECTORY.  In the above, setting of
> $test and $TRASH is wrong; it does not match the realpath.
> 
> So "I somehow thought that Jiang's patch was to make sure any
> variables that contain pathnames (and make sure future paths we
> might grab out of $(pwd)) are realpath without symlinks early in the
> test set-up," in my previous message was not correct.  The patch is
> not doing that, and that is what breaks your setup.

I've confused things by not being clear what I was describing.  The
description that you quoted above was the state *before* Jiang's patch.
 Jiang's patch makes sure that $TRASH_DIRECTORY is a realpath.  The
working directory was already a realpath before his patch (due to commit
1bd9c648).  There are some other variables that are not necessarily
realpaths, even after Jiang's patch; for example (via a casual look at
test-lib.sh): $remove_trash, $HOME, $test, $TEST_DIRECTORY,
$test_results_dir, $GIT_BUILD_DIR.  I haven't checked whether these
variables are used in ways that could cause other problems.

When Jiang's patch is applied the test suite runs to completion without
any failures on my system even when I pass --root=/dev/shm (a symlink).

> My preference is to set things up in such a way that most of the
> tests do not have to worry about these symlink aliases.  I know you
> said you do not like the "whole approach", but I'd like to see our
> tests run in a stable and reproducible testing environment.
> 
> We should have specific tests (on symlink enabled platforms) that
> creates a directory and an alias to it via a symlink, goes into it
> and checks the CEILING (and whatever else) behaviour.  We know that
> the current code does not account for the alias introduced by
> symlinks, and setup_git_directory_gently() may want to be patched to
> fix _that_ specific test.

Yes, stable and reproducible is good.  And explicit tests for
symlink-sensitive code would be good.  But how do we find the code that
needs explicit testing for symlink tolerance?

Therefore (in addition to specific tests) I think it would be good to
have an easy way to run the *whole* test suite in a symlink environment.
 For example, we could add a test suite option that *explicitly* makes
all tests run in a directory containing symlinks.  Or we could even do
that *all* of the time on systems that support symlinks [1]--that would
be a stable and reproducible testing environment that *does* detect many
symlink problems rather than hiding them.  (It seems unlikely the the
use of symlinks would *hide* other bugs.)  Something along the lines of

    mkdir -p "$test.dir"
    ln -s "$test.dir" "$test"

By the way, is the use of realpath(3) permissible in git code?
GIT_CEILING_DIRECTORIES handling could be fixed relatively easily by
using this function to canonicalize pathnames before comparison.

Michael

[1] This would be analogous to the inclusion of a space in "trash
directory.*", which I presume was done to detect space-handling problems
quickly.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
