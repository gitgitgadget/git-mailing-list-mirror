From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-send-email.txt: Add EXAMPLES section. Write 1st level
 sections in uppercase
Date: Fri, 16 Apr 2010 15:04:31 +0200
Message-ID: <4BC8605F.5070306@drmicha.warpmail.net>
References: <1271345823-19685-1-git-send-email-jari.aalto@cante.net>	<4BC81975.9000907@drmicha.warpmail.net> <8739yvsjqv.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 16 15:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2lGm-0004Xg-GT
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 15:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab0DPNHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 09:07:35 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54165 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752555Ab0DPNHe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 09:07:34 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 544E9EA9E4;
	Fri, 16 Apr 2010 09:07:33 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 16 Apr 2010 09:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=l3V2P/3D9z3JVxZMo+xsY613IaE=; b=AySFZqInYjUNFkWj50l/fAoud5s57blKZvb4DPj/Vi9qlzfb0xVTWkgCxpnaWUdfgkbCNpM1Fg6JhHMm6w5QO/6ozNmknOiCC5XiOf9E+GoJ+fftfzLb9DS7RDhNDadrrXPSXiZ3kUfvq420Z9YMvi5LwyztZ4jsIgxB9RZGpXk=
X-Sasl-enc: p8CuVjMtV1VdQQvPdT+1WOj0wr6zBtEDbrO9e5v0ZOgg 1271423252
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 957F8A013;
	Fri, 16 Apr 2010 09:07:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <8739yvsjqv.fsf@jondo.cante.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145063>

Jari Aalto venit, vidit, dixit 16.04.2010 13:46:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> jari.aalto@cante.net venit, vidit, dixit 15.04.2010 17:37:
>>
>>> From: Jari Aalto <jari.aalto@cante.net>
>>>
>>>
>>> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
>>> ---
>>>  Documentation/git-send-email.txt |   36 ++++++++++++++++++++++++++++++++++--
>>>  1 files changed, 34 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>>> index ced35b2..8b33eb0 100644
>>> --- a/Documentation/git-send-email.txt
>>> +++ b/Documentation/git-send-email.txt
>>> @@ -299,8 +299,40 @@ sendemail.confirm::
>>>  	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
>>>  	in the previous section for the meaning of these values.
>>>  
>>> +EXAMPLES
>>> +--------
>>>  
>>> -Author
>>> +To batch send all patches to a mailig list, no copies to oneself,
>>> +messages in a relaxed single thread format (no nesting) and don't ask
>>> +any confirmations:
>>
>> That sentence is linguistically screwed, but...
> 
> Please improve. How would you explain the options and their explanations
> one-by-one as presented below?

By "but..." and the paragraph below I meant to say that there is no need
to pick on individual typos and such, because I don't favour the
approach anyways.

Looking at the send-email man page, I definitely agree with you that
there is room for improvement. For example, in the end there is a
configuration section listing only very few of the config options. The
reader could easily think these are the only ones. We tend to list them
in git-config's man page, which one may or may not like...

> 
>>> +
>>> +	git send-email \
>>> +		--from $EMAIL \
>>> +		--to address@list.example.com \
>>> +		--suppress-cc=author \
>>> +		--suppress-from \
>>> +		--no-chain-reply-to \
>>> +		--confirm=never \
>>> +		outgoing/
>>> +
>>
>> ... I don't think this is a good example at all. All options are
>> explained in the man page, so what is the point in listing and
>> explaining some of them here?
> 
> Right, all the 31 options.
> 
>> If we really want an introductory example,
>> we want one with few options, where the default behaviour is explained.
> 
> I don't agree.
> 
> We need examples that use most of the options in combination so that the
> examples can practically "copy pasted / sliced off". The user can eaily
> reduce options he may not find useful from the examples.
> 
>     With too few options presented, he needs to skim through the whole
>     of 31 option explanations above and pray he finds what he needs.
> 
> Please suggest another example to be accompanied with this one. How do
> you use the git-send-email? What options? What you have configured in
> ~/.gitconfig?

I don't use any options besides --dry-run and --cc, which is the point
of the config options ;) In config I have to, smtpserver (pointing to an
msmtp-script), bcc, suppresscc, aliasesfile, aliastype, but that depends
on the project, of course (git.git here).

I just think that using all these options on the command line is very
atypical. It would be helpful to see the defaults in one place:

"Without any options, send-email will send patches (using
/usr/sbin/sendmail or /usr/lib/sendmail or localhost) using any from, cc
and subject lines contained in the patch files; you have to specify at
least --to, or else you will be prompted for it.

All defaults pertaining to composing and sending of the patch mails and
to automating this process can be changed with config options, see the
corresponding sections below."

I liked your format-patch example with merge-base, I just liked it
better in format-patch's man page ;)

Michael
