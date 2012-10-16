From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: error: git-fast-import died of signal 11
Date: Tue, 16 Oct 2012 09:18:43 +0200
Message-ID: <507D0A53.1030707@alum.mit.edu>
References: <CAMJd5ATv5XfTK++4=Rs+RUkgb7F-ssrz2Lrch_WxvxZt+yF33A@mail.gmail.com> <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Uri Moszkowicz <uri@4refs.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO1QY-000051-VN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 09:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab2JPHSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 03:18:47 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:52805 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754244Ab2JPHSr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 03:18:47 -0400
X-AuditID: 1207440c-b7f616d00000270b-32-507d0a56df9a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.83.09995.65A0D705; Tue, 16 Oct 2012 03:18:46 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9G7IitI005718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 16 Oct 2012 03:18:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <CAMJd5AQ_vsQBGnMRrZUUqztjYjaHkU0_FOteNpEvE8NTrPPvQQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsUixO6iqBvGVRtgMOmDoEXXlW4mi/9nfrA5
	MHn0Hl/H7PF5k1wAUxS3TVJiSVlwZnqevl0Cd8ae7b9YCzbKVHzrf8vSwPhErIuRk0NCwETi
	0eujbBC2mMSFe+vBbCGBy4wSpyYKdDFyAdnHmSSufZkDluAV0Ja49PstE4jNIqAq8fXXWjCb
	TUBXYlFPM5gtKhAm8e7XUVaIekGJkzOfsIDYIgJKEusuXwGKc3AwC4hL9P8DCwsLmEr0XtjA
	DrFrKqPE0r5vYAlOgUCJ5df/g81hFtCReNf3gBnClpfY/nYO8wRGgVlIVsxCUjYLSdkCRuZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCGByrOD8ds6mUOMAhyMSjy8Gc41
	AUKsiWXFlbmHGCU5mJREeedz1AYI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuH1mAhUzpuSWFmV
	WpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4M3lBBoqWJSanlqRlplTgpBm4uAE
	Gc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2KoG08xYXJOYCRSFaTzHqcnxsnPeQUYglLz8v
	VUqcNwSkSACkKKM0D24FLC29YhQH+liYtxykigeY0uAmvQJawgS0pGt3NciSkkSElFQD49zL
	TtoCmtOXXX3td7br6v+Hj1itji84tNDt86d75w5+fPBKfvqnO4H1Ox3Sj/N4xTKcWvg9VuSS
	Md/SSMmzeYI/tyS9revoSl7Ks2b1isurXaRYorjKr7V3T51pJCO612//Tft77BzR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207807>

On 10/15/2012 05:53 PM, Uri Moszkowicz wrote:
> I'm trying to convert a CVS repository to Git using cvs2git. I was able to
> generate the dump file without problem but am unable to get Git to
> fast-import it. The dump file is 328GB and I ran git fast-import on a
> machine with 512GB of RAM.
> 
> fatal: Out of memory? mmap failed: Cannot allocate memory
> fast-import: dumping crash report to fast_import_crash_18192
> error: git-fast-import died of signal 11
> 
> How can I import the repository?

What versions of git and of cvs2git are you using?  If not the current
versions, please try with the current versions.

What is the nature of your repository (i.e., why is it so big)?  Does it
consist of extremely large files?  A very deep history?  Extremely many
branches/tags?  Extremely many files?

Did you check whether the RAM usage of git-fast-import process was
growing gradually to fill RAM while it was running vs. whether the usage
seemed reasonable until it suddenly crashed?

There are a few obvious possibilities:

0. There is some reason that too little of your computer's RAM is
available to git-fast-import (e.g., ulimit, other processes running at
the same time, much RAM being used as a ramdisk, etc).

1. Your import is simply too big for git-fast-import to hold in memory
the accumulated things that it has to remember.  I'm not familiar with
the internals of git-fast-import, but I believe that the main thing that
it has to keep in RAM is the list of "marks" (references to git objects
that can be referred to later in the import).  From your crash file, it
looks like there were about 350k marks loaded at the time of the crash.
 Supposing each mark is about 100 bytes, this would only amount to 35
Mb, which should not be a problem (*if* my assumptions are correct).

2. Your import contains a gigantic object which individually is so big
that it overflows some component of the import.  (I don't know whether
large objects are handled streamily; they might be read into memory at
some point.)  But since your computer had so much RAM this is hardly
imaginable.

3. git-fast-import has a memory leak and the accumulated memory leakage
is exhausting your RAM.

4. git-fast-import has some other kind of a bug.

5. The contents of the dumpfile are corrupt in a way that is triggering
the problem.  This could either be invalid input (e.g., an object that
is reported to be quaggabytes large), or some invalid input that
triggers a bug in git-fast-import.

If (1), then you either need a bigger machine or git-fast-import needs
architectural changes.

If (2), then you either need a bigger machine or git-fast-import and/or
git needs architectural changes.

If (3), then it would be good to get more information about the problem
so that the leak can be fixed.  If this is the case, it might be
possible to work around the problem by splitting the dumpfile into
several parts and loading them one after the other (outputting the marks
from one run and loading them into the next).

If (4) or (5), then it would be helpful to narrow down the problem.  It
might be possible to do so by following the instructions in the cvs2svn
FAQ [1] for systematically shrinking a test case to smaller size using
destroy_repository.py and shrink_test_case.py.  If you can create a
small repository that triggers the same problem, then there is a good
chance that it is easy to fix.

Michael
(the cvs2git maintainer)

[1] http://cvs2svn.tigris.org/faq.html#testcase

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
