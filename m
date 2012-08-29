From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Wed, 29 Aug 2012 10:15:42 +0200
Message-ID: <503DCFAE.6060307@alum.mit.edu>
References: <5030F0BF.2090500@alum.mit.edu> <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu> <7vmx1exmde.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 10:16:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6dRO-0005Ls-M0
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 10:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043Ab2H2IPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 04:15:51 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:45005 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751547Ab2H2IPr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 04:15:47 -0400
X-AuditID: 12074413-b7f786d0000008bb-13-503dcfb2cfa3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.38.02235.2BFCD305; Wed, 29 Aug 2012 04:15:46 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7T8Fhjg001346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 29 Aug 2012 04:15:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vmx1exmde.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLvpvG2Awed9HBZdV7qZLBp6rzBb
	HD1lYbH+3VVmBxaPnbPusntcvKTs8XmTXABzFLdNUmJJWXBmep6+XQJ3xt195xgLPmpWrP2/
	hrmB8b1iFyMHh4SAicT5bQpdjJxAppjEhXvr2boYuTiEBC4zSryYtocFwjnOJDHt1gZmkCpe
	AW2J+ysOMYHYLAKqEo+nbwWz2QR0JRb1NIPZogIhEmu+TWGEqBeUODnzCQuILSKgJjGx7RCY
	zSxQIvH97VRWEFtYwEPi74F1YL1CAp8YJT7/cgexOQXMJD48n8UIUa8j8a7vATOELS+x/e0c
	5gmMArOQrJiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3TN9XIzS/RSU0o3MUJC
	WHgH466TcocYBTgYlXh4D/+1CRBiTSwrrsw9xCjJwaQkyvvrpG2AEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHeT8eBcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd79
	54AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kGRGl8MjFWQFA/Q3t0g7bzFBYm5
	QFGI1lOMxhz/T568y8jx+SmQFGLJy89LlRLn3QlSKgBSmlGaB7cIlrxeMYoD/S3MOwmkigeY
	+ODmvQJaxQS0ar+iNciqkkSElFQDo/z3jyuivlwxUSgWV+719e3rMBSVOG13+hBP4Pp3nqvW
	mpRePL6nr+fRefUrZ7qr9nody/yU6642e2lkl6ZG7wbu/bf42APmiEiaX7eao3s5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204472>

On 08/29/2012 08:06 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> But it also changes almost 600 *other* tests from "succeed even in the
>> presence of symlinks" to "never tested in the presence of symlinks", and
>> I think that is surrendering more ground than necessary.
> 
> Ouch.  I did not know have 600+ tests that cares about CEILING.

No, I'm referring to the whole test suite, which is approximately 600
files :-)  Because the patch changes TEST_DIRECTORY, it affects the
environment of all tests that use that variable (one of which being via
GIT_CEILING_DIRECTORIES).

But really I shouldn't have made it sound like this patch is so
terrible, because it is just a logical continuation of the approach begun by

    1bd9c648 t/test-lib.sh: resolve symlinks in working directory, for
pathname comparisons (2008-05-31)

It is in fact the whole approach that I object to.

>> I would rather
>> see one of the following approaches:
>>
>> *If* the official policy is that GIT_CEILING_DIRECTORIES is not reliable
>> in the presence of symlinks, then (a) that limitation should be
>> mentioned in the documentation; (b) the affected tests should either be
>> skipped in the case of symlinked directories or they (alone!) should
>> take measures to work around the problem.
> 
> What exactly is broken in CEILING?

CEILING is used in setup_git_directory_gently_1() when trying to find
the GIT_DIR appropriate for the current directory.  The entries in
CEILING are compared textually to getcwd(), looking for the entry that
is the longest proper prefix of PWD.  This is then used to limit a loop
that is vaguely

    while (!is_git_directory())
            chdir("..");

The problem, as I understand it, is that when the tests are run with
root set to a path that includes a symlink, then test and
TRASH_DIRECTORY are set to the textual value of "$root/trash
directory.tXXXX", but then a little bit later test-lib.sh chdirs into
the trash directory using "cd -P $test" (thereby resolving symlinks).
So, taking my concrete example "--root=/dev/shm" where /dev/shm is a
symlink to /run/shm, we have

    test="/dev/shm/trash directory.tXXXX"
    TRASH_DIRECTORY="$test"
    ...
    cd -P "$test"

which results in PWD being "/run/shm/trash directory.tXXXX".

Then (for example) in test t4035, we have stuff like

    GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/test-outside" &&
    export GIT_CEILING_DIRECTORIES &&
    cd test-outside/non/git &&
    git diff

The problem is that because PWD and TRASH_DIRECTORY *look* different,
the code in setup_git_directory_gently_1() doesn't realize that the
value of GIT_CEILING_DIRECTORIES is a parent of PWD, so it doesn't abort
the search for GIT_DIR there, and this causes the test to fail.

The underlying problem is that setup_git_directory_gently_1() isn't
smart enough to realize that the directory in GIT_CEILING_DIRECTORIES is
in fact a parent of PWD even though it textually doesn't look like one.

The patch being discussed sets TEST_DIRECTORY *after* $test has been
canonicalized (through the use of "cd -P $test"), so that TEST_DIRECTORY
and later GIT_CEILING_DIRECTORIES start with "/run/shm/" instead of
"/dev/shm/".  This change makes setup_git_directory_gently_1()'s naive
textual prefix comparison succeed.

The same problem would occur in the real world whenever the user sets
GIT_CEILING_DIRECTORIES to a value that is *in fact* a parent of PWD but
due to symbolic links *textually* does not appear to be a parent.

So the first decision is whether this should be documented as a known
limitation of GIT_CEILING_DIRECTORIES, or whether it is a bug.  My
opinion is that it is a bug.

> I somehow thought that Jiang's patch was to make sure any variables
> that contain pathnames (and make sure future paths we might grab out
> of $(pwd)) are realpath without symlinks early in the test set-up,
> and with that arrangement, no symlink gotcha should come into
> picture, with or without CEILING.

Yes, this is correct.  But what you call a "gotcha" is actually a
real-world possibility.  Git might *really* be run in a PWD that
contains symlinks, or GIT_CEILING_DIRECTORIES might contain entries that
are symlinks.  So by resolving symlinks in PWD before running tests, we
are preventing the tests from ever encountering this situation, and
therefore failing to test whether git works correctly when PWD includes
a symlink.

> Perhaps the setting of the CEILING has not been correctly converted
> with the patch?

That's not the problem.

> Or is there something fundamentally broken, even if we do not have
> any symlinks involved, with CEILING check?

I believe that:

1. The handling of GIT_CEILING_DIRECTORIES in
setup_git_directory_gently_1() (i.e., in git itself, not how it is used
in the test suite) is correct if no symlinks are involved, but breaks in
the face of symlinks.

2. The proposed patch is a mistake because it masks the brokenness of
setup_git_directory_gently_1().

3. The old commit 1bd9c648 is an even bigger mistake because it might
mask other breakages throughout git in dealing with working directories
that contain symlinks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
