From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Fri, 8 Feb 2013 23:16:12 -0000
Organization: OPDS
Message-ID: <27C7EA38DDD345F994F01E5B8FB6D278@PhilipOakley>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley> <7vr4kqzfw5.fsf@alter.siamese.dyndns.org> <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley> <7v6222za9x.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 00:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3xB6-0001oa-RR
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 00:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947270Ab3BHXP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 18:15:58 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:55375 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757205Ab3BHXP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2013 18:15:57 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsALAH5qFVFcHls+/2dsb2JhbABFjAmzdQICgQgXc4IaBQEBBAEIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBh3oKCL82BI0fGhlOglthA4gwhVeYcIMAgWc
X-IronPort-AV: E=Sophos;i="4.84,632,1355097600"; 
   d="scan'208";a="408357221"
Received: from host-92-30-91-62.as13285.net (HELO PhilipOakley) ([92.30.91.62])
  by out1.ip05ir2.opaltelecom.net with SMTP; 08 Feb 2013 23:15:55 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215827>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, February 08, 2013 10:54 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> My initial https://github.com/PhilipOakley/git/commit/e6217d simply
>> updates
>> -  N_("See 'git help <command>' for more information on a specific
>> command.");
>> +  N_("See 'git help <command>' for more information on a specific
>> command.\n"
>> +     "Or 'git help <guide>', such as 'tutorial' for an introduction
>> to Git.");
>> as a starter for the new users.
>
> Yeah, that would be a good change to make to "git help<RETURN>"
> output.

I'll sort some patches early next week (the weekend's committed 
elsewhere)

>
>> My view is that help --all (-a) is essentially incomplete as it
>> currently doesn't provide all the help.
>
> It has always been about "tell me all subcommands", not about "give
> me all the help you could give me".  You are not adding a "help"
> subcommand to a system you wrote last week.  Changing the semantics
> this late feels, eh, too late.

OK, I'll limit the the follow-ons to just an extra --guides option 
(probably just a list of the common guides initially), and 
leave --all(-a) for just the commands.
