From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git gc removes all packs
Date: Tue, 17 Feb 2015 23:19:55 +0100
Message-ID: <54E3BE8B.2040403@alum.mit.edu>
References: <CAC+L6n1M7LtGaJy94fnhXm94zJ32HXLNVGMguWSqHm=qqLLDxA@mail.gmail.com>	<20150205200332.GD15326@peff.net> <54E36EBF.2070600@alum.mit.edu>	<20150217165514.GA12176@peff.net> <54E3A695.1050708@alum.mit.edu> <xmqq7fvg19se.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	Dmitry Neverov <dmitry.neverov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 23:20:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNqUy-00038U-E2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 23:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbBQWUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 17:20:00 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43852 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273AbbBQWT7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 17:19:59 -0500
X-AuditID: 1207440d-f79976d000005643-b9-54e3be8d55ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5D.A8.22083.D8EB3E45; Tue, 17 Feb 2015 17:19:57 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HMJtNP016629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 17:19:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqq7fvg19se.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqNu773GIwZR+Y4vec5+YLbqudDNZ
	NPReYbb40dLD7MDisXPWXXaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y8774IJb
	/BVrmlewNDAe5Oli5OSQEDCRWPHrIxuELSZx4d56IJuLQ0jgMqNE68v/7BDOOSaJpsuPgTIc
	HLwC2hLfu8VBGlgEVCXaTs1iBrHZBHQlFvU0M4HYogJBEodOP2YBsXkFBCVOznwCZosIqElM
	bDvEAjKGWSBNYvPFKJCwMNCYxdcXskKsamaS2NqxC2wOp4C1xLVt28BsZgE9iR3Xf7FC2PIS
	zVtnM09gFJiFZMUsJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrpJebWaKXmlK6
	iRESzLw7GP+vkznEKMDBqMTDazHhUYgQa2JZcWXuIUZJDiYlUd43ux6HCPEl5adUZiQWZ8QX
	leakFh9ilOBgVhLh3QOS401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ
	8JbuBWoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB8VpfDEwUkFSPEB7T4K08xYX
	JOYCRSFaTzEqSonzpoAkBEASGaV5cGNhKeoVozjQl8K8oSBVPMD0Btf9CmgwE9Dg+X8egQwu
	SURISTUwxssWCEcsXflonaDr9vaQyYIvZrhOPnrD6Nb3yxWqP7ZyG7S+3XZM43j2lT93kqwY
	3s2XS3s0+5jfZD79N4yGnm0RU4wOpumwdhSftk4pPLiJVTsr+eVbk5eW9p2eKty7 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263992>

On 02/17/2015 10:57 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 02/17/2015 05:55 PM, Jeff King wrote:
>>> On Tue, Feb 17, 2015 at 05:39:27PM +0100, Michael Haggerty wrote:
>>>
>>>> There's a bunch of code in refs.c that is there explicitly for reading
>>>> loose references that are symlinks. If the link contents literally start
>>>> with "refs/", then they are read and treated as a symbolic ref.
>>>> Otherwise, the symlink is just followed.
>>> ...
>> Yes, this makes sense too. But my point was that sticking symlinks to
>> random files in your refs hierarchy is pretty questionable even *before*
>> the symlink gets broken. If we would warn the user as soon as we saw
>> such a thing, then the user's problem would never have advanced as far
>> as it did. Do you think that emitting warnings on *intact* symlinks is
>> too draconian?
> 
> Do you mean that we would end up reading refs/heads/hold if the user
> did this:
> 
>     git rev-parse --verify HEAD -- >precious
>     ln -s ../../../precious .git/refs/heads/hold
> 
> because that symbolic link does not begin with "refs/",

Correct, you can do exactly that. The "hold" reference is resolvable and
listable using "for-each-ref". But if I try to update it, the contents
of the "precious" file are overwritten. On the other hand, if I run
"pack-refs", then the current value of the "hold" reference is moved to
"packed-refs" and the symlink is removed. This behavior is not sane.

> and is an
> accident waiting to happen so we should forbid it in the longer
> term and warning when we see it would be the first step?

Yes, I am proposing that approach, though if somebody can suggest a use
case I'm willing to be convinced otherwise. The only thing I can imagine
symlinks being useful for might be to temporarily create a fake repo,
run one or two specific known-safe commands, then delete the repo again.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
