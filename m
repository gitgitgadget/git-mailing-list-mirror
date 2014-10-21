From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Tue, 21 Oct 2014 23:08:53 +0100
Organization: OPDS
Message-ID: <F862A78B765340E9B18BFDC2A9C2E96F@PhilipOakley>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org><xmqqwq7vr91j.fsf@gitster.dls.corp.google.com><8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley><xmqqy4sa3bpk.fsf@gitster.dls.corp.google.com><DB0FCB7CEC8C453D9237CA4FFA687EDC@PhilipOakley><xmqq38ai34bh.fsf@gitster.dls.corp.google.com> <xmqqy4sa1pct.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 00:08:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xghbe-0001gj-FP
	for gcvg-git-2@plane.gmane.org; Wed, 22 Oct 2014 00:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933546AbaJUWIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 18:08:39 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:37373 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933170AbaJUWIi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2014 18:08:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmlXAGjYRlRZ8YBmPGdsb2JhbABcgw5TWIhBwWCCX4dDBAQCgRQXAQEFAQEBATggG4N9BgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIMgm4do1vAQEBBwIBGwSOP4FAWIM0gR4FhRUChg2GXV2DaaExPC8BgQWBRQEBAQ
X-IPAS-Result: AmlXAGjYRlRZ8YBmPGdsb2JhbABcgw5TWIhBwWCCX4dDBAQCgRQXAQEFAQEBATggG4N9BgEBBAgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBwMUBhMIAgECAwGIMgm4do1vAQEBBwIBGwSOP4FAWIM0gR4FhRUChg2GXV2DaaExPC8BgQWBRQEBAQ
X-IronPort-AV: E=Sophos;i="5.04,764,1406588400"; 
   d="scan'208";a="474596002"
Received: from host-89-241-128-102.as13285.net (HELO PhilipOakley) ([89.241.128.102])
  by out1.ip04ir2.opaltelecom.net with SMTP; 21 Oct 2014 23:08:34 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>> ...
>>>> I think it is just the font. I just opened the above page with
>>>> Chrome and futzed the text from '0' to '0123456789' to see how it
>>>> look.  That round thing is consistent with how other digits are
>>>> rendered.
>>>>
>>>> https://plus.google.com/u/0/+JunioCHamano/posts/dzNXV2FwP6K
>>>>
>>>> (sorry for a URL to plus)
>>>>
>>>>> https://www.kernel.org/pub/software/scm/git/docs/git-status.html
>>>>> (which IIUC is out of date) has an unformatted 0.
>>>> --
>>>
>>> I've just had a look at how it formats when the zero is back-tick
>>> quoted s /ASCII 0/ASCII `0`/ and it looks OK with both Chromium and
>>> Firefox on my hack Ubuntu laptop - the character is colourised and
>>> full sized, and the --man page output looks unchanged and clearly a
>>> zero.
>>>
>>> my hacky attempt at an in-line patch (squash in?) below:
>>
>> You'd need a matching change to 34 in the same document to preserve
>> the consistency the original patch sought, though ;-)
>
> Not that I think such a change makes much sense.
>
> If there was a way to force use of a font whose numerals and I/O are
> more clearly distinguishable and we do so for all HTML documents we
> generate, that would be a good change that is not limited to these
> places, though.
>
I've generated a patch for the 'git status --help' that can act as a 
reference. (to follow)

For me it's only those pages that have a lone zero that cause problems 
due to lack of context. It'll still be a slow burner problem as lone 
zeros are spotted.

Philip 
