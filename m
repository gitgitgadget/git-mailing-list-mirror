From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: release-notes could be clearer on git-fetch changes
Date: Thu, 20 Feb 2014 12:06:17 +0100
Message-ID: <5305E1A9.1050203@alum.mit.edu>
References: <alpine.LSU.2.11.1402191952070.31131@nerf08.vanv.qr> <xmqqtxbu98ie.fsf@gitster.dls.corp.google.com> <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Thu Feb 20 12:06:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGRSV-0003Gp-I0
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 12:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbaBTLGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 06:06:23 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42227 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751353AbaBTLGW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Feb 2014 06:06:22 -0500
X-AuditID: 12074413-f79076d000002d17-9a-5305e1ad478c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 45.02.11543.DA1E5035; Thu, 20 Feb 2014 06:06:21 -0500 (EST)
Received: from [192.168.69.148] (p4FDD4415.dip0.t-ipconnect.de [79.221.68.21])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1KB6Hgh014387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 20 Feb 2014 06:06:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <alpine.LSU.2.11.1402192356480.1491@nerf08.vanv.qr>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqLv2IWuwwa1nwhZdV7qZLBp6rzBb
	NL18y+TA7LHx2XMWj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7oerCDtWCbYMW+PzuZGhif
	8nYxcnJICJhIHHn+lxHCFpO4cG89G4gtJHCZUeLDXtYuRi4g+xyTxJnFL8ASvALaEgv6ZwAl
	ODhYBFQlbh2QBQmzCehKLOppZgKxRQWCJVZffsACUS4ocXLmEzBbREBF4szfp2BjmAWsJVa8
	PgxWLyzgIHHl8xt2iF2LGSWOH+hkB0lwAiW6Gs6xgeySEBCX6GkMgujVkXjX94AZwpaX2P52
	DvMERsFZSNbNQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW65nq5mSV6qSmlmxgh
	AS28g3HXSblDjAIcjEo8vAxXWYKFWBPLiitzDzFKcjApifIy3mMNFuJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCu+0mUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMH7
	7gFQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwofuOLgREMkuIB2mv6EGRvcUFi
	LlAUovUUoy7H7bZfnxiFWPLy81KlxHkvgewQACnKKM2DWwFLX68YxYE+FublBBnFA0x9cJNe
	AS1hAlpSshFsSUkiQkqqgdFPZev8oun8L01SrmiV+U312KD5xP9JddeTLcKhK42bj+x65H9m
	8sHKO0uNi7kf9WU+z34jcvTjP953B8ydK86ktbu177qWMztDiatQqXjHaZ7ey+fO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242429>

On 02/19/2014 11:58 PM, Jan Engelhardt wrote:
> On Wednesday 2014-02-19 21:01, Junio C Hamano wrote:
>> Jan Engelhardt <jengelh@inai.de> writes:
>>> The release notes for 1.9.0 read:
>>>
>>>> * The "--tags" option to "git fetch" no longer tells the command to
>>>>   fetch _only_ the tags. It instead fetches tags _in addition to_
>>>>   what are fetched by the same command line without the option.
>>>
>>> I think the release notes should also say -- like it was done
>>> extensively for git add -- how to get back the old
>>> behavior (perhaps through now-different commands).
>>
>> Perhaps, but the release note is not a place to repeat what the
>> documentation already teaches---it primarily is to enumerate the
>> changed areas, to highlight the things users may want to look up in the
>> documentation, to give them a starting point.
>>
>> You would do something like this, I would think:
>>
>> 	git fetch $there 'refs/tags/*:refs/tags/*'
> 
> Looking at it from one more angle, `git fetch r --tags` and
> `git push r --tags` is now no longer symmetric :(

I'm glad you brought this up, because I didn't really think about
whether "git push" would need changes parallel to those in "git fetch".

I use "git push" in very conservative ways, so I don't know its ins and
outs.  What scenarios do you find asymmetric?  Were they more symmetric
before?

Perhaps you don't like that when some branch is configured for pushing
via remote.$remote.push, so that

    git push $remote

would push something, then you would expect

    git push --tags $remote

to push the same something *plus* the tags.  But I'm not sure that is
desirable.  Pushing is a lot more traumatic than fetching, because any
mistakes are obvious to all of your collaborators.  So I think it is OK
that the command is more reticent about pushing things that were
specified implicitly.

One thing I personally don't like is that

    git push $remote --all --tags

is not allowed.  I would expect it to push all branches and all tags.
But at least it just emits an error rather than doing something unexpected.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
