From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 16:03:31 -0700
Message-ID: <CA+P7+xrzU=n65sVkHH9O5v7QjC=vKkQDQy5u4XVby19T9O98Pw@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com> <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
 <xmqqio822atc.fsf@gitster.dls.corp.google.com> <CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
 <500FC504AB174A98B31CD8BEFCDDCFAC@PhilipOakley> <CA+P7+xqYMHfMuBKtGK_p8mwbLjEJWN80i1oDyCdJ_0iVZPmhaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 01:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUjjY-0000ni-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 01:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbHZXDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 19:03:52 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38122 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbHZXDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 19:03:51 -0400
Received: by igfj19 with SMTP id j19so24036918igf.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hdiEY4YTZYBuJ6Em3TpKVuYnCe78dLgo51kdvLFy6fM=;
        b=fXOYiyhUFhZIhhnhiP7YjbPcZPSBs7UsGe5f0RL2lDBhhEEGSa+CvfDBiykuJ7JRTu
         C/sb7RJVWcV5oqlyN0rdAFzZfJbvwyKLr7colUFZQhri6U9HMmWAcj9NGykGNu6pd0uB
         L/tN7Ie1JbektvRZ73fpoN1xp0a9NrB8j+CgFO+uaS4/4aSVxToUC9lAvJqgrmuHloh1
         tCKiJgu9gx84AYQuUWehukqflwwcw6NMbuLOEZ9yHHNUF1zECs+4FaaaerAyLGDSgY/E
         2tP/zUkRGNZOZC0TyyWoiLFE8L5n+5wXwFSb9/xF7jvSJUxEDFV1BhMATHXeo9w+ffxV
         dxDg==
X-Received: by 10.50.118.104 with SMTP id kl8mr14808753igb.92.1440630231035;
 Wed, 26 Aug 2015 16:03:51 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 26 Aug 2015 16:03:31 -0700 (PDT)
In-Reply-To: <CA+P7+xqYMHfMuBKtGK_p8mwbLjEJWN80i1oDyCdJ_0iVZPmhaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276649>

On Wed, Aug 26, 2015 at 4:02 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Aug 26, 2015 at 3:52 PM, Philip Oakley <philipoakley@iee.org> wrote:
>> From: "Jacob Keller" <jacob.keller@gmail.com>
>>>
>>> On Wed, Aug 26, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com>
>>> wrote:
>>>>
>>>> But notice that I said "if you really want to".  I personally think
>>>> it is a road to madness.
>>>
>>>
>>> Agreed. I don't believe in command line API here. I think we'd need a
>>> better solution.
>>>
>>> My gut says: Live with the warts on old commands and try to make
>>> people use command words for new commands.
>>> --
>>
>> Agreed. However Graeme's original question also said "I can supply a more
>> extensive list if needed", and "I still have to reference the help to remind
>> me of what parameter to use in certain situation", which suggests that one
>> option is to capture that list within some part of the documentation,
>> especially if Graeme already has an easy to read layout.
>>
>> If it could be part of the documenation, where should it go - gitcli or
>> perhaps it's own guide (`git help -g` and friends)?
>>
>
> I hope to spend some time investigating this in the near future.
> Personally I feel that command names make more sense than options
> since they are essentially non-options, and it helps separate
> logically related but non-equivalent operations more easily.
>
> The confusion that results from git-checkout, and git-branch has
> caught more than a few new people at $dayjob.
>
> Regards,
> Jake

That being said, use of "--create" or so forth really isn't that
bothersome so maybe the gains outway the cons here.

Regards,
Jake
