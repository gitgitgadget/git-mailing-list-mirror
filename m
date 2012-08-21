From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] test: some testcases failed if cwd is on a symlink
Date: Tue, 21 Aug 2012 07:59:33 +0200
Message-ID: <503323C5.9050500@alum.mit.edu>
References: <001c60538df409d94618e80cc3faaae586ccf053.1343116581.git.worldhello.net@gmail.com> <7vboj5gqqo.fsf@alter.siamese.dyndns.org> <loom.20120818T162226-852@post.gmane.org> <7vfw7krl8r.fsf@alter.siamese.dyndns.org> <5030F0BF.2090500@alum.mit.edu> <7vharyq1c6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3hby-0002wu-MV
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab2HUGGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:06:42 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:49713 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752784Ab2HUGGk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 02:06:40 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2012 02:06:39 EDT
X-AuditID: 1207440c-b7f616d00000270b-0e-503323c9d795
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 80.C2.09995.9C323305; Tue, 21 Aug 2012 01:59:37 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F8F.dip.t-dialin.net [87.162.95.143])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7L5xYXQ006631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Aug 2012 01:59:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <7vharyq1c6.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHtS2TjAYMEVOYuuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7Y++25IIFQhWTu7QaGJ/xdTFyckgImEg8+bed
	GcIWk7hwbz1bFyMXh5DAZUaJk7+vMEE4Z5gk1k7sZO9i5ODgFdCW2PcjGKSBRUBVornxHyuI
	zSagK7Gop5kJxBYVCJFY820KI4jNKyAocXLmExYQW0RATWJi2yEWkDHMAuIS/f/AwsIC7hJ3
	n35ihFi1jEli6csnYHM4Bcwk/p75ywZiMwvoSLzre8AMYctLbH87h3kCo8AsJCtmISmbhaRs
	ASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYyQEOXZwfhtncwhRgEORiUe
	3hdTjAKEWBPLiitzDzFKcjApifJekDMOEOJLyk+pzEgszogvKs1JLT7EKMHBrCTC28gAlONN
	SaysSi3Kh0lJc7AoifOqLlH3ExJITyxJzU5NLUgtgsnKcHAoSfDyA2NRSLAoNT21Ii0zpwQh
	zcTBCTKcS0qkODUvJbUosbQkIx4UpfHFwDgFSfEA7X2vBLK3uCAxFygK0XqKUZfj89OTdxmF
	WPLy81KlxHmfghQJgBRllObBrYAlpFeM4kAfC/MqgFzCA0xmcJNeAS1hAlryaK4ByJKSRISU
	VANjqvHCdbcmNmS6v0mSUzjqbTF3dof3rS1tP0N/nrnwfPvl818OZs5SODTx42/RSG37h0pf
	OqKjbL9ulk84/nL6quY7emaMb5ce8feSU4vb9ienUsT2oO/hD1nJu3at7rBVz7OY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203938>

On 08/19/2012 06:43 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I just verified that the combination of your two suggestions (i.e., the
>> patch below) fixes the problem for me.
> 
> Good to know.
> 
> The only remaining two worries from me are if everybody has working
> pwd at that early point in the script (I think MINGW replaces pwd
> with its own), and if the latter one should really be "/bin/pwd"
> everywhere.  Saying "Give the true path to --root when you run it"
> can sidestep the latter issue ;-)
> 
>> Nevertheless, I'm not sure that this is the best solution.  The test
>> failures that occur without this change suggest to me that
>> GIT_CEILING_DIRECTORIES is implemented in a fragile way.
> 
> Hrmph.  How would you improve it?  chdir() around twice and compare?

I believe that the old-school method is to stat(2) the two directories
and check whether their device IDs and inode numbers are identical.  But
I don't know whether that is portable to other allegedly
POSIX-compatible OSs, or even works with all modern filesystems (I think
there was just a thread about a FUSE filesystem that sometimes changes
inode numbers).

Another alternative is to write a function that knows how to convert an
arbitrary path into an absolute path, including converting relative
paths to absolute, resolving symlinks, eliminating redundant "/" and
".", resolving "..", and perhaps canonicalizing "/" vs. "\" and
who-knows-what-else on Windows.  It takes a bit of care to implement
this correctly, but it might be a useful function to have around.
Python's library function os.path.realpath() is an example [1].

Either approach would avoid chdir()ing around even temporarily, which
would anyway be bad form in git proper (as opposed to the test suite).
And it would avoid the need to chdir() permanently in the test suite,
which can have the effect of making directory names appear in unfamiliar
forms.

I'm afraid I don't have time to work on this now; I'm still trying to
finish the next iteration of the post-receive-email hook script replacement.

Michael

[1] (Python) source code here:

    http://hg.python.org/cpython/file/20985f52b65e/Lib/posixfile.py

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
