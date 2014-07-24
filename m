From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Thu, 24 Jul 2014 23:37:00 +0100
Organization: OPDS
Message-ID: <7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com><B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley> <xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 00:37:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XARdG-00041W-J1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 00:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbaGXWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 18:36:57 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:12183 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961AbaGXWg5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2014 18:36:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqYaACKK0VNOl36sPGdsb2JhbABYgw6BKYcvgQSBHMcpBQECAQGBEBcFAQEBATg2g34FAQEEAQgBAS4eAQEPEgUGAgMFAgEDFQELJRQBBBoGBwMUBhMIAgECAwGIKQyvEJA8F4wcgy+DNYEYBYovhnaVeIwnPC8
X-IPAS-Result: AqYaACKK0VNOl36sPGdsb2JhbABYgw6BKYcvgQSBHMcpBQECAQGBEBcFAQEBATg2g34FAQEEAQgBAS4eAQEPEgUGAgMFAgEDFQELJRQBBBoGBwMUBhMIAgECAwGIKQyvEJA8F4wcgy+DNYEYBYovhnaVeIwnPC8
X-IronPort-AV: E=Sophos;i="5.01,727,1400022000"; 
   d="scan'208";a="505946251"
Received: from host-78-151-126-172.as13285.net (HELO PhilipOakley) ([78.151.126.172])
  by out1.ip03ir2.opaltelecom.net with SMTP; 24 Jul 2014 23:36:55 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254191>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, July 23, 2014 7:10 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> * po/everyday-doc (2014-01-27) 1 commit
>>> - Make 'git help everyday' work
>>>
>>> This may make the said command to emit something, but the source is
>>> not meant to be formatted into a manual pages to begin with, and
>>> also its contents are a bit stale.
>>
>>> It may be a good first step in
>>> the right direction, but needs more work to at least get the
>>> mark-up right before public consumption.
>>>
>>> Will hold.
>>>
>>
>> It's not clear to me which bits of mark-up are 'wrong' and must be
>> reworked,
>
> It's been too long since I wrote the above and I left it without
> updates (these comments are by default carried over from one issue
> to the next of "What's cooking" report, unless there is some
> development on the topic).  Now I read the output (admittedly, I
> skimmed only the HTML version), I think the formatting / mark-up is
> fine.

Thanks for the clarification - I hadn't been sure which way to go on the 
formatting aspect.
>
> I at the same time found various command sequences used there are
> rather classical and there are better ways to do the same with
> modern tools,

I can have a look at the 'standalone' and 'participant' developer 
command lists but would shy away from any claims about the 'integrator' 
and 'administrator' roles ;-)

> which still makes me feel hesitant to promote this
> document without updating its contents, though.
>

I hadn't viewed it as a 'promotion', rather it was simply ensuring 
access to the guide via the help system, instead of leaving it somewhat 
hidden.

--
Philip 
