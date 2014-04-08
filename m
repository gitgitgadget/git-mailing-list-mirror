From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 08 Apr 2014 17:25:47 +0200
Message-ID: <534414FB.6040604@alum.mit.edu>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>	<20140406170204.15116.15559.chriscool@tuxfamily.org>	<5343A589.10503@alum.mit.edu> <CAP8UFD0RftewWj-oivojUrXCDqXUq6xX7ndQdixA2i=1BzZEFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 17:26:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXXuT-0001ED-FL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 17:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbaDHPZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 11:25:57 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48243 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756382AbaDHPZy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 11:25:54 -0400
X-AuditID: 12074412-f79d46d000002e58-d7-53441501dbd1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C9.12.11864.10514435; Tue,  8 Apr 2014 11:25:53 -0400 (EDT)
Received: from [192.168.69.148] (p5B156B83.dip0.t-ipconnect.de [91.21.107.131])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s38FPlfv025676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Apr 2014 11:25:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <CAP8UFD0RftewWj-oivojUrXCDqXUq6xX7ndQdixA2i=1BzZEFg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0gUURTGufPYHXVHruNjryYrbYSUrmWITFFRYjU9EB//hJY26egu7Y4y
	s1saBIpCsGpYmNUapT0wzNQks7KSrCylfPQAHylKaWQpRJRJWc24mP537vm+7/y4nEPhTIEm
	iLKIdkESeatR40kw2tjlJuAfm7T20kQA2/TxJM4OnSvC2c9/zhCs800xxuaXvsHZ7qqzgL0w
	fA9j/1Zls1MDVwD7s6gEZ1srqjTsiy8FgH3UEbiF5u66hrXcq08zGm7w8yZuaiye+zo+SHAT
	pfcB1/dqBff+5HOSuzy6iysf+UtyNaOTWu5bkyFel+y18SBvP5xkyRLXbD7gZa4cmyJzTqXm
	Fv7oxfLBl51O4EEhGIVaS4tIdx2AekcaNE7gSTHwNUCtN/u07kc3huq+3wNOQFE0DEND5Xo1
	QMCVaNZZOx/WQBO6VFKIqRZ/mIh+v1yutmnogzrPfSDU2g9GovO/rsyPxGEhgVo6pnFV8IX7
	kOtTPelm9QP04E/bPMsDJqC+6QS1RFCPSgoSVTsOw9H0iVHcXYeglqnzeBnwcS3BuZbYXEts
	VQCvBQbe6rCZbLzFKgvpJjmdF0VBMkVH2Cz2CCHD0QTcK2TugIZOQzuAFDDq6NwnMUkMyR+W
	82ztIJDCjP50nW9sEuN9MDsjz8zL5jTJYRXkdoAo3OhHz3krGp3B5x0VpOwFaRlFGPX07OXQ
	OAZm8XbhkCDkCNKCGkxRRkQf81OCPpKQJeRmWqz2RRmjPNThnkF+siBmCBLvsJvT1P2mycqC
	VUmncPPUOC3n8Dal6452ARPVeLuuAGMIMVsUgvQ0rZqgajI7xP+IhcudBHrlx750 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245928>

On 04/08/2014 01:35 PM, Christian Couder wrote:
> On Tue, Apr 8, 2014 at 9:30 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> How are existing trailers recognized in the input commit message?  Do
>> trailers have to be configured to be recognized?  Or are all lines
>> matching a specific pattern considered trailers?  If so, it might be
>> helpful to include a regexp here that describes the trailer "syntax".
> 
> The trailers are recognized in the input commit message using the
> following rules:
>  - only lines that contains a ':' are considered trailers,
>  - the trailer lines must all be next to each other,
>  - after them it's only possible to have some lines that contain only spaces,
>  - before them there must be at least one line with only spaces

Thanks for all the explanation.  I think that most/all of this
information should be included in the documentation.

>>> +OPTIONS
>>> +-------
>>> +--trim-empty::
>>> +     If the 'value' part of any trailer contains only whitespace,
>>> +     the whole trailer will be removed from the resulting message.
>>
>> Does this apply to existing trailers, new trailers, or both?
> 
> Both.
> 
>> If it applies to existing trailers, then it seems a bit dangerous, in the
>> sense that the command might end up changing trailers that are unrelated
>> to the one that the command is trying to add.
> 
> The command is not just for adding trailers.
> But there could be an option to just trim trailers that are added.

