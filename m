From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 3/4] refs: make refs/worktree/* per-worktree
Date: Fri, 14 Aug 2015 10:18:13 +0200
Message-ID: <55CDA445.9090503@alum.mit.edu>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>		 <1439416645-19173-3-git-send-email-dturner@twopensource.com>		 <CAPig+cRM-J-5SHJ9JVsHPR+B2Y05nwFrRQWsd0M56pm9jS-mTQ@mail.gmail.com>	 <1439487708.8855.2.camel@twopensource.com> <55CCFB32.30608@alum.mit.edu> <1439497946.8855.22.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>, Jacob Keller <jacob.keller@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 10:18:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQAC1-00071c-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 10:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbbHNISU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 04:18:20 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49620 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682AbbHNISR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Aug 2015 04:18:17 -0400
X-AuditID: 1207440c-f79e16d000002a6e-17-55cda4489b74
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.D0.10862.844ADC55; Fri, 14 Aug 2015 04:18:16 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97ECB.dip0.t-ipconnect.de [79.201.126.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7E8IDv6003949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 14 Aug 2015 04:18:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1439497946.8855.22.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsUixO6iqOux5GyowZ2XfBabnk9ktpi/6QSj
	RdeVbiaL3Yv7mS26p7xltDjzppHRgc1j56y77B6LH3h5LH/wit1jwfP77B6fN8kFsEZx2yQl
	lpQFZ6bn6dslcGdceyJfcEGw4vgLgwbG3bxdjJwcEgImEp8P3WKCsMUkLtxbz9bFyMUhJHCZ
	UeLthtPMEM4FJolJOy6zglTxCmhLXOiaxAxiswioSnQvncUCYrMJ6Eos6mkGmyQqECSxYvkL
	Roh6QYmTM5+A1YgA9c4+0sMKMpRZoI9J4sWXF2wgCWEBZ4njk+YzQWw7wiQx79JhsA5OAQuJ
	vR82s4PYzALqEn/mXWKGsOUlmrfOZp7AKDALyZJZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZ
	tzg5MS8vtUjXUC83s0QvNaV0EyMk3Hl2MH5bJ3OIUYCDUYmH90Hz2VAh1sSy4srcQ4ySHExK
	ory2i4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhv5AHleFMSK6tSi/JhUtIcLErivKpL1P2E
	BNITS1KzU1MLUotgsjIcHEoSvCcXATUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTE
	g2I1vhgYrSApHqC9giA38RYXJOYCRSFaTzEqSonzPgeZKwCSyCjNgxsLS2KvGMWBvhTmDQZp
	5wEmQLjuV0CDmYAG280AG1ySiJCSamBMf/Nq4sUwmf5T3+05rx8NcfDY8jM7891MM6ZEl9TD
	p9awML9q2n0wq9R+9tafx2YIeRXUn9vCeqjxW9hRsSr/0wEic2el5Sga/5V75vxc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275897>

On 08/13/2015 10:32 PM, David Turner wrote:
> On Thu, 2015-08-13 at 22:16 +0200, Michael Haggerty wrote:
>> On 08/13/2015 07:41 PM, David Turner wrote:
>>> On Thu, 2015-08-13 at 13:15 -0400, Eric Sunshine wrote:
>>>> On Wed, Aug 12, 2015 at 5:57 PM, David Turner <dturner@twopensource.com> wrote:
>>>>> diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
>>>>> index 93605f4..28e6dff 100755
>>>>> --- a/t/t0060-path-utils.sh
>>>>> +++ b/t/t0060-path-utils.sh
>>>>> +test_expect_success 'handle per-worktree refs in refs/worktree' '
>>>>> +       git commit --allow-empty -m "initial commit" &&
>>>>> +       git worktree add -b branch worktree &&
>>>>> +       (
>>>>> +               cd worktree &&
>>>>> +               git commit --allow-empty -m "test commit"  &&
>>>>> +               git for-each-ref | test_must_fail grep refs/worktree &&
>>>>
>>>> s/test_must_fail/!/
>>>>
>>>> From t/README:
>>>>
>>>>    On the other hand, don't use test_must_fail for running regular
>>>>    platform commands; just use '! cmd'.  We are not in the business
>>>>    of verifying that the world given to us sanely works.
>>>
>>> When I make that change, my test fails with:
>>>
>>> FATAL: Unexpected exit with code 2
>>>
>>> Apparently, you can't use ! in pipelines like that.  So that's why I
>>> used test_must_fail.
>>
>> You would have to negate the whole pipeline, like
>>
>>     ! git for-each-ref | grep refs/worktree
>>
>> The result of a pipeline is taken from the last command.
> 
> Yes, but that would pass if for-each-ref fails, which I do not want.  
> 
> Jacob's suggestion of parentheses around (! grep refs/worktree) seems to
> work.

I don't see how that can help. The result of a pipeline is taken from
the last command. The exit codes of earlier commands in the pipeline are
lost in the sands of time:

    $ false | true
    $ echo $?
    0
    $ false | ( ! false )
    $ echo $?
    0

Working around this POSIX shell limitation is surprisingly awkward in a
general-purpose script. But in this case you could use a temporary file:

    git for-each-ref >refs-actual &&
    ! grep refs/worktree <refs-actual && [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
