From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 01:45:50 -0800 (PST)
Message-ID: <m3prvf7ku2.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
	<tzks5d8d.fsf@blue.sea.net> <m3tzks6qfm.fsf@localhost.localdomain>
	<ejbv6813.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srackham@methods.co.nz,
	asciidoc-discuss@lists.metaperl.com,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 10:46:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLExR-0005VH-0X
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbYBBJp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759591AbYBBJp6
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:45:58 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:27828 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759278AbYBBJpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:45:55 -0500
Received: by ug-out-1314.google.com with SMTP id z38so877025ugc.16
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=D6zAhfsrTIREjftGh3sSWNl24myh0tCuGob/EF52L6I=;
        b=pNHeqbMaAjnvPesBYvZPPNqDsJbNxb6cTFBAWrgwB6yNNRNBy9qv1xv5FK0FCUVUMKIX5xnZ7YPA9g2LXzBs6yNHcdePR2hcQM3LLmHervhYAOypBF+kop2RWbtqrG9bnYmvCicinaTdnVRa+OdMTVkkqgDGWRtGOeg6NGbrnes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=PWIAysLW5nW2M5yBPgkH8yIw4nHGuoDg6zMAfl2oUanVD+pHy1lGj/B3Koqa72rnSXitlTRHBWIUeSccrDxTjvEzj5JoKDN6Qjs+iogX/+r31OLre18ExEGcpJJDBehsuIoKHiDQlBbvis75NTffnJ6iRzvw7GeWs1xVHr+USeM=
Received: by 10.67.122.10 with SMTP id z10mr6560311ugm.44.1201945552331;
        Sat, 02 Feb 2008 01:45:52 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id 13sm4637614ugb.0.2008.02.02.01.45.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 01:45:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m129jjuh026312;
	Sat, 2 Feb 2008 10:45:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m129jfRi026308;
	Sat, 2 Feb 2008 10:45:41 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <ejbv6813.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72241>

Jari Aalto <jari.aalto@cante.net> writes:

> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m3tzks6qfm.fsf@localhost.localdomain
> 
>>> he text should stand out as it it in environment,
>>> which do not render termcap or other terminal capabilities.
>>
>> Nevertheless it would be nice if our AsciiDoc configuration generated
>> italics or underline ...for manpage, and italics for HTML output for
>> placeholders, *in addition* to using angle parentheses (angle braces)
>> as delimites for placeholder parameters.
> 
> Sure, let's notify the asciidoc maintainer know about the wishes (CC'd)

Errr... I'm not sure if it is generic enough.  Although the POSIX/Susv
you have quoted. together with man(7) / manpage(5) pages I have quoted
seems to tell that it is so: POSIX/Susv talks about using angle
brackets to denote placeholders (to be substituted), man/manpage talks
about using italics/underline to denote placeholders.

So to say: I'm interested what AsciiDoc maintainers would say to that.
I have added asciidoc-discuss to Cc:, but please cull it (and the
asciidoc maintainer) from the Cc: list when replying.

>>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html
>>>
>>> Here are the POSIX/Susv guidelines for the manual pages, I've marked the
>>> relevant points with **....**. We were both right: Angles mean required
>>> and grouping.
>>
>> Errr... as far as I understand angles means placeholders, i.e. user
>> supplied input. You can use "[<file>...]" for optional placeholder;
>> everything which is not inside brackets is required.
> 
> If you choose to use the "optional", then you are _required_ to fill in
> the mentioned item. The "[....]" is applied in your example as well. The
> angles always keep it's nature, which is a requirement:
> 
>     4. Frequently, names of parameters that _require_ substitution(...)
> 
>         <parameter name>

Excuse me, but item is "required" if it is not marked (by brackets, or
by listing it as one of alternate calling conventions in separate
lines) as "optional". So both in "cmd -A" and in "cmd <file>"
parameters '-A' (literal) and '<file>' (to be substituted by filename)
are required parameters, while both in "cmd [-A]" and in 
"cmd [<file>]" appropriate parameters are optional.

