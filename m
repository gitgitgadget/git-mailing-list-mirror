From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 07:25:45 -0800 (PST)
Message-ID: <m38x23753j.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
	<tzks5d8d.fsf@blue.sea.net> <m3tzks6qfm.fsf@localhost.localdomain>
	<ejbv6813.fsf@blue.sea.net> <m3prvf7ku2.fsf@localhost.localdomain>
	<k5ln4eef.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 16:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLKGG-0005VB-1b
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 16:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764303AbYBBPZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764462AbYBBPZs
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 10:25:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:13476 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763080AbYBBPZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 10:25:47 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2099836wxd.4
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=HyTvXC94cu76HH6lKSIBGvA7CR4WjcSESNm7wYt2bEA=;
        b=jzOJOijP6GBbuHBC3/jYiPSnoS9+kxNc/KovHVwR87DAGC/alW4Y/HatV/ZQdaQCtM2plewY0kfjgDF3YTTNqfalgah40BKwJAKKLCselOxyO9czWVs4UVzHpjSp6b3HsYF7mfd+wY5FE0tIsxDJhLmhelbb2cicE23DDPD6NvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=MQ0Lmh8F7VxAyHAtFIrRbd9U/++F+rT24fKSGpu2t+tWoRFayDAywDs8Ar58tc81J++aiipaqK+kGnzqQ1n0XT82oZujaQSml24X3U9AkY2EqAzM5mzRFRCtiUM3F8I/qi6fLEywn1BXSK8yB3i7R73CR788lOgrAN06wC58c3w=
Received: by 10.150.192.7 with SMTP id p7mr1942830ybf.159.1201965946551;
        Sat, 02 Feb 2008 07:25:46 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id c5sm173020nfi.2.2008.02.02.07.25.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 07:25:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m12FPb29006224;
	Sat, 2 Feb 2008 16:25:38 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m12FPaAj006220;
	Sat, 2 Feb 2008 16:25:36 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <k5ln4eef.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72280>

Jari Aalto <jari.aalto@cante.net> writes:

> * Sat 2008-02-02 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m3prvf7ku2.fsf@localhost.localdomain
>>>>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html
>>> 
>>>     4. Frequently, names of parameters that _require_ substitution(...)
>>> 
>>>         <parameter name>
>>
>> Excuse me, but item is "required" if it is not marked (...)
>> Angle brackets does not mean required parameters. Please read
>> carefully; they denote parameters which _require substitution_ (note
>> those _two_ words together), i.e. parameters that the user need to
>> replace with appropriate input.
> 
> We're talking about the same subject. You emphasize the "substitution"
> aspect, which by nature of the context, is inherently present. If you
> read your paragraph, you also conclude "required" -- which I emphasised
> initially.

No, I would not.  The fact that the parameter _requires substitution_
(is placeholder) is orthogonal (independent) of the fact if the
parameter is required or optional.  Angle brackets (and italic or
underline) means "placeholder", while lack of angle brackets (and
bold) means "literal".  Square brackets means "optional", while lack
of brackets means "required"

> SYNOPSIS syntax:
> 
>     command option
> 
> Is inherently same as by spelling it more stronger:
> 
>     command <option>
> 
> But different from
> 
>     command "option"

I would say that in

      command option

the 'option' string is literal, while in

      command <option>

you have to substitute actual option in the place of '<option>'.
I don't think that "option" for literals is used in SYNOPSIS in
manpages, even if this notation is used elsewhere (BNF, RFC).

>>>> Note that in the POSIX/SUSV below parentheses / curly braces are not
>>>> mentioned.
>>> 
>>> True. The precedence of curlies has however been set long ago in
>>> software books and in other Unix manual pages.
>>
>> I have checked a bit of manual pages (in Linux), and only very few use
>> this convention. Do you have any statistics?
> 
> If you have ever skimmed Unix program book manuals, say before Linux, in
> the Unix era, the industry quite frequently used angle curlies:
> 
>     command [<options>] {save|load}

>From what I can see in Linux manuals usually this is dealt by either
relying on generic placeholders, and describing optional parts in
detailed description, e.g.

      tar <operation> [options]

or by splitting synopsis into separate lines, each line dealing with
alternate syntax, e.g.

       install [OPTION]... SOURCE DEST           (1st format)
       install [OPTION]... SOURCE... DIRECTORY   (2nd format)
       install -d [OPTION]... DIRECTORY...       (3rd format)

But in some cases using alternates which are not optional (i.e. not 
[ A | B | C ]) is a better solution. In some cases grouping is natural
and does not need delimiters, for example "--opt=A|B", but in some
cases delimiters are required, either "(-d | -D)" or "{-d | -D}"

> Even today the braces are used to say "you must choose". E.g. in Oracle's
> SQL manuals. This is quite self explanatory for the basic SQL:
> 
>     SELECT [DISTINCT] {*, column [AS ["<alias>"]], ...}
>     FROM   <table>
>     ;

I'm just more used to "(a | b)" from regular expressions, and AFAIK
also BNFs, and "{a,b}", with comma ',' instead of vertical bar '|' to
denote alternates (mutually exclusive parts), like in [some] shell
globing, and in above documentation example.

This will be last post from me in this sub-thread. I think we have
exhausted this part of discussion...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
