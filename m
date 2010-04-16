From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st level sections in uppercase
Date: Fri, 16 Apr 2010 14:46:16 +0300
Organization: Private
Message-ID: <8739yvsjqv.fsf@jondo.cante.net>
References: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>
	<4BC81975.9000907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 13:46:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2k0J-0004wL-JF
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 13:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170Ab0DPLqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 07:46:22 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:34886 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab0DPLqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 07:46:21 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 3E76D8C8AC;
	Fri, 16 Apr 2010 14:46:19 +0300 (EEST)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A043B839C64; Fri, 16 Apr 2010 14:46:19 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 938B1404C;
	Fri, 16 Apr 2010 14:46:16 +0300 (EEST)
In-Reply-To: <4BC81975.9000907@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 16 Apr 2010 10:01:57 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145061>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> jari.aalto@cante.net venit, vidit, dixit 15.04.2010 17:37:
>
>> From: Jari Aalto <jari.aalto@cante.net>
>> 
>> 
>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>> ---
>>  Documentation/git-send-email.txt |   36 ++++++++++++++++++++++++++++++++++--
>>  1 files changed, 34 insertions(+), 2 deletions(-)
>> 
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index ced35b2..8b33eb0 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -299,8 +299,40 @@ sendemail.confirm::
>>  	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
>>  	in the previous section for the meaning of these values.
>>  
>> +EXAMPLES
>> +--------
>>  
>> -Author
>> +To batch send all patches to a mailig list, no copies to oneself,
>> +messages in a relaxed single thread format (no nesting) and don't ask
>> +any confirmations:
>
> That sentence is linguistically screwed, but...

Please improve. How would you explain the options and their explanations
one-by-one as presented below?

>> +
>> +	git send-email \
>> +		--from $EMAIL \
>> +		--to address@list.example.com \
>> +		--suppress-cc=author \
>> +		--suppress-from \
>> +		--no-chain-reply-to \
>> +		--confirm=never \
>> +		outgoing/
>> +
>
> ... I don't think this is a good example at all. All options are
> explained in the man page, so what is the point in listing and
> explaining some of them here?

Right, all the 31 options.

> If we really want an introductory example,
> we want one with few options, where the default behaviour is explained.

I don't agree.

We need examples that use most of the options in combination so that the
examples can practically "copy pasted / sliced off". The user can eaily
reduce options he may not find useful from the examples.

    With too few options presented, he needs to skim through the whole
    of 31 option explanations above and pray he finds what he needs.

Please suggest another example to be accompanied with this one. How do
you use the git-send-email? What options? What you have configured in
~/.gitconfig?

Jari
