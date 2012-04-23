From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Mon, 23 Apr 2012 22:01:26 +0100
Organization: OPDS
Message-ID: <7D1315FBD9DC4581BB3C501A53E9E0F8@PhilipOakley>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr><1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr><1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr><CB914FF3899C496F9E85E83B9532E055@PhilipOakley> <xmqqwr56i7qk.fsf@junio.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMQNV-0007IT-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 23:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab2DWVAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 17:00:52 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:59073 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753056Ab2DWVAw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 17:00:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar0LAC/ClU9cHIEm/2dsb2JhbABEizClGwICgQ+BCIIEAQQBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBhTcHAYIpGrpzixYIgV6DcGMEiC+FSZhAgmo
X-IronPort-AV: E=Sophos;i="4.75,470,1330905600"; 
   d="scan'208";a="388766655"
Received: from host-92-28-129-38.as13285.net (HELO PhilipOakley) ([92.28.129.38])
  by out1.ip01ir2.opaltelecom.net with SMTP; 23 Apr 2012 22:00:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196165>

From: "Junio C Hamano" <gitster@pobox.com>  Sent: Monday, April 23, 2012 
8:11 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Matthieu Moy" <Matthieu.Moy@imag.fr> Sent: Monday, April 23,
>> 2012 9:37 AM
>>> The previous documentation was explaining _what_ the options were doing,
>>> but were of little help explaining _why_ a user should set his default 
>>> to
>>> either of the options.
>>>
>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>>> ...
>>> +* `matching` - push all branches having the same name in both ends.
>>> + ...
>>> +  updated the branch remotely. This is the default.
>>
>> Given the expected future change to 'simple' as the default, surely
>> "This is currently the default." give the hint toward that change.
>
> Correct, and that is exactly why this patch does not say "currently".
>
> As the proposed commit log message explains, this change is about
> clarifying what these options are and unrelated to "future" default
> change at all at this step.
>

My mistake. Sorry for the noise / misunderstanding. I now see that [PATCH 
6/7] has the change. 
