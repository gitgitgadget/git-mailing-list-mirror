From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in layman terms
Date: Mon, 31 Aug 2009 00:56:19 +0300
Organization: Private
Message-ID: <87tyzp9da4.fsf@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 23:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhsO1-0006z9-5E
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152AbZH3V4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbZH3V4Y
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 17:56:24 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:43963 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537AbZH3V4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 17:56:24 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 8C2A7EF3EE;
	Mon, 31 Aug 2009 00:56:24 +0300 (EEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A007BE859ED; Mon, 31 Aug 2009 00:56:24 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 540CE1C6382;
	Mon, 31 Aug 2009 00:56:20 +0300 (EEST)
CC: jari.aalto@cante.net
In-Reply-To: <7vab1hdppb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Aug 2009 13:14:24 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127439>

Junio C Hamano <gitster@pobox.com> writes:

> Jari Aalto <jari.aalto@cante.net> writes:
>
>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>> ---
>>  Documentation/git-add.txt |   10 +++++-----
>>  1 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
>> index e67b7e8..71990c2 100644
>> --- a/Documentation/git-add.txt
>> +++ b/Documentation/git-add.txt
>> @@ -67,14 +67,14 @@ OPTIONS
>>  --interactive::
>>  	Add modified contents in the working tree interactively to
>>  	the index. Optional path arguments may be supplied to limit
>> -	operation to a subset of the working tree. See ``Interactive
>> -	mode'' for details.
>> +	operation to a subset of the working tree. See section
>> +	``INTERACTIVE MODE'' for details.
>
> It is not justified with your commit log message, I do not see why you
> have to shout in all CAPS, and there is no such section in the
> documentation.  But the "Interactive mode" section exists and is referred
> to by the original.

It is not shouting, but standard practise to refer to manual page
section in ALL CAPS, when they are top level headings, like in this
case.

>>  -p::
>>  --patch::
>> -	Similar to Interactive mode but the initial command loop is
>> -	bypassed and the 'patch' subcommand is invoked using each of
>> -	the specified filepatterns before exiting.
>> +	Run interactive patch command for each file on command line.
>> +	See section INTERACTIVE MODE and patch subcommand for more
>> +	information.
>
> I personally think fixing misworded phrase "initial command loop" would be
> sufficient.  It should read "initial command menu".  Perhaps like this.
>
> 	Run ``add --interactive``, but bypass the initial command menu and
> 	directly jump to `patch` subcommand.  See ``Interactive mode'' for
> 	details.

It's still too technical. The 1st line should go right into business:

 	Patch each file on command line interactively. This is this is
 	the same as ``add --interactive``, but bypass the initial
 	command menu and directly jump to `patch` subcommand. See
 	``Interactive mode'' for details.

Jari
