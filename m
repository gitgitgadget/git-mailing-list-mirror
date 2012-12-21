From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Change in cvsps maintainership, abd a --fast-export option
Date: Fri, 21 Dec 2012 23:16:29 +0100
Message-ID: <50D4DFBD.7080708@alum.mit.edu>
References: <20121220215638.E54BC44119@snark.thyrsus.com> <50D4199C.6000002@alum.mit.edu> <20121221104437.GA5244@thyrsus.com> <50D4B639.9000807@alum.mit.edu> <20121221214311.GA29147@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Dec 21 23:16:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmAte-0007NO-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 23:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab2LUWQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 17:16:33 -0500
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:57710 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751738Ab2LUWQc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2012 17:16:32 -0500
X-AuditID: 1207440e-b7f116d0000008ae-12-50d4dfbfe1bc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.F2.02222.FBFD4D05; Fri, 21 Dec 2012 17:16:31 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qBLMGTTL001874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 21 Dec 2012 17:16:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121221214311.GA29147@thyrsus.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqLv//pUAgwMNnBZXt/hYdF3pZnJg
	8lj2tZPF4/MmuQCmKG6bpMSSsuDM9Dx9uwTujJcbt7EX/BGo2NJ6iq2BcTJvFyMHh4SAicSW
	axJdjJxAppjEhXvr2boYuTiEBC4zSrz5NI0JwjnOJLF743c2kCpeAW2J/oULwGwWAVWJqxe2
	MYHYbAK6Eot6msFsUYEAicVLzrFD1AtKnJz5hAVkmYiAsMSxPjUQk1lAXKL/HwtIhbCAu8S2
	nfuYIVYdYpQ4cOsTWDmngKHEg9sGIDXMAjoS7/oeMEPY8hLb385hnsAoMAvJgllIymYhKVvA
	yLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyRE+XYwtq+XOcQowMGoxMN7
	qelKgBBrYllxZe4hRkkOJiVRXq9rQCG+pPyUyozE4oz4otKc1GKgizmYlUR4/ecB5XhTEiur
	UovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKEryL7gE1ChalpqdWpGXmlCCkmTg4
	QYZzSYkUp+alpBYllpZkxIOiNL4YGKcgKR6gvS0g7bzFBYm5QFGI1lOMxhwNL288ZeS41XDz
	KaMQS15+XqqUOK8OML0ICYCUZpTmwS2CJadXjOJAfwvzLgUZyANMbHDzXgGtYgJaJaIEtqok
	ESEl1cAoGb9Zq4D5i4zgo/zlyV56EryBGyZccA+5lPv9Ublo/MsVWVfuh9zISE9PdKk8u+7r
	G72/cmt3pIkczLjqeOHTo7XND+4YteUtTxaavauz+Wh70DnZ+TZ3lvm6uFpobFXu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212016>

On 12/21/2012 10:43 PM, Eric S. Raymond wrote:
> Michael Haggerty <mhagger@alum.mit.edu>:
>> Perhaps your experience is with an older version of cvs2svn? 
> 
> Well, it has been at least four years since I ran it on anything.
> Maybe that counts as old. 

cvs2svn version 2.0 (Aug 2007) totally changed how cvs2svn deduces
changesets.  Any results from before that are utterly irrelevant to
modern times.

The changes between version 2.0 and version 2.4 (Sep 2012) have done a
lot more to improve the quality of the conversion.  The state of the art
is far beyond what it was four years ago.

>>                                                             If not,
>> please be specific rather than just making complaints that are too vague
>> to be rebutted or fixed (whichever is appropriate).  I put a *lot* of
>> effort into getting cvs2svn to run correctly, and I take bug reports
>> very seriously.
> 
> I can't be specific now, but that may change shortly.  I'm putting
> together a test suite for cvsps with the specific intention of
> capturing as many odd corner cases as I can.  (I just finished writing
> a small Python framework for expressing interleaved CVS command
> sequences on multiple checkouts in a way that can be easily run.)
> 
> It wouldn't be difficult for me to test whether these break cvs2svn. 
> You've established that someone over there is paying attention, so
> I'll do that, I guess.

I look forward to your results (whether positive or negative).

> I'm willing to share my test suite as well.  Do you have your own zoo
> of odd cases I could test on?

Yes, we have a rather extensive test suite that includes lots of CVS
perversions.  See run-tests.py and the CVS repositories under test-data.
 Unfortunately, the tests mostly cover only 2svn conversions, but since
most of the tricky work is in the common code that infers the CVS
history, cvs2git benefits from the tests too.

This discussion is getting pretty cvs2svn-specific, so we should
probably move it over to the cvs2svn-dev mailing list.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
