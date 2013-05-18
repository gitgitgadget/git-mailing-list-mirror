From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Sat, 18 May 2013 17:26:01 -0500
Message-ID: <CAMP44s3kyPdUZXUvG7cR8HMKXvna57t7A_ZAFD5L8mu4M4OfYA@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	<7vk3my6bu1.fsf@alter.siamese.dyndns.org>
	<CAMP44s2W5MUneTwcSnr=Ey715paKgSL6MqXmYKdSmw4NqdL4qQ@mail.gmail.com>
	<7vk3my33vb.fsf@alter.siamese.dyndns.org>
	<CAMP44s0J7vcxno=v9_ewUE6FcuRVuYQhCNVS8D+AvP6cG2XNfQ@mail.gmail.com>
	<7vtxm1xxvd.fsf@alter.siamese.dyndns.org>
	<E74470E4201142788D36127322130401@PhilipOakley>
	<CAMP44s3oNyCzH=ySNuB0f6yn536S=pUKDETAhBOwk_siFn30EQ@mail.gmail.com>
	<2B281B554A864399824A4BCD613A819D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun May 19 00:26:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdpZp-0000gT-3G
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 00:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab3ERW0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 May 2013 18:26:04 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:56721 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab3ERW0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 May 2013 18:26:03 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so1179204lab.19
        for <git@vger.kernel.org>; Sat, 18 May 2013 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/XukOU1Dq1XgPgdYa6VsKVgtMEe1d8vl0CUKVh2RQNQ=;
        b=yoq9t+425McKRrPNoCzdX8HnlCoxOwCSjB889Q7kF4Cj6f4vM8o2Oht9zXZ8QyjPvx
         tzaTggPLX23Bn3UscxWbzpzP7lSNRz3G4DlmS7Nbi2a169pNfqB7cNChkkIUJO0DT+0h
         glY3NGafHOhWQpsrsQXctRCPz4MCJTvhz4FL1K+CkgHlBs2AriuYPEHGp2FEnq2NFEkz
         Xe/YY0sSYze82XViqF40MbF60z0O7GY4EeG3X8m6hj3mft7TsxwGaibsgBV6KCdZGyKN
         Eq4BoIYDUoI+WgnjITNl3fQt3+4s53aeBCXD5JTZMF15Jxh92EynIsqc5L0QUiCTrIV6
         GxiQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr25325430lbb.12.1368915961072;
 Sat, 18 May 2013 15:26:01 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sat, 18 May 2013 15:26:01 -0700 (PDT)
In-Reply-To: <2B281B554A864399824A4BCD613A819D@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224810>

On Sat, May 18, 2013 at 3:53 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> Sent: Saturday, May 18, 2013 3:23 PM
>>
>> On Sat, May 18, 2013 at 8:12 AM, Philip Oakley <philipoakley@iee.org>
>> wrote:
>>>
>>> From: "Junio C Hamano" <gitster@pobox.com>
>>> Sent: Friday, May 17, 2013 7:30 PM
>>> Subject: Re: [PATCH 1/3] fetch: add --allow-local option
>>>
>>> [...]
>>>
>>>
>>>> So when "the user" is running "git fetch" on "mywork" branch that
>>>> happens to be forked from a local "master", i.e. her configuration
>>>> is set as
>>>>
>>>> [branch "mywork"]
>>>>        remote = .
>>>>                merge = refs/heads/master
>>>>
>>>
>>> Was the '.' example illustrative rather than exact. I see no case of
>>> using
>>> '.' in my configs. Or am I completely missing the point? (e.g. that
>>> the use
>>> of '.' an example of possible future usage)?
>>
>>
>> % git checkout -t -b feature master
>> # work
>> % git rebase -i
>>
>> --
>> Felipe Contreras
>> --
>
>
> OK, I see it (the dot '.' in the config file) now.
>
> I've also located the documentation hidden at the end of git-config(1)
> under branch.<name>.merge, even though your worked example has it
> under remote not merge.
>    [branch "feature"]
>
>     remote = .
>     merge = refs/heads/master
>
> "If you wish to setup git pull so that it merges into <name> from
> another branch in the local repository, you can point
> branch.<name>.merge to the desired branch, and use the special setting .
> (a period) for branch.<name>.remote."

This is called the upstream branch. Go to any branch, and do this:

% git checkout feature
% git branch --set-upstream-to master

And it would set:

  remote = .
  merge = refs/heads/master

Now you can do things like:

% git log feature@{upstream}..feature

Which gets translated to:

% git log master..feature

And:

% git rebase -i

Which gets translated to:

% git rebase -i master

This is nothing new.

-- 
Felipe Contreras
