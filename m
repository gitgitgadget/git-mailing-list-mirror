From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 2/3] sh-setup: add new peel_committish() helper
Date: Fri, 14 Jun 2013 17:44:04 +0100
Organization: OPDS
Message-ID: <02E12EC628804EACABF52ACDFE2BDCF4@PhilipOakley>
References: <1371215872-9796-1-git-send-email-artagnon@gmail.com> <1371215872-9796-3-git-send-email-artagnon@gmail.com> <59954A85BB7C4B279B61C46CC1D81CCA@PhilipOakley> <CALkWK0kCOJTRTQ-eKbOUnD18xWFqMnYi385aN=+_H4CoLZSLhQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 18:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnX69-0007lI-QT
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 18:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab3FNQnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 12:43:33 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:38504 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752647Ab3FNQnc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 12:43:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArsNAHtHu1FZ8YhC/2dsb2JhbABVBoMJg3iFP7YSBAEDAYEJF3SCHgUBAQQBCAEBGRUeAQEhCwIDBQIBAw4HAQICAgUhAgIUAQQIEgYHFwYTCAIBAgMBh2sDCQqpBYhEDYhSgSaLPYE/PGqCUzNhA45uhmyMA4IChSSDEDs
X-IronPort-AV: E=Sophos;i="4.87,867,1363132800"; 
   d="scan'208";a="578742912"
Received: from host-89-241-136-66.as13285.net (HELO PhilipOakley) ([89.241.136.66])
  by out1.ip06ir2.opaltelecom.net with SMTP; 14 Jun 2013 17:43:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227897>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Friday, June 14, 2013 5:18 PM
> Philip Oakley wrote:
>> Is there a proper name for this style of revision specification? I've 
>> been
>> letting this 'style' wash over me in the hope that I'd understand
>> eventually, but it hasn't.
>
> See gitrevisions(7).  None of them have any names.
... which is a shame...

>
>> Loking at git-rev-parse I now see that it might be the 'Commit 
>> Message
>> Regex' rev specifier.
>
> Did you just invent that term?  I couldn't find any mentions of it.

Yep, hence the 'it might be'.   Maybe I missed a word and should have 
written 'it might be called' ;-)

It would be useful to have some descriptive names for these unusual 
(uncommon) methods.
There's already the "pathspec :(glob) syntax".

Philip 
