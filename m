From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch 04/33
Date: Thu, 31 Mar 2016 18:14:03 +0200
Message-ID: <56FD4CCB.1000205@alum.mit.edu>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
 <1459282370.2976.7.camel@twopensource.com> <56FB743C.3020902@alum.mit.edu>
 <1459368315.2976.27.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 18:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alfLb-0006LZ-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 18:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384AbcCaQVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 12:21:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63692 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757253AbcCaQVK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2016 12:21:10 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2016 12:21:10 EDT
X-AuditID: 12074413-473ff700000008c7-d4-56fd4cce0f85
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 5A.64.02247.ECC4DF65; Thu, 31 Mar 2016 12:14:06 -0400 (EDT)
Received: from [192.168.69.130] (p548D6127.dip0.t-ipconnect.de [84.141.97.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u2VGE30U026339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 31 Mar 2016 12:14:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1459368315.2976.27.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqHvO52+Ywe1zshbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWjuweeycdZfd41nvHkaPi5eUPfYv3cbmseD5fXaPz5vkAtii
	uG2SEkvKgjPT8/TtErgzXh+8w1xwX7LiyL8t7A2Mu0S6GDk5JARMJI5MmsvYxcjFISSwlVHi
	+r1fLBDOOSaJ228bWUGqhAX8JJ6/f84MYosIREgsmbyPFaKogUniRPsvdpAEs0CexKeli8GK
	2AR0JRb1NDOB2LwC2hI/dxxhBLFZBFQlJt1+B2aLCoRIbFv3jRWiRlDi5MwnLCA2p4CFxLu5
	G1khZqpL/Jl3iRnClpfY/nYO8wRG/llIWmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTE
	vLzUIl1zvdzMEr3UlNJNjJAAF97BuOuk3CFGAQ5GJR7eC8l/woRYE8uKK3MPMUpyMCmJ8l72
	+hsmxJeUn1KZkVicEV9UmpNafIhRgoNZSYRX3xsox5uSWFmVWpQPk5LmYFES51Vbou4nJJCe
	WJKanZpakFoEk5Xh4FCS4E0FaRQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWV8
	MTAuQVI8QHsrwPYWFyTmAkUhWk8xKkqJ834COVYAJJFRmgc3Fpa2XjGKA30pzLsWpJ0HmPLg
	ul8BDWYCGrxV4xfI4JJEhJRUA6O2TLP2zoalyh5/Vc7PMWEzC+26W7XDkffAPYWtoqlv24yE
	Xy2IueJz9if/V6mVusXX7ofw1U/ebaX+4rzuj7Pi8TMqJoruZGvKuCG88bx7Ucru 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290410>

On 03/30/2016 10:05 PM, David Turner wrote:
> On Wed, 2016-03-30 at 08:37 +0200, Michael Haggerty wrote:
>> On 03/29/2016 10:12 PM, David Turner wrote:
>>> On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
>>>> On 03/24/2016 07:47 AM, David Turner wrote:
>>>>> [...]
>>>>> I incorporated your changes into the lmdb backend.  To make
>>>>> merging
>>>>> later more convenient, I rebased on top of pu -- I think this
>>>>> mainly
>>>>> depends on jk/check-repository-format, but I also included some
>>>>> fixes
>>>>> for a couple of tests that had been changed by other patches.
>>>>
>>>> I think rebasing changes on top of pu is counterproductive. I
>>>> believe
>>>> that Junio had extra work rebasing your earlier series onto a
>>>> merge
>>>> of
>>>> the minimum number of topics that it really depended on. There is
>>>> no
>>>> way
>>>> that he could merge the branch in this form because it would
>>>> imply
>>>> merging all of pu.
>>>>
>>>> See the zeroth section of SubmittingPatches [1] for the
>>>> guidelines.
>>>
>>> I'm a bit confused because 
>>> [PATCH 18/21] get_default_remote(): remove unneeded flag variable
>>>
>>> doesn't do anything on master -- it depends on some patch in pu. 
>>>  And
>>> we definitely want to pick up jk/check-repository-format (which
>>> doesn't
>>> include whatever 18/21 depends on).
>>>
>>> So what do you think our base should be?
>>
>> I think the preference is to base a patch series on the merge of
>> master
>> plus the minimum number of topics in pu (ideally, none) that are
>> "essential" prerequisites of the changes in the patch series. For
>> example, the version of this patch series that Junio has in his tree
>> was
>> based on master + sb/submodule-parallel-update. 
>>
>> Even if there are minor
>> conflicts with another in-flight topic, it is easier for Junio to
>> resolve the conflicts when merging the topics together than to rebase
>> the patch series over and over as the other patch series evolves. The
>> goal of this practice is of course to allow patch series to evolve
>> independently of each other as much as possible.
>>
>> Of course if you have insights into nontrivial conflicts between your
>> patch series and others, it would be helpful to discuss these in your
>> cover letter.
> 
> If I am reading this correctly, it looks like your series also has a
> few more sb submodule patches, e.g. sb/submodule-init, which is
> responsible for the code that 18/21 depends on.  
> 
> I think jk/check-repository-format is also  good to get in first,
> because it changes the startup sequence a bit and it's a bit tricky to
> figure out what needs to change in dt/refs-backend-lmdb as a result of
> it. 
> 
> But I can't just merge jk/check-repository-format on top of 71defe0047 
> -- some function signatures have changed in the run-command stuff and
> it seems kind of annoying to fix up.  
> 
> So I propose instead that we just drop 18/21 for now, and use just
> jk/check-repository-format as the base.
> 
> Does this seem reasonable to you?

Yes, that's fine. Patch 18/21 is just a random cleanup that nothing else
depends on. Will you do the rebasing? If so, please let me know where I
can fetch the result from.

Michael
