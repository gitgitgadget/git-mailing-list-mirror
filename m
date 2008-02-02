From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 16:38:08 -0800 (PST)
Message-ID: <m3y7a46vmf.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 01:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL6Pd-0003lc-QI
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 01:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759039AbYBBAiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 19:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765876AbYBBAiR
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 19:38:17 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:7485 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765821AbYBBAiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 19:38:12 -0500
Received: by py-out-1112.google.com with SMTP id u52so1939819pyb.10
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 16:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=KwB2ukj4GMVWoY5A6Yy+evsm5gjylS1MJj4iG31qRlU=;
        b=INR2ATZF+r3SgS41aiuGjzzsMfJvQikwIaJso6gzU2pHj+BRseZRNKIusx/YDIa8GG7N7wXs4/C1NGGSuT3a4YWdn3BTi0vuTKsgAydwyheX0w6XLCQQQ8E1TVh9l+Km/H89C/hnbD5l3nqdpYeU3Kz14ADORIRTKbvEn7v1Zbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=tOINbYyFp2JC4AE75HM2lj6uAJIIkVZQqpyfY7eMasKKEaIRO9kQ6j/nw+SDSVEmGb/mmTOpLVwFtzbh3rwXP7q08gNpbhPT5mDRe2Xlaf/NFvym9lJGNmIXtY2kXEMrAKDj7wrll8Xn8hd09NSxKM3i0sxu78QKwUyQ7XG8MOg=
Received: by 10.65.95.12 with SMTP id x12mr6825043qbl.71.1201912691102;
        Fri, 01 Feb 2008 16:38:11 -0800 (PST)
Received: from localhost.localdomain ( [83.8.228.251])
        by mx.google.com with ESMTPS id d2sm10847529nfc.11.2008.02.01.16.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 16:38:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m120c2ce022797;
	Sat, 2 Feb 2008 01:38:03 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m120c0Uk022793;
	Sat, 2 Feb 2008 01:38:00 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <k5lo716v.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72197>

Jari Aalto <jari.aalto@cante.net> writes:

> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m33asc94xn.fsf@localhost.localdomain
>> Jari Aalto <jari.aalto@cante.net> writes:
>>
>>> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
>>> * Message-Id: m37iho9b70.fsf@localhost.localdomain
>>>>
>>>>
>>>> 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
>>>> 'git-stash' [save [<message>...]]
>>>>
>>>> Angle brackets if I understand correctly are meant to denote part
>>>> which you have to enter, the user supplied info (the reast ou have to
>>>> enter literally).
>>> 
>>> Nowhere I have seen "(" parenheses to mean "required". 
>>
>> The "(" parentheses does not mean "required". They do mean "group",
>> just like for regular expressions. So "A (B | C)" means "A B" or
>> "A C".
> 
> In regexp language yes, but in describing the command syntaxes, I do not
> have come accross this. Would you have descriptive examples?

It seems that I was mistaken about that. Junio suggestion of following
others example and using "{}" curly brackets for grouping alternate
choices is IMHO a good solution.

...or perhaps not. For example synopsis for git-branch uses this syntax.

>>> The angle brackets are commonly used to tell that the part is to be
>>> required:
>>> 
>>>     command <option> <file ...>
>>
>> No, the "<" angle brackets are meant to denote: substitute your own
>> (user) input, and not use as literal value. So "command <option>"
>> mean select one of options ant put it in place of "<option>"
> 
> The angles primarily denote "required", and secondarily that you put
> there there the asked input.

The "<>" angle brackets does not denote required. Not in git manpages,
not in other manpages.

>>       command (subcmd1 | subcmd2) <file ...>
> 
> That is highly uncommon. 

Perhaps, but is used in git manpages.

> In angle bracket notation this is unabiguous:
> 
>         command <parameter1|parameter2> <file ...>
>                 A                       B
> 
> In angles, it's clear that both A and B are required; in A, you must
> choose one.

THAT is highly uncommon.

>> The "[" brackets mean both "optional" and "group" (to reduce number of
>> parentheses-like operators).
> 
> The bracket's primary meaning is to say "optional" in command
> definitions. They do not "group"; they nest -- saying that there are
> more "optionality" included.

They do group. "command [A|B]" means "command" or "command A" or
"command B".

