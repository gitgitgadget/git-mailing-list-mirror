From: David Gould <david@optimisefitness.com>
Subject: Re: Probable bug in file run-command.c function clear_child_for_cleanup
Date: Tue, 11 Sep 2012 09:40:51 +0100
Message-ID: <504EF913.2050202@optimisefitness.com>
References: <504CAB66.1050003@optimisefitness.com> <20120910134406.GA7496@sigill.intra.peff.net> <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com> <20120910141027.GA8284@sigill.intra.peff.net> <7v8vchodgc.fsf@alter.siamese.dyndns.org> <20120910200110.GA32437@sigill.intra.peff.net> <7v4nn5ocvv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 10:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBM1r-0006fO-FA
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 10:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238Ab2IKIk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 04:40:57 -0400
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:10053
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750898Ab2IKIkz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 04:40:55 -0400
X-Trace: 613150833/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$ON_NET_AUTH_ACCEPTED/pipex-temporary-group/88.108.247.46/None/david@optimisefitness.com
X-SBRS: None
X-RemoteIP: 88.108.247.46
X-IP-MAIL-FROM: david@optimisefitness.com
X-SMTP-AUTH: 
X-Originating-Country: GB/UNITED KINGDOM
X-MUA: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAE/4TlBYbPcu/2dsb2JhbABFu06BCIIgAQEFOBENIgEQCAMYCRYPCQMCAQIBJx4GDQEFAgEBFYd7vBqLEIYmA5spE4NUhmqCZw
X-IronPort-AV: E=Sophos;i="4.80,403,1344207600"; 
   d="scan'208";a="613150833"
X-IP-Direction: IN
Received: from 88-108-247-46.dynamic.dsl.as9105.com (HELO ephebe) ([88.108.247.46])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Sep 2012 09:40:52 +0100
Received: from [192.168.100.9] (pseudopolis [192.168.100.9])
	by ephebe (Postfix) with ESMTPS id 64B4D800EC;
	Tue, 11 Sep 2012 09:40:52 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v4nn5ocvv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205209>

Hi guys,

Sorry for the delayed reply - what passes for my real life intruded 
somewhat.

I'll get on to it today, but please be aware this will be my first-ever 
patch for ANY project, so am likely to foul up the process.

I am reading the How To Submit Patches document even now....

Cheers,
David

On 10/09/12 21:12, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Mon, Sep 10, 2012 at 01:00:35PM -0700, Junio C Hamano wrote:
>>
>>>>> And to conclude my bikeshedding for the day: Shouldn't "last" ideally
>>>>> be called something like "prev" instead? It's the previously visited
>>>>> element, not the last element in the list.
>>>>
>>>> It is the "last" element visited (just as "last week" is not the end of
>>>> the world), but yes, it is ambiguous, and "prev" is not. Either is fine
>>>> by me.
>>>
>>> OK, so who's gonna do the honors?
>>
>> I was hoping to give David a chance to submit his first-ever patch to
>> git.
>
> OK. David, is it OK for us to expect a patch from you sometime not
> in distant future (it is an old bug we survived for a long time and
> nothing ultra-urgent)?
>

-- 
David Gould, Personal Trainer
	Register of Kettlebell Professionals
	INWA Nordic Walking Instructor
Optimise Fitness Ltd -- fit for life
01264 720709
www.optimisefitness.com