Angle brackets does not mean required parameters. Please read
carefully; they denote parameters which _require substitution_ (note
those _two_ words together), i.e. parameters that the user need to
replace with appropriate input.

>> It is used quite frequently in git manpages. Using parentheses to
>> delimit required alternate parts seems quite sensible.
>>
>>   'git-branch' (-m | -M) [<oldbranch>] <newbranch>
> 
> The change is small, but important. People look at the manual paged any
> will get the wrong impression on "the standard notation"
> 
>     'git-branch' {-m | -M} [<oldbranch>] <newbranch>
>                  =       =
>                  Change to use curlies

Perhaps. This I guess needs some discussion.

Nevertheless if / when we decide to change to this notation to delimit
parts of alternates / mutually exclusive parts, we would want to do
this in patch which changes only that, but changes it everywhere.

>> Note that in the POSIX/SUSV below parentheses / curly braces are not
>> mentioned.
> 
> True. The precedence of curlies has however been set long ago in
> software books and in other Unix manaul pages.

I have checked a bit of manual pages (in Linux), and only very few use
this convention. Do you have any statistics?

>>> -----------------------------------------------------------------------
>>> http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap01.html#tag_01_11
>>> 
>>> 12.1 Utility Argument Syntax
>>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html#tag_12_01
>>> 
>>>     [...]
>>> 
>>>     4. Frequently, names of parameters that **require** substitution by
>>>     actual values are shown with embedded underscores. Alternatively,
>>>     parameters are shown as follows:
>>> 
>>>         <parameter name>
>>> 
>>>     The angle brackets are used for the symbolic grouping of a phrase
>>>     representing a single parameter and conforming applications shall
>>>     not include them in data submitted to the utility.
>>
>> This means that <param> denotes placeholder: parameter that requires
>> **subsititution** (this part should be emphasized!). Such parameter
>> might have multi-word name. Such parameter might be required, but
>> might be optional.
> 
> It's never optional. For optionality, there is specific notation.

Again: it is required if it is not optional. There is no notation for
required parts, except that they are not marked as optional. In the
"cmd <file>" it is not angle brackets around <file> that denotes that
this parameter is requires, it is lacks of "[" "]" brackets around
parameter that tells it.

> Everybody knows how to read these; what is required and what is not:
> 
>     command <arg> <arg>
>     command <arg> [<message>]
>     command <arg> [-lbc]
> 
> The <message> here is symbolic and not to be taken literally, whereas
> text that is not eclosed inside angles, "-lbc", is to be taken
> literally and interpreted by the rules of "set of options".

All true. And all what I wanted to tell.

>> Note that is natural that '[' and ']' also are limits of mutualy
>> exclusive parameters: "cmd [ A | B ]" means "cmd" or "cmd A" or "cmd B".
> 
> We are in all agreement on this one.

Good.
 
>>>     9. Ellipses ( "..." ) are used to denote that one or **more**
>>>     occurrences of an option or operand are allowed. When an option or
>>>     an operand followed by ellipses is enclosed in brackets, **zero** or
>>>     more options or operands can be specified.
>>> 
>>>         utility_name [-g option_argument]...[operand...]
>>
>> Note that one is not followed strictly, and one should take note of
>> that. For example to make sure that everybody knows that it is zero or
>> more one would use [<param>...], and to make use that it is one or
>> more one would use "<param> [<param>...]", just to be sure.
> 
> That's what it says. Outside of "[]" the ellipses mean (1+), indiside
> "[]", by rules of the brackets, it means (0+). I forgot to paste the
> two examples. Here:
> 
>     utility_name -f option_argument...[operand...]
>     utility_name [-g option_argument]...[operand...]

Ooops. Sorry. This time *I* haven't read this carefully enough.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
