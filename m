From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Tue, 9 Aug 2011 10:56:07 +0530
Message-ID: <CALkWK0my7_Ocd9eFfGVcJreOJVkC_OyaUo1Q_U7o0mW04ab-YQ@mail.gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
 <1312454356-3070-18-git-send-email-artagnon@gmail.com> <CAP8UFD0izFOW0xHQB8ZT3+bbTjGtSm-ZWHs6AWdJoEneRX32mw@mail.gmail.com>
 <CALkWK0mKTXUxW=PT_wHEVAzUSgPdZ1s18-9ndZKJqSf6NwVH7w@mail.gmail.com> <7vobzzwvug.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 07:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqeqa-0005sl-9l
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 07:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799Ab1HIF1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 01:27:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46688 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750866Ab1HIF1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 01:27:19 -0400
Received: by wwf5 with SMTP id 5so2274081wwf.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 22:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=3fgKJhbXVYXrd2zW+FKGI99vjOM35sPIaRzk3IvGAM0=;
        b=lCFdXrkPgWrDSnnyW3mw+NwMfcTRZuHjww5RUtb1YR98jQHknEkkzsAVaIGwkV6r44
         Z9iffquCO8lujP65jyRe7CcOIBheYlbywSjq9flHNOTusc86CGQ8Q+kis436wgM4NIw2
         Ath7Z3XcNM8qvPdp9ZWAvIyPAYhCVPRaKJdx4=
Received: by 10.216.185.9 with SMTP id t9mr3700214wem.94.1312867587204; Mon,
 08 Aug 2011 22:26:27 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Mon, 8 Aug 2011 22:26:07 -0700 (PDT)
In-Reply-To: <7vobzzwvug.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179020>

Hi Junio,

Junio C Hamano writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Junio: Here's another small fixup patch for your convenience.
>
> Not very convenient I am afraid ;-)

Hm, I actually thought about this a bit.  Due to the volume of patches
you have to pick up and apply from emails everyday, I figured that you
must have optimized your email-patch application pipeline to such a
ridiculous extent that it's probably faster for you to apply patches
than even typing out a word.  A quick interactive rebase with
autosquash will then fix rr/revert-cherry-pick-continue, no?

>> --8<--
>
> This seems to be too short for "am -c"; have you tried applying it
> yourself first before sending it out?

No, I haven't tried this.  Will try it and patch "am -c" if necessary,
because I like this minimal scissor (picked it up from Jonathan I
think).

>> -test_expect_success '--signoff is not automatically propogated to
>> resolved conflict' '
>> +test_expect_success '--signoff is not automatically propagated to
>> resolved conflict' '
>
> Linewrapped.

Ugh.  Classic GMail web interface mistake.  I sometimes risk sending
small patches without git-send-email, and this is what happens.
Nothing helps: mutt's single-threaded'ness is starting to get on my
nerves now.

> I'll squash this manually, so no need to resend. Thanks.

Thanks.

-- Ram
