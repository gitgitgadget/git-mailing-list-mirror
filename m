From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Workflow for templates?
Date: Sat, 10 Nov 2012 13:44:53 -0000
Organization: OPDS
Message-ID: <E2479326E6B94EFEAEE8816FD926F36F@PhilipOakley>
References: <7f1bbe94-b3f6-4728-960d-19e89e8e4166@zcs>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>, "Josef Wolf" <jw@raven.inka.de>
To: "Enrico Weigelt" <enrico.weigelt@vnc.biz>
X-From: git-owner@vger.kernel.org Sat Nov 10 14:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXBMf-00051E-OM
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 14:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab2KJNog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 08:44:36 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:63672 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab2KJNof (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2012 08:44:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArANAFRZnlBcHm+W/2dsb2JhbABEhhmFP7Z4AQECgQCBCYIZBQEBBAEIAQEZFR4BARUMCwIDBQIBAxUBBAIFIQICFAEEGgYHFwYKCQgCAQIDAYdzCqoxkjqBIopzCkYxHDWDZTJhA410mEqCbw
X-IronPort-AV: E=Sophos;i="4.80,751,1344207600"; 
   d="scan'208";a="399361224"
Received: from host-92-30-111-150.as13285.net (HELO PhilipOakley) ([92.30.111.150])
  by out1.ip05ir2.opaltelecom.net with SMTP; 10 Nov 2012 13:44:34 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209274>

From: "Enrico Weigelt" <enrico.weigelt@vnc.biz> Sent: Saturday, November 
10, 2012 10:29 AM
>> This is often the key point that requires the 'new mindset'. Most
>> folk
>> use/used the directory heirarchy (subtle distinction with the .git
>> 'repo' directory heirarchy to be noted) as a way of separating
>> ownership
>> between groups. They find it very hard to undo the old mindset and
>> use
>> branches _instead of_ directories for the different group
>> configurations.
>
> hmm, is this really a psychological issue ?

Oh absolutely.   It is very very hard to unlearn stuff, especially bad 
habits that have had to become ingrained to make them work adequately! 
It's like re-learning an alternative to a well loved mnemonic. "CLAP".

>
> well, many years ago, i've seen a talk about git (maybe by linus 
> himself),
> which started with something like "forget everything you know abozt 
> scm" ...

Most folk don't know why the old way used to be right, and is now so 
wrong, so they can't rationalize the change. Hence find the change very 
difficult.

[Other than git..] Current SCM methods were established before the 
Titanic sank and are based on drawing office practice, and were 
transfered and applied to code printouts (which are simply machining 
instructions to a compiler). The modern zero cost replication of 
"Master" drawings/code printouts has destroyed the original reasons for 
the old practices (protect the aluable unique master). Similarly the new 
paradigm of "how can I verify that this is a proper copy of the master" 
isn't understood.

Definately a psychological issue when your whole world is being turned 
upside down ;-)