>>> That's why I suggested to use:
>>> 
>>>     git stash <list | show [<stash>] | apply [<stash>] | clear>
>>>     git stash [save [<message>...]]
>>
>> I hope that I have explained above why I think it is wrong. IMHO the
>> "<" angle brackets mean: substitute your own input, and are not meant
>> for grouping (limiting where alternates start and where end).
> 
> Angle brackets do not mean "substitute your own input", but they deonote
> a requirement; how the requirement is filled is done according to the
> description in the documentation.
> 
>     command <"save"|"load">
> 
> In unabiguous way to say that the choices for words are "save" and
> "load" of which one of them must be supplied.

In our (git) manual pages "<text>" denotes placeholders.

The traditional manpages use /italics/ (usually rendered as
_underlined_ text on terminals) to denote placeholders (user supplied
input).

I think we better decide on syntax used in SYNOPSIS section, and
perhaps even document it CodingGuidelines


-- >8 --

>From http://www.linux.com/articles/34212

  The SYNOPSIS section describes the usage of the command. In general,
  it should look very much like a traditional usage message. [...]
  By convention, optional arguments are surrounded by square brackets.

>From man(7)

  SYNOPSIS    briefly describes the command or function's  interface.   For
              commands,  this shows the syntax of the command and its argu-
              ments (including options); boldface is used  for  as-is  text
              and  italics  are  used  to  indicate  replaceable arguments.
              Brackets ([]) surround optional arguments, vertical bars  (|)
              separate  choices,  and  ellipses (...) can be repeated.

>From manpages(5), Darwin documentation

 MANUAL PAGE SYNTAX
     In manual page syntax, anything in a normal text font is required
     text.  Anything in a boldface font is a flag or a subcommand.
     Anything underlined is a user-specified argument such as a
     filename.

     Any argument surrounded by brackets is considered to be optional.
     For example, [ filename ] would indicate an optional filename
     argument.

     Flags, arguments, or subcommands separated by a vertical
     separator (|) are mutually exclusive.  For example, if -a turns
     on an option and -b turns off the option, the syntax for this
     command might be -a | -b.

     In some cases, you may even see entire groups of arguments
     wrapped with brackets and separated by a vertical separator. This
     is one way of show-ing showing ing that a command has more than
     one valid syntax.  In other manual pages, this is expressed by
     having multiple lines in the synopsis, each of which begins with
     the command name.  The separated format is more com-mon common
     mon (and more readable), but is not always possible for commands
     with particularly complex syntax.

     Finally, the most important notational convention is the use of
     the ellipsis (...).  This indicates that additional arguments may
     be added at this point.  Depending on the author, you may see
     this written in one of two ways:

     argument [ argument... ]

     argument...


Some SYNOPSIS examples (where we use the following convention:
*bold*, _underlined_):

  *patch* [_options_] [_originalfile_ [_patchfile_]]    (shows nesting)
  wget [_option_]... [_URL_]...                         (shows ellipsis)
  rpm {-q|--query} [select-options] [query-options]     (shows grouping)
  date [-u|--utc|--universal] [MMDDhhmm[[CC]YY][.ss]]   (alt + grouping)
  *kill [ -s* _signal_ *| -p ] [ -a ] [ -- ]* _pid_ ... (as above)

Inside yum(8), shows alternate which is also grouping
  * clean [ packages | headers | metadata | cache | dbcache | all ]


Some SYNOPISIS examples from git manpages, in AsciiDoc syntax (sources):

'git-add' [-n] [-v] [-f] [--interactive | -i] [--patch | -p] [-u] [--refresh]
          [--] <filepattern>...

'git-am' [--signoff] [--dotest=<dir>] [--keep] [--utf8 | --no-utf8]
         [--3way] [--interactive] [--binary]
         [--whitespace=<option>] [-C<n>] [-p<n>]
         <mbox>|<Maildir>...

'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
	  [--allow-binary-replacement | --binary] [--reject] [-z]
	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
	  [--whitespace=<nowarn|warn|fix|error|error-all>]
	  [--exclude=PATH] [--verbose] [<patch>...]

'git-branch' [--color | --no-color] [-r | -a]
	   [-v [--abbrev=<length> | --no-abbrev]]
	   [--contains <commit>]
'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
'git-branch' (-m | -M) [<oldbranch>] <newbranch>
'git-branch' (-d | -D) [-r] <branchname>...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