Maybe that should be the *only* behavior of this option.

Maybe there should be a trailer.<token>.trimEmpty config option.

>>> +CONFIGURATION VARIABLES
>>> +-----------------------
>>> +
>>> +trailer.<token>.key::
>>> +     This 'key' will be used instead of 'token' in the
>>> +     trailer. After some alphanumeric characters, it can contain
>>
>> Trailer keys can also contain '-', right?
> 
> Yes.
> I should have written "after the last alphanumeric character".
> I will fix that.
> 
>>> +     some non alphanumeric characters like ':', '=' or '#' that will
>>> +     be used instead of ':' to separate the token from the value in
>>> +     the trailer, though the default ':' is more standard.
>>
>> Above it looks like the default separator is not ':' but rather ': '
>> (with a space).  Is the space always added regardless of the value of
>> this configuration variable, or should the configuration value include
>> the trailing space if it is desired?  Is there any way to get a trailer
>> that doesn't include a space, like
>>
>>     foo=bar
>>
>> ?  (Changing this to "foo= bar" would look pretty ugly.)
> 
> I will have a look, but I think that:
> 
> - a space is always added after ':' or '=',
> - a space is never added after '#',
> - it doesn't matter if there is a space or not in the configured key.
> 
>> If a commit message containing trailer lines with separators other than
>> ':' is input to the program, will it recognize them as trailer lines?
> 
> No, '=' and '#' are not supported in the input message, only in the output.
> 
>> Do such trailer lines have to have the same separator as the one listed
>> in this configuration setting to be recognized?
> 
> No they need to have ':' as a separator.
> 
> The reason why only ':' is supported is because it is the cannonical
> trailer separator and it could create problems with many input
> messages if other separators where supported.
> 
> Maybe we could detect a special line like the following:
> 
> # TRAILERS START
> 
> in the input message and consider everyhting after that line as trailers.
> In this case it would be ok to accept other separators.

It would be ugly to have to use such a line.  I think it would be
preferable to be more restrictive about trailer separators than to
require something like this.

>From what you've said above, it sounds like your code might get confused
with the following input commit message:

    This is the human-readable comment

    Foo: bar
    Fixes #123
    Plugh: xyzzy

