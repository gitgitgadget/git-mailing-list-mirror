From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Tue, 21 Jul 2015 21:39:03 +0100
Organization: OPDS
Message-ID: <B947AFE2559B41DDA2078497EB068EAF@PhilipOakley>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org><xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com><73004CECB3514744A5916831B4501689@PhilipOakley><xmqqvbdduxd5.fsf@gitster.dls.corp.google.com> <xmqq1tg1uvjk.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:38:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHeJI-0002UI-M8
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbbGUUik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:38:40 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:23392 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110AbbGUUij (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 16:38:39 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BOCQAyra5VPMS/BlxcgxOBPYZQbbxOBAQCgUA9EAEBAQEBAQEGAQEBAUABJBuEHgYBAQQIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAwYBDQYTCAIBAgMBiCG8bJAHi0yEIxEBUYMegRQFjHCHYwGBDYxfjzKIGYEJZoI0PTGBDYE+AQEB
X-IPAS-Result: A2BOCQAyra5VPMS/BlxcgxOBPYZQbbxOBAQCgUA9EAEBAQEBAQEGAQEBAUABJBuEHgYBAQQIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAwYBDQYTCAIBAgMBiCG8bJAHi0yEIxEBUYMegRQFjHCHYwGBDYxfjzKIGYEJZoI0PTGBDYE+AQEB
X-IronPort-AV: E=Sophos;i="5.15,518,1432594800"; 
   d="scan'208";a="39231135"
Received: from host-92-6-191-196.as43234.net (HELO PhilipOakley) ([92.6.191.196])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 21 Jul 2015 21:38:37 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274414>

From: "Junio C Hamano" <gitster@pobox.com>
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> ... Ideally, if part of this
>>> mainstream Git, it would get picked up automatically by them
>>> (rather than being local 'fixes' endlessly carried forward).
>>
>> Actually, that is not "ideal", but what I want to avoid.
>>
>> As I do not do Windows, it simply is wrong for me to apply changes
>> that are very likely to affect Windows folks without seeing their
>> support first,...
>
> Just to clarify this part.  I do not do RedHat, Solaris or OSX,
> either.  Also MSVC may not be what GfW folks primarily target.
>
> But the thing is that (1) Windows is so much different, and (2) GfW
> folks are much more qualified to judge platform-specific issues on
> Windows than I am.
>
> Even though I may still need to have a say in the overall structure
> of the changes to the upstream tree coming from them (e.g. "Don't
> sprinkle #ifdef all over the generic code; instead add a wrapper or
> two in compat/ to keep the generic code generic" is something I may
> tell them when rejecting a change forwarded to me), I trust them a
> lot more than I trust myself when it comes to what the changes do in
> the platform-specific part and how they do it.
>
> Thanks.
> --
Thanks for the extra clarification. I'll ask if they can confirm this 
update on GfW.

I've also asked Ramsay what his current situation is re- you previous 
email and the msvc-build.

regards

Philip 
