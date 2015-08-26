From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 16:02:21 -0700
Message-ID: <CA+P7+xqYMHfMuBKtGK_p8mwbLjEJWN80i1oDyCdJ_0iVZPmhaQ@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com> <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
 <xmqqio822atc.fsf@gitster.dls.corp.google.com> <CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
 <500FC504AB174A98B31CD8BEFCDDCFAC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 27 01:02:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUjib-0008LX-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 01:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbbHZXCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 19:02:43 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35554 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbHZXCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 19:02:42 -0400
Received: by iodt126 with SMTP id t126so37813722iod.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 16:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EwNC6TwJOAR3mGzO+RJ6DMndqthKtj0xA9mF5NiLhdk=;
        b=jo/LCaG2kp9Nl88Vj4xc7wzZ3MBv+SUdmwUZOEe8vTEzsGIG4JFyIBIVdAjtqnu0CD
         vctxsO9xwnD9eMHWZ5Ucx+WzfTlRJXAS2lUQ0FSE09zrEbttzR69AwwgI8H+rLqEG+oa
         6VsCfZVlt1PtTKVUWmOOT3qh3YMf1b2PqcUCwKuAPzun2Ti0quLSgtKED1hdaEDB+UZg
         NqPlcBvKJio+noVRwNzizm6YdE6qOYlg/uguIZWSbBaCPRFkbc0oX8TEcylbywpCAq5h
         12n+sGPZZ5+zTcNEZioOtJiVRWm7NOe4Tgvx8wcwL/BqDpnCbL2C8DkNX3y848FRXcl8
         XtZw==
X-Received: by 10.107.133.213 with SMTP id p82mr8375743ioi.71.1440630161391;
 Wed, 26 Aug 2015 16:02:41 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 26 Aug 2015 16:02:21 -0700 (PDT)
In-Reply-To: <500FC504AB174A98B31CD8BEFCDDCFAC@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276648>

On Wed, Aug 26, 2015 at 3:52 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
>>
>> On Wed, Aug 26, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> But notice that I said "if you really want to".  I personally think
>>> it is a road to madness.
>>
>>
>> Agreed. I don't believe in command line API here. I think we'd need a
>> better solution.
>>
>> My gut says: Live with the warts on old commands and try to make
>> people use command words for new commands.
>> --
>
> Agreed. However Graeme's original question also said "I can supply a more
> extensive list if needed", and "I still have to reference the help to remind
> me of what parameter to use in certain situation", which suggests that one
> option is to capture that list within some part of the documentation,
> especially if Graeme already has an easy to read layout.
>
> If it could be part of the documenation, where should it go - gitcli or
> perhaps it's own guide (`git help -g` and friends)?
>

I hope to spend some time investigating this in the near future.
Personally I feel that command names make more sense than options
since they are essentially non-options, and it helps separate
logically related but non-equivalent operations more easily.

The confusion that results from git-checkout, and git-branch has
caught more than a few new people at $dayjob.

Regards,
Jake
