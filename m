From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Wed, 19 Mar 2014 02:02:40 -0700
Message-ID: <53295D30.8090307@gmail.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>	<531D51EC.6050503@gmail.com>	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com>	<xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>	<53200C1A.7070002@gmail.com> <xmqq38innyjq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 10:02:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQCOl-0001pW-PH
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 10:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116AbaCSJCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 05:02:51 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35572 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757893AbaCSJCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 05:02:48 -0400
Received: by mail-pb0-f53.google.com with SMTP id rp16so8541441pbb.26
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OAzo85O+pPydQWDjau0DarNaInvuCcugt4f8xjyRZXU=;
        b=kVb1hXN8wTzW4wDdvUU0+IGM1K84vl+N3Ln9oohvtCalMH3m9HEzEVNGMRuA9pdD00
         Q6HRrVZ2olIsETO6bmt1PIbDvFm88XzqkwM5n6IdPub8Qro3fr3kR5tO5hrQdt3Aw9tc
         9GV6STnI6jElPp1szra/7rNCXiRpvjiAPxDyxnIKS3HfWG+vkhkDSRSHw3XbvbBOfBRk
         aC9oKQGJIqQqXF3nQjJ7DDm9dM/+CTpqReD554js1Ot6t9rSyb8RDTAWSGeEWXdT3DS4
         MhlX3E6Rw7K3NVnNGkqff1RaKQtjMTsZQ4di+MLEQkDMkkKOl+aenBcRFg1y2EvvN0Uj
         E2mQ==
X-Received: by 10.66.141.165 with SMTP id rp5mr38736377pab.90.1395219767733;
        Wed, 19 Mar 2014 02:02:47 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id pe3sm60183596pbc.23.2014.03.19.02.02.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Mar 2014 02:02:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqq38innyjq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244422>

On 3/12/2014 9:59 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> I though that an example just to describe `argh' while useful would
>> look a bit disproportional, compared to the amount of text on
>> --parseopt.
>>
>> But now that I've added a "Usage text" section to looks quite in place.
> Good thinking.
>
>> I was also wondering about the possible next step(s).  If you like
>> the patch will you just take it from the maillist and it would
>> appear in the next "What's cooking in git.git"?  Or the process is
>> different?
> It goes more like this:

Thank you for all the details.

>   - A topic that is in a good enough shape to be discussed and moved
>     forward is given its own topic branch and then merged to 'pu', so
>     that we do not forget.  The topic enters "What's cooking" at this
>     stage.

I can not find this particular patch in the latest "What's cooking" email.
Is there something I can do?
It does not seems like there is a lot of interest, so I am not sure 
there will be a lot of discussion.
It is a minor fix and considering the number of the emails on the list, 
I do not unexpected this kind of stuff to be very popular.
But it seems like a valid improvement to me.
Maybe I am missing something?

Same questions about this one:

     [PATCH] gitk: replace SHA1 entry field on keyboard paste
     http://www.mail-archive.com/git@vger.kernel.org/msg45040.html

I think they are more or less similar, except that the second one is 
just trivial.

>   - Discussion on the topic continues on the list, and the topic can
>     be replaced or built upon while it is still on 'pu' to polish it
>     further.
>
>     . We may see a grave issue with the change and may discard it
>       from 'pu'.
>
>     . We may see a period of inaction after issues are pointed out
>       and/or improvements are suggested, which would cause the topic
>       marked as stalled; this may cause it to be eventually discarded
>       as "abandoned" if nobody cares deeply enough.
>
>   - After a while, when it seems that we, collectively as the Git
>     development circle, agree that we would eventually want that
>     change in a released version in some future (not necessarily in
>     the upcoming release), the topic is merged to 'next', which is
>     the branch Git developers are expected to run in their daily
>     lives.
>
>      . We may see some updates that builds on the patches merged to
>        'next' so far to fix late issues discovered.
>
>      . We may see a grave issue with the change and may have to
>        revert & discard it from 'next'.
>
>   - After a while, when the topic proves to be solid, it is merged to
>     'master', in preparation for the upcoming release.
>
