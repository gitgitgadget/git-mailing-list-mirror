From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 5/5] Help doc: Include --guide option description
Date: Mon, 4 Mar 2013 00:18:35 -0000
Organization: OPDS
Message-ID: <FF19719A7F4946ADA3FA4E1BD8075AE2@PhilipOakley>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org> <1362342072-1412-6-git-send-email-philipoakley@iee.org> <7vd2vgyrxh.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCJ6b-0000LH-8O
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab3CDARr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:17:47 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30914 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753652Ab3CDARq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 19:17:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFACvgM1FZ8rke/2dsb2JhbABFjAy2PnsXc4IaBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcJAQ0GEwgCAQIDAYgGxy6OPl+CZmEDiDaFZJkYgwg
X-IronPort-AV: E=Sophos;i="4.84,776,1355097600"; 
   d="scan'208";a="64424087"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip07ir2.opaltelecom.net with SMTP; 04 Mar 2013 00:17:44 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217384>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Sunday, March 03, 2013 11:39 PM
> Philip Oakley <philipoakley@iee.org> writes:
>
>> Note that the ability to display an individual guide was
>> always possible. Include this in the update.
>>
>> Also tell readers how git(1) can be accessed, especially for
>> Git for Windows users who do not have the 'man' command.
>> Likewise include a commentary on how to access this page (Catch 22).
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>  Documentation/git-help.txt | 28 +++++++++++++++++++++-------
>>  1 file changed, 21 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
>> index e07b6dc..498a94e 100644
>> --- a/Documentation/git-help.txt
>> +++ b/Documentation/git-help.txt
>> @@ -8,31 +8,45 @@ git-help - Display help information about Git
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git help' [-a|--all|-i|--info|-m|--man|-w|--web] [COMMAND]
>> +'git help' [-a|--all] [-g|--guide]
>> +    [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
>>
>>  DESCRIPTION
>>  -----------
>>
>> -With no options and no COMMAND given, the synopsis of the 'git'
>> +With no options and no COMMAND|GUIDE given, the synopsis of the 
>> 'git'
>
> Please avoid BNF in the prose meant for human consumption unless
> necessary.  I think you can just say " or " here.

OK
>
>>  command and a list of the most commonly used Git commands are 
>> printed
>>  on the standard output.
>>
>>  If the option '--all' or '-a' is given, then all available commands 
>> are
>>  printed on the standard output.
>>
>> -If a Git subcommand is named, a manual page for that subcommand is 
>> brought
>> -up. The 'man' program is used by default for this purpose, but this
>> -can be overridden by other options or configuration variables.
>> +If the option '--guide' or '-g' is given then, a list of the useful
>> +Git guides is also printed on the standard output.
>
> s/given then,/given, then/ or just s/ then// make it easier to
> follow?  I personally would vote for doing s/given, then/given, /
> for the previous paragraph on "--all" as well.

Agreed.
>
>> -Note that `git --help ...` is identical to `git help ...` because 
>> the
>> +If a Git subcommand, or a Git guide, is given, a manual page for 
>> that
>
> "If the name of a command or a guide is given" without "Git/git"
> would be much easier to read, especially when the first paragraph
> talks about "COMMAND or GUIDE".  I also think s/command/subcommand/
> in the synopsis and in the first paragraph may be good for consistency
> with this part.

OK
>
>> +subcommand is brought up. The 'man' program is used by default for 
>> this
>> +purpose, but this can be overridden by other options or 
>> configuration
>> +variables.
>> +
>> +Note that 'git --help ...' is identical to 'git help ...' because 
>> the
>>  former is internally converted into the latter.
>>
>> +To display the linkgit:git[1] man page use 'git help git'.
>
> s/man page use/man page, use/;

Yes.
>
>> +
>> +This page can be displayed with 'git help help' or 'git help --help'
>> +
>>  OPTIONS
>>  -------
>>  -a::
>>  --all::
>>  Prints all the available commands on the standard output. This
>> - option supersedes any other option.
>> + option overides any given command or guide name.
>> +
>> +-g::
>> +--guides::
>> + Prints a list of useful guides on the standard output. This
>> + option overides any given command or guide name.
>
> Thanks. Overall this round looks a lot more manageable than the
> previous one.
>

Thanks. It'll be a few days (or maybe more) for the update.

[My Linux laptop (for checking everything) was just pressed into service 
for my son's university studies while his regular one is in repair]

Philip 
