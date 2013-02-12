From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Improve 'git help' with basic user guide linkss
Date: Tue, 12 Feb 2013 11:11:17 -0000
Organization: OPDS
Message-ID: <2DFA2C4F62AE484681753EBC3774D222@PhilipOakley>
References: <6D91D31A093D46869F43DD8D1012F0FB@PhilipOakley> <7vr4kqzfw5.fsf@alter.siamese.dyndns.org> <6BC280F5827C4098BCB6276232DDE8E4@PhilipOakley> <7v6222za9x.fsf@alter.siamese.dyndns.org> <27C7EA38DDD345F994F01E5B8FB6D278@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 12:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5Dm0-0004Q6-Cx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 12:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826Ab3BLLLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 06:11:17 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:57943 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758734Ab3BLLLQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 06:11:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhQKADwDGlFcHls+/2dsb2JhbABEjAq0HQOBBBdzghoFAQEFCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGEwgCAQIDAYgFCLAbkAqNRm0BgnJhA4gwhVeJOo82gwaBag
X-IronPort-AV: E=Sophos;i="4.84,648,1355097600"; 
   d="scan'208";a="418910132"
Received: from host-92-30-91-62.as13285.net (HELO PhilipOakley) ([92.30.91.62])
  by out1.ip01ir2.opaltelecom.net with SMTP; 12 Feb 2013 11:11:14 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216146>

From: "Philip Oakley" <philipoakley@iee.org>
Sent: Friday, February 08, 2013 11:16 PM
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Friday, February 08, 2013 10:54 PM
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> My initial https://github.com/PhilipOakley/git/commit/e6217d simply
>>> updates
>>> -  N_("See 'git help <command>' for more information on a specific
>>> command.");
>>> +  N_("See 'git help <command>' for more information on a specific
>>> command.\n"
>>> +     "Or 'git help <guide>', such as 'tutorial' for an introduction
>>> to Git.");
>>> as a starter for the new users.
>>
>> Yeah, that would be a good change to make to "git help<RETURN>"
>> output.
>
> I'll sort some patches early next week (the weekend's committed 
> elsewhere)
>
>>
>>> My view is that help --all (-a) is essentially incomplete as it
>>> currently doesn't provide all the help.
>>
>> It has always been about "tell me all subcommands", not about "give
>> me all the help you could give me".  You are not adding a "help"
>> subcommand to a system you wrote last week.  Changing the semantics
>> this late feels, eh, too late.
>
> OK, I'll limit the the follow-ons to just an extra --guides option 
> (probably just a list of the common guides initially), and 
> leave --all(-a) for just the commands.
>
The Git man page includes the different command types listed by category 
(Main porcelain, Ancillary {manipulators, interrogators}, Interacting 
with others, etc.).

Obviously (?) this is generated from the command-list.txt file, though I 
don't see a shell script that would generate the 
'cmds-mainporcelain.txt' (etc.) files 
(//github.com/gitster/git-htmldocs). They are also part of the msysgit 
install.

Where should I be looking to see how they are generated?

Philip 
