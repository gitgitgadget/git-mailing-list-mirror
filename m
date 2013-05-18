From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Fwd: Fwd: git cvsimport implications
Date: Sat, 18 May 2013 07:52:03 +0200
Message-ID: <51971703.5070700@alum.mit.edu>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com> <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com> <7vfvxpfbli.fsf@alter.siamese.dyndns.org> <51932A1A.4050606@alum.mit.edu> <CAPZPVFZTZFQrCF3gcwcff5LFm9MHhZm-DauLvfzCYrMTw4nQfA@mail.gmail.com> <5195F3EB.8000308@alum.mit.edu> <CAPZPVFZ6HjFYaPOqcrwhCCdGhYUaVEjyDeaL8dcsqy1ghcfWpg@mail.gmail.com> <CAPZPVFbkcmBH7OPeP83gPnSGodoi_9diAUk-5dtR43dCDRfkwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 18 07:52:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uda4A-00084u-3b
	for gcvg-git-2@plane.gmane.org; Sat, 18 May 2013 07:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449Ab3ERFwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 01:52:09 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:46393 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750752Ab3ERFwH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 May 2013 01:52:07 -0400
X-AuditID: 1207440f-b7f0e6d000000957-66-519717077c3f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 42.E6.02391.70717915; Sat, 18 May 2013 01:52:07 -0400 (EDT)
Received: from [192.168.69.140] (p57A24D63.dip0.t-ipconnect.de [87.162.77.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4I5q45U006533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 18 May 2013 01:52:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAPZPVFbkcmBH7OPeP83gPnSGodoi_9diAUk-5dtR43dCDRfkwQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqMsuPj3Q4OMjdosNc++yWHRd6WZy
	YPLYOesuu8fnTXIBTFHcNkmJJWXBmel5+nYJ3BkH/p9gLdgmVDFp5VPWBsYrfF2MnBwSAiYS
	vTvms0PYYhIX7q1n62Lk4hASuMwocerYHXYI5xyTxN3/PcxdjBwcvALaEp/aZEAaWARUJZrX
	nWMFsdkEdCUW9TQzgdiiAmESq9YvYwaxeQUEJU7OfMICYosA1S8/eoEdZAyzgLhE/z+wsLCA
	ocTpeTdZoFYxS7zc1w82k1MgUGJZ610WiHp1ifXzhEDCzALyEtvfzmGewCgwC8mGWQhVs5BU
	LWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6KXm1mil5pSuokREqT8Oxi71sscYhTgYFTi
	4f3gOi1QiDWxrLgy9xCjJAeTkiivPef0QCG+pPyUyozE4oz4otKc1OJDjBIczEoivM+Lgcp5
	UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8HWJAQwWLUtNTK9Iyc0oQ
	0kwcnCDDuaREilPzUlKLEktLMuJBURpfDIxTkBQP0N56kHbe4oLEXKAoROspRl2OGT8mv2MU
	YsnLz0uVEuftBCkSACnKKM2DWwFLSa8YxYE+FuatAaniAaYzuEmvgJYwAS1hvTYVZElJIkJK
	qoFRauqpyt6rBl+v+gr7ljyart1hGhRw635nTOtrpbt2fp1dl+LP/PXMtlL9WHbJPFJQeluU
	7dnaVI55M/RyLr1aH3rYIGHOx3vnO/UuNqi+c1gcL6a4MWtK0gWWlUqmnPnyf1kl 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224771>

On 05/17/2013 06:10 PM, Eugene Sajine wrote:
> MIchael, sorry for dup - didn't press reply all for the first one.
> 
>>
>> So what are you going to do, use cvsimport whenever you cannot *prove*
>> that it is wrong?  You sure have low standards for your software.
> 
> 1. You are making assumptions and conclusions that have no grounds.
> I asked for help understanding what are the problems of cvsimport.
> Never i said i'm not willing use cvs2git. Never i said I'm happy to have
> problems in my git repos. So, this "low standard" punch was... not necessary.

I didn't mean to be offensive.  I meant it more in the sense of "you
deserve to expect more from your software".

> 2. I started to use cvsimport because it was the tool *provided with
> git* about three years ago.
> By that time i didn't find any better and simpler tool to use and
> those implications were uknown for me,
> they were brought up to my attention just recently.
> CVS is not good for branches, so most of our projects didn't have any
> cvs branches.
> So for majority of those it seems that the cvsimport did it's job just fine.
> Now we are going to try to migrate some projects that are using CVS
> branches heavily.
> That concerns me, so i'm looking for better tool.

The Git test suite (tests t/t960?-*.sh) demonstrates some of the known
problems with cvsimport, and those failures are summarized in the
manpage for git-cvsimport(1).  Not all of the problems are related to
branches and tags.  There might be more problems; I simply documented a
few that I found relatively quickly then I stopped looking.

> 3. Is there a way to have the whole plumbing with the
> blobfiles and dumpfiles and consequent git fast-import wrapped into
> nice command like:
> 
> git cvsimport -C path/to/my/new/shiny/gitrepo
> 
> Or are there any particular reasons why end user must deal with blob
> and dump files and do fast-import afterwards?

There are benefits to the split blobfile/dumpfile approach for some
users, so I wouldn't want to get rid of that possibility.  But there's
no reason I wouldn't accept a patch that provides an option to convert
as you describe.  Alternately, it would take only a few lines of script
to automate it yourself.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
