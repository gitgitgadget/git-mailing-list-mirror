From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Sun, 1 Sep 2013 21:11:24 +0100
Organization: OPDS
Message-ID: <29D8721CD44F4C3180D6F1BA5CDCF38E@PhilipOakley>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org><20130831191215.26699.720.chriscool@tuxfamily.org><70F5C527E29F43A9BE85694F560E01A9@PhilipOakley> <20130901.134900.829124962244710553.chriscool@tuxfamily.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <gitster@pobox.com>, "Git List" <git@vger.kernel.org>,
	<trast@inf.ethz.ch>, <j6t@kdbg.org>
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 01 22:11:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGDzJ-0002qi-L1
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753284Ab3IAULF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 16:11:05 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:9962 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168Ab3IAULE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Sep 2013 16:11:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AoAMAHWeI1JOl3GZ/2dsb2JhbABagwc1iTa3fgQEAYEdF3RoAQGBHwEBFAEEAQEEAQgBAS4eAQEhCwIDBQIBAw4HDCUUAQQaBgcXBhMIAgECAwGFOAcBghIZCrkej3+DJIEAA4h9hhKKFYsLhSyBOimBPjs
X-IPAS-Result: AoAMAHWeI1JOl3GZ/2dsb2JhbABagwc1iTa3fgQEAYEdF3RoAQGBHwEBFAEEAQEEAQgBAS4eAQEhCwIDBQIBAw4HDCUUAQQaBgcXBhMIAgECAwGFOAcBghIZCrkej3+DJIEAA4h9hhKKFYsLhSyBOimBPjs
X-IronPort-AV: E=Sophos;i="4.89,1003,1367967600"; 
   d="scan'208";a="421590859"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 01 Sep 2013 21:10:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233594>

From: "Christian Couder" <chriscool@tuxfamily.org>
> From: "Philip Oakley" <philipoakley@iee.org>
>>
>> From: "Christian Couder" <chriscool@tuxfamily.org>
>>>
>>> The replaced object and the replacement object must be of the same
>>> type.
>>> -There is no other restriction on them.
>>> +This restriction can be bypassed using `-f`.
>>>
>>> Unless `-f` is given, the 'replace' reference must not yet exist.
>>>
>>> +There is no other restriction on the replaced and replacement
>>> objects.
>>
>> Is this trying to allude to the fact that merge commits may be
>> exchanged with non-merge commits? I strongly believe that this
>> ability
>> to exchange merge and non-merge commits should be stated _explicitly_
>> to counteract the false beliefs that are listed out on the internet.
>
> Maybe we can show that in an example. But I think the patch is quite
> clear as it is and should be enough.
>
> If we really want to correct some false beliefs, the best would be to
> state the truth where those false beliefs are stated.
>
I've added a sub-comment to the original SO post that started this
thread (my post $gmane/231598 - SO/a/18027030/717355), but given the
guy's blog has comments going back to 2009 I suspect its a bit of a
http://xkcd.com/386/ task, hence my desire that it's explicitly
mentioned in the 'replace' documentation. In addition, if the guy 
doesn't correct his post I'll mark it down in a couple of days to make 
it plain to other readers it's in error.

The creation of a (merge?) commit that's equivalent to a graft line
isn't something that jumps out (to me) as an easy couple lines of bash
script.

A 'graft2replace' script (or 'git-graft' command) which takes an
existing graft file (or command line list) and creates the replacement 
objects and then does the replace, all while still in a dirty tree would 
be the holy grail for properly deprecating grafts (which are sooo easy 
to create)

>> It's probably better stated in a separate patch for that explicit
>> purpose to avoid mixed messages within this commit.
>
> If people agree, I will add a another patch with an example in an
> EXAMPLE section.
>
> Thanks,
> Christian.
>
>
Thanks for your work on this.
Philip 
