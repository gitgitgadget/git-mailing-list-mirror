From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 18:35:03 +0200
Message-ID: <502D2137.9000504@alum.mit.edu>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org> <877gt16ewe.fsf@thomas.inf.ethz.ch> <7vzk5x8s1q.fsf@alter.siamese.dyndns.org> <87sjbpa5m8.fsf@thomas.inf.ethz.ch> <7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org> <CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com> <7vipcj2w9f.fsf@alter.siamese.dyndns.org> <7vehn72vyl.fsf@alter.siamese.dyndns.org> <87pq6rw77l.fsf@thomas.inf.ethz.ch> <502CC4E7.5060508@alum.mit.edu> <87k3wzujuy.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:35:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T232W-0004HT-9X
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933078Ab2HPQfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:35:11 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:52489 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932996Ab2HPQfH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2012 12:35:07 -0400
X-AuditID: 12074414-b7f846d0000008b8-95-502d213a3eed
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.63.02232.A312D205; Thu, 16 Aug 2012 12:35:06 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7GGZ45M014643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 16 Aug 2012 12:35:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <87k3wzujuy.fsf@thomas.inf.ethz.ch>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqGulqBtg0L9Sy6LrSjeTRUPvFWaL
	CfcbmC1W7lrI5MDisXPWXXaPi5eUPeZ+WsTq8XmTXABLFLdNUmJJWXBmep6+XQJ3RuPia4wF
	U4Qr9s2Zx9LAeJKvi5GDQ0LAROL98sIuRk4gU0ziwr31bF2MXBxCApcZJc693MgK4Rxnkpj/
	9hULSBWvgLZE77OTrCA2i4CqxMOHC9hBbDYBXYlFPc1MILaoQIjEmm9TGCHqBSVOznwC1isi
	oC7xcV0rE8hQZoE2RonehavAGoQF3CXOvz3GArHtKrPE7DeNzCAJTgEDiatHLjKBnMosYC3x
	bXcRSJhZQF5i+9s5zBMYBWYh2TELoWoWkqoFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3Qt
	9HIzS/RSU0o3MULCWWQH45GTcocYBTgYlXh4PR5qBwixJpYVV+YeYpTkYFIS5d0ppBsgxJeU
	n1KZkVicEV9UmpNafIhRgoNZSYT3qixQjjclsbIqtSgfJiXNwaIkzvttsbqfkEB6Yklqdmpq
	QWoRTFaGg0NJgneJAlCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChS44uBsQqS
	4gHauxqknbe4IDEXKArReorRmOP/yZN3GTk+PwWSQix5+XmpUuK8fSClAiClGaV5cItgiewV
	ozjQ38K8m0GqeIBJEG7eK6BVTECrVoqArSpJREhJNTAyRjNd1NwQu9bxJUMn29uKBvGjd5f+
	LfouMM3O4d9Hv5v/ndiz55wNOar6o9d89xm+rfX7pnxzOP3uvezVPNHX96885mU8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/16/2012 02:00 PM, Thomas Rast wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> On 08/16/2012 10:51 AM, Thomas Rast wrote:
>>> I suppose the real problem is that the "true" ordering
>>> is completely obvious as the one ordering that does not require
>>> preprocessing, but ugly to specify in words.  Perhaps we can bikeshed a
>>> little?  How about
>>>
>>>     By default, commits are shown in an order that coincides with
>>>     `--date-order` on well-behaved history, but is faster to compute.
>>
>> Maybe the problem is not the description of the options, but the
>> options themselves.  Why does the behavior default to some mysterious
>> order that we don't even want to document?  Only for the sake of
>> computational efficiency.  This is the tail wagging the dog.
>>
>> Why not turn the behavior on its head:
>>
>> * Change the default behavior to be something well-defined, easy to
>> document, and convenient for humans, such as "topological order with
>> ties broken by timestamp" or "approximate timestamp order, but
>> respecting dependencies".
>>
>> * Add a new option, --arbitrary-order, that explicitly chooses
>> efficiency instead of a defined order.
>
> I think that would be a rather bad decision, largely because (taking my
> git.git as an example):
>
>    $ time git log | head -1
>    commit e5e6172f9060c958e3f0d679cd7049d4007eed2c
>
>    real    0m0.033s
>    user    0m0.026s
>    sys     0m0.007s
>
>    $ time git log --date-order | head -1
>    commit e5e6172f9060c958e3f0d679cd7049d4007eed2c
>
>    real    0m0.429s
>    user    0m0.359s
>    sys     0m0.031s
>
> That is, even in medium-sized projects like git.git, any -order option
> incurs a significant preprocessing time until git-log can show the first
> commit.  It scales linearly with the number of commits in the range, and
> in a linux.git lying around here is already around 3.9s for the same
> command.

Thanks for timing this; I didn't realize how costly this would be.  Just 
to make it even more obvious that this performance regression would bite 
in daily life, consider

     $ time git log -1

     real    0m0.013s
     user    0m0.000s
     sys     0m0.004s

     $ time git log -1 --topo-order

     real    0m0.334s
     user    0m0.316s
     sys     0m0.012s

Ouch.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
