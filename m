From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Tue, 18 Mar 2014 00:16:19 -0000
Organization: OPDS
Message-ID: <D6ED63739391422AAAB3B863AA9626CB@PhilipOakley>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com><EA1EF5746EA7414CAE1320AA61100178@PhilipOakley> <xmqqd2hkg2qw.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Ramkumar Ramachandra" <artagnon@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 01:16:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPhhi-00052Z-DR
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 01:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaCRAQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 20:16:22 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:45977 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbaCRAQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Mar 2014 20:16:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AloXAC6PJ1NZ8YHW/2dsb2JhbABagwaJVrlSAQIBAYEiF3SCIAUBAQEBAgEIAQEuHgEBEw4FBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYdgDLQKnSyOaIMrgRQEiRqGIJs8gy09
X-IPAS-Result: AloXAC6PJ1NZ8YHW/2dsb2JhbABagwaJVrlSAQIBAYEiF3SCIAUBAQEBAgEIAQEuHgEBEw4FBgIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYdgDLQKnSyOaIMrgRQEiRqGIJs8gy09
X-IronPort-AV: E=Sophos;i="4.97,673,1389744000"; 
   d="scan'208";a="101299845"
Received: from host-89-241-129-214.as13285.net (HELO PhilipOakley) ([89.241.129.214])
  by out1.ip07ir2.opaltelecom.net with SMTP; 18 Mar 2014 00:16:19 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244316>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> * po/git-help-user-manual (2014-02-18) 1 commit
>>> - Provide a 'git help user-manual' route to the docbook
>>>
>>> I am not sure if this is even needed.
>>
>> My rhetorical question would be "what should 'git help user-manual'
>> do?" for the beginner, ...
>
> Why would any _beginner_ even be expected to ask "git help"
> everything, including "user-manual", in the first place?  Wouldn't
> things like /usr/share/doc/git-doc/ be the place to help them in a
> consistent manner across different programs instead?

It would be my view that 'git help' would be the first place for a 
_beginner_ to start. In some ways it depends on what background one 
expects the beginner to have, and whether they know well their way 
around their machine, which often isn't the case.

Given that Git is available on many systems as a packaged application, 
the user may not even know where the raw documentation is held. That's 
certainly likely for those on Windows ;-)
>
>> ... do we have a sort of policy on ensuring
>> that the majority of user documentation should be available (or at
>> least referenced) via the 'git help' mechanism?
>
> I doubt that there should be such a policy.
>
> "git help" is primarily to show the manual pages, and some technical
> details docs that are referenced from manpages may need to be
> reachable from it.
My approach, as you may have gathered, would be that the basic 
documenation should at least be available via a 'git help <something>' 
mechanism, even if advanced users already use alternative means suitable 
to their expertise.

>  The user manual, on the other hand, may
> reference individual manpages but because it is primarily a document
> that shows the overall flow to employ different commands, individual
> manpages referring to the user manual feels entirely the other way
> around.

Ideally (from my viewpoint) there would be a way to directly access the 
current "user-manual"  via the 'git help'. It's whether special casing 
the user-manual would be sensible.

At the moment 'git help' prompts for 'git help -g' which then lists the 
leading guides (I have a -gg option to list all guides in draft), so 
beginners who read the prompts would at least be led to the tutorial, 
which does have an extra link into the user-manual. Otherwise it's 
catch-22 - if a user doesn't know it's there they might never find it. 
One has to lead the horse to the water before it can drink, even though 
some never do ;-) 
