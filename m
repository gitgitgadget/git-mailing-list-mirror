From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 22:40:59 -0000
Organization: OPDS
Message-ID: <050EEC5C75504678BC8A858FD0A55B19@PhilipOakley>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com> <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org> <17103971665F4C4495C6C96086A58B8F@PhilipOakley> <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Chris Rorvick" <chris@rorvick.com>,
	"Git List" <git@vger.kernel.org>,
	"Andrew Ardill" <andrew.ardill@gmail.com>,
	"Tomas Carnecky" <tomas.carnecky@gmail.com>,
	"Woody Wu" <narkewoody@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkjMT-0005in-Q7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 23:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab2LQWkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 17:40:19 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:12739 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752106Ab2LQWkS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 17:40:18 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgIFAIWSz1BcHmeG/2dsb2JhbABFi3qyLBdzghkFAQEEAQgBAS4eAQEhBQYCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBh3wKujqMXYFngXthA4gshVGYVYJmDQ
X-IronPort-AV: E=Sophos;i="4.84,304,1355097600"; 
   d="scan'208";a="394248176"
Received: from host-92-30-103-134.as13285.net (HELO PhilipOakley) ([92.30.103.134])
  by out1.ip04ir2.opaltelecom.net with SMTP; 17 Dec 2012 22:40:16 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211712>

From: "Junio C Hamano" <gitster@pobox.com> Sent: Monday, December 17, 
2012 9:13 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com> Sent: Monday, December 17,
>>> This is to "check out the branch" ;-)
>>> ...
>>
>> From a user perspective it's better to refer to the working directory
>> first rather than the internal mechanics.
>>
>>    Prepare to work on <branch>, by updating the files in the
>>    working tree and index to the branch's previous content, and
>>    pointing HEAD to it.
>
> I agree that the mention of "pointing HEAD to" may be better to be
> rephrased in the user facing terms.
>
> Because the primary purpose of "git checkout <branch>" is to "check
> out the branch so that further work is done on that branch", that
> aspect of the behaviour should be mentioned first.

That part is OK, but it is a bit tautological.

>               Updating of the
> working tree files and the index is the implemenation detail of
> starting to work on that branch.

It was this part that I felt needed the worker's work-tree mentioned 
first.

It could be argued that workers think they do work on the tree, and that 
the branch name is an administrative place holder.

When the two sentences are back to back it was OK, as you had still 
included the key element of my suggestion.

>
> So your suggestion is going backwards, I'd have to say.
>
A misunderstanding of the suggestion perhaps?

Philip 
