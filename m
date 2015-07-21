From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2015, #05; Mon, 20)
Date: Mon, 20 Jul 2015 22:15:04 -0700
Message-ID: <xmqqsi8iw0pz.fsf@gitster.dls.corp.google.com>
References: <xmqqwpxuwh8d.fsf@gitster.dls.corp.google.com>
	<1437439832.30911.12.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 07:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHPtb-0001AN-NG
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 07:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbGUFPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 01:15:08 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36593 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbGUFPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 01:15:07 -0400
Received: by pachj5 with SMTP id hj5so113036555pac.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 22:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9H5y3Xfhz0IlzfaRGmVlmtMlA7QshxloWBlm4K9KomY=;
        b=WZSGnme+wu9kv0uYrU7bR/5+uco1+a5L13u1unQHgZPo8NWViO2CyBXxSCM1SuQHkj
         hg9EvNnc0E+gRV2WN7REEGsbCm7WodaV+/BxC2LwZ5lPqxbAL63OsJCl4Zxf0lUYWxhS
         YcjySVSFIstYD9A5fEwvsNXguhf//WbnzkJOB7Fgi0N2Mz7akOzkhYe/mzshzrepiT4s
         EGZBG1aTTiyLkYSHesytHXQXqWaWVBU894tQe3U4IViLThTFP7O/dGOa0khX11k0Fbtg
         dGZsyjHm2pODz/XqM5JCkaBjvunUmzlgzq9cNPWLBxWjdpjOJNKwdr+BM+mlZnwSOUfi
         Ojog==
X-Received: by 10.70.130.34 with SMTP id ob2mr68063711pdb.15.1437455707163;
        Mon, 20 Jul 2015 22:15:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id fi7sm10879138pdb.25.2015.07.20.22.15.04
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 20 Jul 2015 22:15:04 -0700 (PDT)
In-Reply-To: <1437439832.30911.12.camel@twopensource.com> (David Turner's
	message of "Mon, 20 Jul 2015 20:50:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274368>

David Turner <dturner@twopensource.com> writes:

>> * dt/refs-backend-preamble (2015-07-13) 7 commits
>>  - git-stash: use update-ref --create-reflog instead of creating files
>>  - update-ref and tag: add --create-reflog arg
>>  - refs: add REF_FORCE_CREATE_REFLOG flag
>>  - git-reflog: add exists command
>>  - refs: new public ref function: safe_create_reflog
>>  - refs: Break out check for reflog autocreation
>>  - refs.c: add err arguments to reflog functions
>> ...
>>  Still under discussion.
>> 
>>  Will hold.
>
> What's left to discuss on this one? I think the latest version addresses
> all concerns, but I'm happy to do another reroll or discuss further if
> necessary.

I think I found the series more or less ready when I saw v7, but
there was a good discussion between Michael Haggerty and you on that
round after I thought so, and then you posted the reroll (v8) which
is what is queued above.  As I was not closely following the earlier
exchange, I wanted to hear from Michael if everything is now good
with v8, which hasn't happened as far as I recall.

Also in $gmane/273828 [*1*] you hinted (but without showing a firm
commitment) that there might be a reroll coming, which was another
reason why I wasn't in a hurry to merge v8 iteration down to 'next'.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/273786/focus=273828
