From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 01/13] Use 'Git' in help messages
Date: Sun, 24 Feb 2013 21:50:34 -0000
Organization: OPDS
Message-ID: <DE540C447A2242E7A162E03B81B4E5CB@PhilipOakley>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org> <1361660761-1932-2-git-send-email-philipoakley@iee.org> <CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com> <7vr4k65box.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"David Aguilar" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:51:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9jTJ-0002vY-I6
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 22:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757464Ab3BXVub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 16:50:31 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:20206 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757214Ab3BXVub (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2013 16:50:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAAaKKlFZ8rke/2dsb2JhbABFjAu1RYEQF3OCGgUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBAgSBgcXBgESCAIBAgMBh3ADCQqzGw2JRow3gXhUC4JmYQOIM4VhhkyNK4UXgwc
X-IronPort-AV: E=Sophos;i="4.84,730,1355097600"; 
   d="scan'208";a="415406637"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip03ir2.opaltelecom.net with SMTP; 24 Feb 2013 21:50:29 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217004>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, February 24, 2013 8:59 AM
> David Aguilar <davvid@gmail.com> writes:
>
>> This is referring to "git the command", not "git the system",
>> so it should not be changed according to the rule that was
>> applied when many "git" strings were changed to "Git".
>
> That sounds like a sensible objection.
>

I'd read the messages in the tone 'commands of the Git system', but I 
can see that both views are equally plausible. Though the final _("git: 
'%s' is not a Git command. See 'git --help'.") can't be referring to a 
'git-<cmd>', obviously ;-)

>> There are scripts, etc. in the wild that parse this output.
>> which is another reason we would not want to change this.
>
> Are there?  For what purpose?
>
> Especially when these are all _("l10n ready"), I find that somewhat
> unlikely.
>
> The bash completion (in contrib/) does read from the command list
> IIRC.  I do not think it relies on the messages, though.

I was aware of that bash completion used 'git help -a' so I avoided 
changing the response to that option. Initially I'd thought of making 
'-a' provide both commands and guides but knew I'd need to ensure the 
completion would still be sensible. I'd taken Juio's earlier advice to 
keep '-a' unchanged and simply add the -g|--guides option as a 
supplemental 'git help' response..

Philip 
