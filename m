From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 6 Jul 2015 11:22:02 -0400
Message-ID: <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
 <1435774099-21260-4-git-send-email-dborowitz@google.com> <xmqqfv578x87.fsf@gitster.dls.corp.google.com>
 <CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
 <xmqqzj3f7gde.fsf@gitster.dls.corp.google.com> <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 17:22:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8E3-0001az-4t
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753250AbbGFPW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:22:26 -0400
Received: from mail-vn0-f51.google.com ([209.85.216.51]:37198 "EHLO
	mail-vn0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbbGFPWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 11:22:23 -0400
Received: by vnav203 with SMTP id v203so4844951vna.4
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zL409aWV9Qc7g6/qI/Ej9UuuC65RFATl2mX/sw8ahWY=;
        b=GnSGCMDUcuwWx4+xdeyxOkMfUV4w4fR04fLpsLUlbulbQMflniI6XpHaiIAAqB33GK
         Dt9tUW1R8LwaXZ6joneNmMrGeDs7k3aXlEQcRHZ3dtZ9+4xQ7S6CNu0QS0C/X1jF78uL
         PZMvTDCjWlc6l2kQE0nURMsBv+nC2EPNHE9e13k9533rX5J5jD+x02gjaTDmH7d8b5D0
         pQwVz4BJoCSd9Li0JzKO4KubOHYIs6CzNHbzrm8sBNKex2gLauT3dXBOWQYleLytR8W5
         h8ll/qHqfIkDnPDRYjPKL0cB1RQuomucTAzE+Zv2/GUzO1YTNRw3cKWhMIDXBvIk0We5
         dHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zL409aWV9Qc7g6/qI/Ej9UuuC65RFATl2mX/sw8ahWY=;
        b=Vhr2/wpGzK5mh1fqkMMREeV2ngB1Ah/ZBMIr5pnFz6KFdsLRDgeXoGu8iaHXA7pI4O
         JK1MRx/GqmaNViBWLAxPjOpHofixKfpl2aLPsKiC+pEdoD7KhuzN8nn82idDIKmVoekD
         YBgWl3eo25M9PQ3EmQi0vBx/068abKaIF8AqA/zMHsY8VdzJx9cnsd7m+uD70Ts9lkpx
         GcB1SHQZkGA2JZGbrg4AGnIYvcr/fdF+hnRTpBkQTUlRix7GvQ67KIsot9fTiAqQwSyQ
         0NjMrmbAjqjnlRQl7EJCaJXosj290ifl0mhXdG72s0/n3bxC2If680XRFRk088yAG3dd
         0eSA==
X-Gm-Message-State: ALoCoQnYTBDpaJiKP0jokE9AetWUosg89EzeVIYMVguFXXt9KBMnuRn0B0d1h7vulwetp+iXZ2ec
X-Received: by 10.52.230.2 with SMTP id su2mr50505106vdc.55.1436196141989;
 Mon, 06 Jul 2015 08:22:21 -0700 (PDT)
Received: by 10.52.177.6 with HTTP; Mon, 6 Jul 2015 08:22:02 -0700 (PDT)
In-Reply-To: <CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273386>

On Mon, Jul 6, 2015 at 10:46 AM, Dave Borowitz <dborowitz@google.com> wrote:
> On Wed, Jul 1, 2015 at 4:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>> >> I am moderately negative about this; wouldn't it make the end result
>> >> cleaner to fix the implementation?
>> >
>> > I'm not sure I understand your suggestion. Are you saying, you would
>> > prefer to make LFs optional in the push cert, for consistency with LFs
>> > being optional elsewhere?
>>
>> Absolutely.  It is not "make" it optional, but "even though it is
>> optional, the receiver has not been following the spec, and it is
>> not too late to fix it".
>>
>> The earliest these documentation updates can hit the public is 2.6;
>> by that time I'd expect the deployed receivers would be fixed with
>> 2.5.1 and 2.4.7 maintenance releases.
>>
>> If some third-party reimplemented their client not to terminate
>> with LF, they wouldn't be working correctly with the deployed
>> servers right now *anyway*.  And with the more lenient receive-pack
>> in 2.5.1 or 2.4.7, they will start working.
>>
>> And we will not change our client to drop LF termination.  So
>> overall I do not see that it is too much a price to pay for
>> consistency across the protocol.
>
> Ok, I understand your proposal now, thank you. I will drop this
> documentation patch from this series, and abandon
> https://git.eclipse.org/r/51071 in JGit. I am not volunteering to
> rewrite push cert handling in git-core though ;)

Unfortunately, optional LFs still make the stored certs for later
auditing and parsing a bit illegible. This is one way in which push
certs are fundamentally different from the rest of the wire protocol,
which is not intended to be persisted.

The corner case I pointed out before where nonce runs into commands is
not the only one.

Consider the following cert fragment:
001fpushee git://localhost/repo
0029nonce 1433954361-bde756572d665bba81d8

A naive cert storage/auditing implementation would store the raw
payload that needs to be verified, without the pkt-line framing. In
this case:
pushee git://localhost/repononce 1433954361-bde756572d665bba81d8

A naive parser that wants to find the pushee would look for "pushee
<urlish>", which would be wrong in this case. (To say nothing of the
fact that "pushee" might actually be "-0700pushee".)

The alternatives for someone writing a parser are:
a. Store the original pkt-line framing.
b. Write a parser in some other clever way, e.g. parsing the entire
cert in reverse might work.

Neither of these is very satisfying, and both reduce human legibility
of the stored payload.

>> > If LF is optional, then with that approach you might end up with a
>> > section of that buffer like:
>>
>> I think I touched on this in my previous message.  You cannot send
>> an empty line anywhere, and this is not limited to push-cert section
>> of the protocol.  Strictly speaking, the wire level allows it, but I
>> do not think the deployed client APIs easily lets you deal with it.
>>
>> So you must follow the "SHOULD terminate with LF" for an empty line,
>> even when you choose to ignore the "SHOULD" in most other places.
>>
>> I do not think it is such a big loss, as long as it is properly
>> documented.