It seems to me that none of these lines would be accepted as trailers,
because they include a non-trailer "Fixes" line (non-trailer in the
sense that it doesn't use a colon separator).

>> I suppose that there is some compelling reason to allow non-colon
>> separators here.  If not, it seems like it adds a lot of complexity and
>> should maybe be omitted, or limited to only a few specific separators.
> 
> Yeah, but in the early threads concerning this subject, someone said
> that GitHub for example uses "bug #XXX".
> I will have a look again.

Yes, that's true: GitHub recognizes strings like "fixes #33" but not if
there is an intervening colon like in "fixes: #33".  OTOH GitHub
recognizes such strings wherever they appear in the commit message (they
don't have to be in "trailer" lines).  So I'm not sure that the added
complication is worth it if GitHub is the only use case.  (And maybe we
could convince GitHub to recognize "Fixes: #33" if such syntax becomes
the de-facto Git standard for trailers.)

>>> +trailer.<token>.where::
>>> +     This can be either `after`, which is the default, or
>>> +     `before`. If it is `before`, then a trailer with the specified
>>> +     token, will appear before, instead of after, other trailers
>>> +     with the same token, or otherwise at the beginning, instead of
>>> +     at the end, of all the trailers.
>>
>> Brainstorming: some other options that might make sense here someday:
>>
>> `end`: add new trailer after all existing trailers (even those with
>> different keys).  This would allow trailers to be kept in chronological
>> order.
>>
>> `beginning`: add new trailer before the first existing trailer (allows
>> reverse chronological order).
>>
>> `sorted`: add new trailer among the existing trailers with the same key
>> so as to keep their values in lexicographic order.
> 
> Yeah, I thought about these, but I don't think there is a need for
> them right now.

Yes, I didn't mean to imply that any of these options have to be in the
first version.

>>> +trailer.<token>.ifexist::
>>> +     This option makes it possible to choose what action will be
>>> +     performed when there is already at least one trailer with the
>>> +     same token in the message.
>>> ++
>>> +The valid values for this option are: `addIfDifferent` (this is the
>>> +default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
>>
>> Are these option values case sensitive?  If so, it might be a little bit
>> confusing because the same camel-case is often used in documentation for
>> configuration *keys*, which are not case sensitive [1], and users might
>> have gotten used to thinking of strings that look like this to be
>> non-case-sensitive.
> 
> There were some discussions a few versions of this series ago with
> Peff, Junio and perhaps others about this.
> I thought that being case insensitive was better and Peff kind of
> agreed with that, but as Junio disagreed it is now case sensitive.

OK, it's my fault for not having followed along with the history of this
patch series.

>>> +With `addIfDifferent`, a new trailer will be added only if no trailer
>>> +with the same (token, value) pair is already in the message.
>>> ++
>>> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
>>> +trailer with the same (token, value) pair is above or below the line
>>> +where the new trailer will be added.
>>> ++
>>> +With `add`, a new trailer will be added, even if some trailers with
>>> +the same (token, value) pair are already in the message.
>>> ++
>>> +With `overwrite`, the new trailer will overwrite an existing trailer
>>> +with the same token.
>>
>> What if there are multiple existing trailers with the same token?  Are
>> they all overwritten?
> 
> No, if where == after, only the last one is overwritten, and if where
> == before, only the first one is overwritten.
> 
> I could add an "overwriteAll" option. It could be interesting to use
> when a command using "$ARG" is configured, as this way the command
> would apply to all the trailers with the given token instead of just
> the last or first one.

It seems to me that the current behavior (rewriting exactly one existing
line) is not that useful.  Why not make "overwrite" overwrite *all*
existing matching lines?

>>> +With `doNothing`, nothing will be done, that is no new trailer will be
>>> +added if there is already one with the same token in the message.

I just noticed a punctuation problem (comma -> semicolon and add comma)
in the sentence above:

    With `doNothing`, nothing will be done; that is, no new trailer
    will be added if there is already one with the same token in the
    message.

>>> +
>>> +trailer.<token>.ifmissing::
>>> +     This option makes it possible to choose what action will be
>>> +     performed when there is not yet any trailer with the same
>>> +     token in the message.
>>> ++
>>> +The valid values for this option are: `add` (this is the default) and
>>> +`doNothing`.
>>> ++
>>> +With `add`, a new trailer will be added.
>>> ++
>>> +With `doNothing`, nothing will be done.
>>> +
>>> +trailer.<token>.command::
>>> +     This option can be used to specify a shell command that will
>>> +     be used to automatically add or modify a trailer with the
>>> +     specified 'token'.
>>> ++
>>> +When this option is specified, it is like if a special 'token=value'
>>> +argument is added at the end of the command line, where 'value' will
>>> +be given by the standard output of the specified command.
>>
>> Maybe reword to
>>
>>     When this option is specified, the behavior is as if a special
>>     'token=value' argument were added at the end of the command line,
>>     where 'value' is taken to be the standard output of the specified
>>     command.
>>
>> And if it is the case, maybe add "with leading and trailing whitespace
>> trimmed off" at the end of the sentence.
> 
> Ok.
> 
>>> +If the command contains the `$ARG` string, this string will be
>>> +replaced with the 'value' part of an existing trailer with the same
>>> +token, if any, before the command is launched.
>>
>> What if the key appears multiple times in existing trailers?
> 
> It will be done only once for the last or first trailer with the key
> depending on "where".

It seems like the UI for "git interpret-trailers" is optimized for
trailers that appear only once.  That's a bit limiting.  Maybe it would
be better to pipe the existing values to the command's standard input,
one per line?  For example, suppose we run

    git interpret-trailers \
        Signed-off-by='Christian Couder <christian.couder@gmail.com>'

with the following input:

    Human-readable subject

    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    Signed-off-by: Christian Couder <christian.couder@gmail.com>

Then the following three lines could be piped to the command (i.e., one
value per line, without the key):

    Junio C Hamano <gitster@pobox.com>
    Christian Couder <christian.couder@gmail.com>
    Christian Couder <christian.couder@gmail.com>

Then, supposing the command were "sort --unique", the command's output
would be

    Christian Couder <christian.couder@gmail.com>
    Junio C Hamano <gitster@pobox.com>

which would be converted back into trailer lines by prepending
"Signed-off-by: ", resulting in the modified commit message

    Human-readable subject

    Signed-off-by: Christian Couder <christian.couder@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

(Not that we would want to do with "Signed-off-by" trailers, but you get
the idea.)


I'm really sorry for coming so late to the show.  Feel free to ignore
any of my comments with the justification "too late".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
