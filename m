From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [RFC] send-email aliases when editing patches or using --xx-cmd
Date: Thu, 4 Jun 2015 20:47:13 -0400
Message-ID: <CAJ80sav_w9cFLkYAWUh-iGuV-9uG8c8gGjxF_V-QW=UA6ww4oQ@mail.gmail.com>
References: <87pp5b1b4g.fsf@ensimag.grenoble-inp.fr>
	<CAGZ79ka89omT3wKqV-J4eyAz+xDXDS+OBcXDDFsO=4kk1HBBpQ@mail.gmail.com>
	<CAPig+cQbOnaNg8dkbFoRrUN47oEAxUNjRXhMK1HSgCLi6ZxHyQ@mail.gmail.com>
	<299923407.139591.1433458411117.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<CAJ80savyruj7rcwGRY6AURJWnm26AyQFjssJmpjuYcv5jEBqkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:47:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0fn4-0002OC-Lm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 02:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbbFEArO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 20:47:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34404 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbFEArO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 20:47:14 -0400
Received: by iebmu5 with SMTP id mu5so12739677ieb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 17:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1MxshC6NFdoPyGFQ9yAESbPovcZlCc6SI7U+lMgB42g=;
        b=R0XF9aFHI/PCLAgMUBLiGEKs7sxIUdcKiRuzpL/s4clGZMW7B+MORtl80bCrKOBz61
         YMY7JEDiC4UQl5D3OvAnZ7zalSxZY9SIvPqrEZe2cHb634xrNPpJSZqsP7ncezl5gmnJ
         NkwvjQ33HAAUxs61aEYIol1qnUA21wfbMDLMhU4zBi5kQynuPA1j8PDaaT4Boe77pb0H
         KKgniCqfmf1qOyczJpOR8YGW70jjezlF1U5MEU5Pz5MevqKHVzebaiWaY8aNd0QGP7Le
         w5VPHzC4QCIQzytQKJITHuUm/0TcJiUtBMcN1AnwEknA+bvucOLQsWxogAZ7/D+xQWnz
         PFjQ==
X-Received: by 10.107.8.208 with SMTP id h77mr942896ioi.51.1433465233621; Thu,
 04 Jun 2015 17:47:13 -0700 (PDT)
Received: by 10.79.84.6 with HTTP; Thu, 4 Jun 2015 17:47:13 -0700 (PDT)
In-Reply-To: <CAJ80savyruj7rcwGRY6AURJWnm26AyQFjssJmpjuYcv5jEBqkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270810>

On Thu, Jun 4, 2015 at 8:38 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> On Thu, Jun 4, 2015 at 6:53 PM, Remi Lespinet
> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>> On Thu, Jun 4, 2015 at 1:17 PM, Remi LESPINET
>> <remi.lespinet@ensimag.grenoble-inp.fr> wrote:
>>>
>>> Hi,
>>>
>>> Working on git-send-email, I've seen that there's no aliases support
>>> when manually adding a recipient in a 'To' or 'Cc' field in a patch
>>> and for the --to-cmd and --cc-cmd.
>>>
>>> I would like to add this support, and I wonder if there are reasons
>>> not to do it.
>>>
>>> Thanks.
>>
>> I just realize that I totally messed up, Of course I don't want to add
>> To or Cc fields to patches.
>>
>> In fact I want to add aliases support for --to-cmd and --cc-cmd options.
>> But the modification depends on wheter we can use aliases in fields
>> used by send-email (such as author or signoff-by..) when manually
>> editing a patch or not.
>>
>> Sorry for this mistake :(
>
> You are right that Signed-off-by: myAlias wouldn't make sense, but is
> that really what you intended to propose?  It's definitely not a good
> idea to write patches that way, but on the other hand, if git happens
> to accept an alias there, what's the harm?  Git will send an email...
> the patch will be rejected.
>
> Also, I believe git-send-email looks for signed-off-by, regardless of
> the presence or output of to-cmd (around line 1490 -- "Now parse the
> message body").
>

I don't see any harm to accepting aliases in the /header/ portion of
the patch, either.  Those are not part of the commit message, and git
will reformat all the headers before actually sending the email,
anyway.

Again, this is not the same as to-cmd.  Note that git-send-email
parses the header fields regardless of to-cmd.

> Something like to-cmd is much more general than just looking for
> Signed-off-by, etc, or scanning a patch for things that look like
> email addresses.  The to-cmd can also look for keywords in the patch,
> like component names, and return an array of maintainer email
> addresses for those components, for instance.  It might be the case
> that none of the emails returned by the to-cmd are actually ever
> explicitly mentioned in the patch.  In my workspace, I might indeed
> write a script, specify it as the to-cmd, and have the script return
> an array of email addresses according to whatever criteria I can
> imagine.  What's the harm if, in my script, in my own workspace, I
> return an array of email aliases in the to_cmd, instead?
>
> Now, as long as the to-cmd is already a script, executed by the
> computer, there's really very little to gain in using email aliases
> versus whole email addresses.  A script can emit a whole properly
> formatted email address just as easily as it can emit an email alias.
>
> Your proposal is just a different use for email aliases, which is
> independent from where the aliases come from.  There is no conflict
> with any of the email alias parsers.
