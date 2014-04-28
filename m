From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 28 Apr 2014 12:16:09 +0200
Message-ID: <535E2A69.30600@alum.mit.edu>
References: <5343A589.10503@alum.mit.edu>	<CAP8UFD0RftewWj-oivojUrXCDqXUq6xX7ndQdixA2i=1BzZEFg@mail.gmail.com>	<534414FB.6040604@alum.mit.edu> <20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	johan@herland.net, josh@joshtriplett.org, tr@thomasrast.ch,
	dan.carpenter@oracle.com, greg@kroah.com, peff@peff.net,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk,
	jrnieder@gmail.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weibm-0002AI-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbaD1KQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 06:16:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63357 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755016AbaD1KQP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 06:16:15 -0400
X-AuditID: 12074414-f79d96d000002d2b-9c-535e2a6e19e1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 82.32.11563.E6A2E535; Mon, 28 Apr 2014 06:16:14 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E29.dip0.t-ipconnect.de [79.201.110.41])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3SAG9Qd016318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 28 Apr 2014 06:16:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140425.230710.1024850359228182788.chriscool@tuxfamily.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUgTYRznubudp3lyTs3HGYazMqVZQsEFGlZ+uCzEXEb0tk693HA77W4T
	55cmSpFptDDNKWUaJgZF0otlUQ21DMtlBmopmlk5XyIEizDtzmH67ff8f288/P8EqizCVYSB
	N3MCzxrVuA+m9EoM1/DRx7VbbD0xdPM3O0p/rCpG6Yn5Sowu6T2P0LayXpR+W3sF0FcHHyP0
	Qm0OPdV/A9C/i0tRurWiFqe7JgsB/aIjJIFkHjkGvZie8V84MzARz0yNpDA/xwYw5mvZE8C8
	64lgRu2vFEz9cBJTPrSgYG4Ou72YmeawFN/Dq+LSWXOe1pDFb95xYpW+aWRGkTtqym//+x63
	gYaDJcCbgNRWeNnRrvDg1dA1dAcvAT6EknoP4IMfI4jn0Y3AV59e4rKKpKJg+fj3RQdGrYfn
	Kt8uYpzSwLrSIslAEEFUKpx7E+6R+8POqi+YjAOpGNjvqEflTJRqROBszzQqEwHUUegYv63w
	lHUB+LRlctHhTSXBP8VFQA6FVDAsLUyVxyi1CU5fGEY9eC18OFWDXgT+jhV9jhUyxwpZLUCb
	QBhrtJg0JtZgFLkMjZjB8jwnaOgYk8Ecw2VamoFniYEtoK0zzAkoAqh9yUM1x7RKBZsnWk1O
	EEIg6iCyf+NxrdIvPSfTqmdFvU6wGDnRCSCBqgPJZ1DiyEzWWsAJOUtUKIGpg8nZ+shkJZXF
	mrlsjsvlhCV2DUGoIbkhSjL6C1wWl3/SYDQv0wjhLYf7qAJFjs/kBNZi1uvkDetEacUy5Sv1
	xsp2UsxlTdLUY30NNITL1liMKDE+h+dUwaQrUhJRskhv4f9XLN2uGwRLPw4gSTnK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247267>

On 04/25/2014 11:07 PM, Christian Couder wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
>>>>> +OPTIONS
>>>>> +-------
>>>>> +--trim-empty::
>>>>> +     If the 'value' part of any trailer contains only whitespace,
>>>>> +     the whole trailer will be removed from the resulting message.
>>>>
>>>> Does this apply to existing trailers, new trailers, or both?
>>>
>>> Both.
>>>
>>>> If it applies to existing trailers, then it seems a bit dangerous, in the
>>>> sense that the command might end up changing trailers that are unrelated
>>>> to the one that the command is trying to add.
>>>
>>> The command is not just for adding trailers.
>>> But there could be an option to just trim trailers that are added.
>>
>> Maybe that should be the *only* behavior of this option.
>>
>> Maybe there should be a trailer.<token>.trimEmpty config option.
> 
> One possible usage of the "git interpret-trailers" command that was
> discussed in the early threads was the following:
> 
> 1) You have a commit message template like the following:
> 
> -----------------
> ***SUBJECT***
> 
> ***MESSAGE***
> 
> Fixes: 
> Cc: 
> Cc: 
> Reviewed-by: 
> Reviewed-by: 
> Signed-off-by: 
> -----------------
> [...etc...]

Thanks for the explanation.  Now the --trim-empty option makes a lot
more sense.

>>>> If a commit message containing trailer lines with separators other than
>>>> ':' is input to the program, will it recognize them as trailer lines?
>>>
>>> No, '=' and '#' are not supported in the input message, only in the output.
>>>
>>>> Do such trailer lines have to have the same separator as the one listed
>>>> in this configuration setting to be recognized?
>>>
>>> No they need to have ':' as a separator.
>>>
>>> The reason why only ':' is supported is because it is the cannonical
>>> trailer separator and it could create problems with many input
>>> messages if other separators where supported.
>>>
>>> Maybe we could detect a special line like the following:
>>>
>>> # TRAILERS START
>>>
>>> in the input message and consider everyhting after that line as trailers.
>>> In this case it would be ok to accept other separators.
>>
>> It would be ugly to have to use such a line.  I think it would be
>> preferable to be more restrictive about trailer separators than to
>> require something like this.
> 
> The code is already very restrictive about trailer separators.
> 
>> From what you've said above, it sounds like your code might get confused
>> with the following input commit message:
>>
>>     This is the human-readable comment
>>
>>     Foo: bar
>>     Fixes #123
>>     Plugh: xyzzy
>>
>> It seems to me that none of these lines would be accepted as trailers,
>> because they include a non-trailer "Fixes" line (non-trailer in the
>> sense that it doesn't use a colon separator).
> 
> Yeah, they would not be accepted because the code is very restrictive.
> 
> The following would be accepted:
> 
>      Foo: bar
>      Fixes: 123
>      Plugh: xyzzy
> 
>>>> I suppose that there is some compelling reason to allow non-colon
>>>> separators here.  If not, it seems like it adds a lot of complexity and
>>>> should maybe be omitted, or limited to only a few specific separators.
>>>
>>> Yeah, but in the early threads concerning this subject, someone said
>>> that GitHub for example uses "bug #XXX".
>>> I will have a look again.
>>
>> Yes, that's true: GitHub recognizes strings like "fixes #33" but not if
>> there is an intervening colon like in "fixes: #33".  OTOH GitHub
>> recognizes such strings wherever they appear in the commit message (they
>> don't have to be in "trailer" lines).  So I'm not sure that the added
>> complication is worth it if GitHub is the only use case.  (And maybe we
>> could convince GitHub to recognize "Fixes: #33" if such syntax becomes
>> the de-facto Git standard for trailers.)
> 
> I don't think there is a lot of complexity.
> But maybe I need to explain how it works better.
> Feel free to suggest me sentences I could add.

I am really excited about having better support for trailers in Git, and
I want to thank you for your work.  For me the promise of trailers is

* A way for users to add information to commits for whatever purpose
  they want, without having to convince upstream to built support in.

* A standard format for that information, so that all tools can agree
  how to read/write trailers without being confused by or breaking
  trailers that they didn't know about in advance.

* A format that is straightforward enough that it can be machine-
  readable with minimum ambiguity.

* Some command-line tools to make it easy for scripts to work with
  trailers, and that serve as a reference implementation that other
  Git implementations can imitate.  For example, I totally expect that
  we will soon want a command-line tool for inquiring about the
  presence and contents of trailers, for use in scripting.  Eventually
  we will want to be able to do stuff like

      git trailers --get-all s-o-b origin/master..origin/next
      git rev-list --trailer=s-o-b:gitster@pobox.com master
      git trailers --pipe --draft \
          --add-first fixes \
          --append '# You can delete the following line:' \
          --append s-o-b:"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" \
          --unset private
      git trailers --pipe --verify --tidy-up

I think it is really important to nail down the format of trailers
tightly enough that everybody who reads/writes a commit message agrees
about exactly what trailers are there.  For example the specification
might look something like:

    A commit message can optionally end with a block of trailers.
    The trailers, if present, must be separated from the rest of the
    commit message by one or more blank lines (lines that contain only
    whitespace).  There must be no blank lines within the list of
    trailers.  It is allowed to have blank lines after the trailers.

    Each trailer line must match the following Perl regular
    expression:

        ^([A-Za-z0-9_-]+)\s*:\s*(.*[^\s])\s*$

    The string matching the first group is called the key and the string
    matching the second is called the value.  Keys are considered to be
    case-insensitive [or should they be case-sensitive?].  The
    interpretation of values is left entirely up to the application.
    Values must not be empty.

    However, in --draft and --cleanup modes, empty values *are*
    allowed, as are comments (lines starting with `core.commentchar`)
    within the trailer block.  In --draft mode such lines are passed
    through unchanged, and in --cleanup mode such lines are removed.

I'm not saying this is the exact definition that we want; I'm just
providing an example of the level of precision that I think is needed.

With regard to the separator character, my concern is not about how to
document the rules for this one tool.  It's more about having really
well-defined rules that are consistent between reading and writing.  For
me it seems silly to let "git interpret-trailers" output trailers that
it doesn't know how to read back in, and pretty much be a show-stopper
if the presence of such trailers makes the tool unable to read other
trailers in the same commit message.

So my preference would be to make the format of trailers really strict;
for example, only allowing colon separators as in the regexp above.
People who want to work with trailers using Git tools will just have to
conform to this format.

But if we must support flexibility in the separator characters, then I
think it is important that we be able to read whatever we can write.
For me this means:

* Enumerating a list of allowed separators (e.g., [:=#])

* Specifying how it is decided what separator to use when generating
  new trailers

* Specifying what appends when a trailer is read and then written again:
  is its separator preserved, or is the trailer converted to use the
  separator configured for that particular key in the config.  And if
  the latter, what happens if a key's separator is not configured?

* Specifying whether whitespace around a separator is adjusted when
  reading then writing a trailer.  For example, is

      Foo SP SP : HT bar SP

  canonicalized to

      Foo: SP bar

  (SP=space, HT=tab)?  What about

      Fixes SP #33

  ?  What if the separator for the "fixes" key is not configured?

The reason that I prefer supporting only colons is that more flexibility
inevitably raises lots of questions like this, makes the documentation
and implementation more complicated, and makes it harder for other
implementations to be sure they agree 100% with the reference
implementation.

>>>>> +With `addIfDifferent`, a new trailer will be added only if no trailer
>>>>> +with the same (token, value) pair is already in the message.
>>>>> ++
>>>>> +With `addIfDifferentNeighbor`, a new trailer will be added only if no
>>>>> +trailer with the same (token, value) pair is above or below the line
>>>>> +where the new trailer will be added.
>>>>> ++
>>>>> +With `add`, a new trailer will be added, even if some trailers with
>>>>> +the same (token, value) pair are already in the message.
>>>>> ++
>>>>> +With `overwrite`, the new trailer will overwrite an existing trailer
>>>>> +with the same token.
>>>>
>>>> What if there are multiple existing trailers with the same token?  Are
>>>> they all overwritten?
>>>
>>> No, if where == after, only the last one is overwritten, and if where
>>> == before, only the first one is overwritten.
>>>
>>> I could add an "overwriteAll" option. It could be interesting to use
>>> when a command using "$ARG" is configured, as this way the command
>>> would apply to all the trailers with the given token instead of just
>>> the last or first one.
>>
>> It seems to me that the current behavior (rewriting exactly one existing
>> line) is not that useful.  Why not make "overwrite" overwrite *all*
>> existing matching lines?
> 
> I was thinking that people could use the following template message:
> 
> ---------------
> Signed-off-by: 
> Signed-off-by: YOU-WILL-BE-AUTOMATICALLY-ADDED-HERE
> ---------------
> 
> and the following config:
> 
> ---------------
> [trailer "s-o-b"]
> 	 key = "Signed-off-by: "
> 	 ifexist = overwrite
> 	 command = echo \"$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>\"
> ---------------
> 
> This way the user can add other people's s-o-b before the last one
> which will always contain his own s-o-b.

That seems fragile.  For example, if the user changes the lines to

    Signed-off-by: Somebody Else <...>

(deleting the "YOU-WILL-BE" line, maybe because they don't want to sign
off the commit) then not only will their wish be contradicted, but also
Somebody Else would be deleted.

What about allowing a --draft option, which allows blank trailer values
plus comments interspersed in the trailer lines?  (I.e., the equivalent
of --trim-empty could be the default and --draft would turn it off plus
allow interspersed comments.)  Then the template could be

    # You can add one or more Signed-off-by lines for other people here.
    # A Signed-off-by line for you will be appended automatically when
    # you commit.
    Signed-off-by:

Or, even better:

    # You can add one or more Signed-off-by lines here:
    Signed-off-by:
    Signed-off-by:
    # You can delete the following line if you don't want it:
    Signed-off-by: Me <me@example.com>

; i.e., the Signed-off-by line for the author could be filled in
*before* the user is asked to edit the commit message.  There could also
be a --cleanup mode that allows blank values and comments on input but
removes them from the output.

> [...]

Given Git's requirements for backwards compatibility, a specification
that we release now will have to be supported forever (because it will
be baked into commits and can *never* be changed), and any
trailer-handling tools that we release now will have to be supported for
years (until at least Git 3.0).

All in all, I think that there has been a lot of discussion about the
interface of this one command, "git interpret-trailers", including its
quite complicated configuration and a command-line behavior.  And yet it
seems to me that not many Git developers have been very engaged in the
conversation, and Junio (who has) still doesn't seem satisfied with it.
 I (though among the too-little engaged) have the feeling that it is
still a ways from maturity.

On the contrary, the data format and semantics of the finished trailers
seem to have gotten too little attention, even though they are simpler
to define and even more important than the interface of the command used
to manipulate trailers.

I think it would be really helpful to have a careful specification of
the data format, and make sure that everybody agrees on what we want.
For example, I think it is crucial that the trailers can be read and
written unambiguously.

Once that's clear, it will be a lot easier to be sure that the tool(s)
for working with trailers conform to the specification.

Even then, I think it might be prudent to mark "git interpret-trailers"
as "experimental" and/or put it under "contrib" rather than among the
main Git commands for a couple of releases.  Luckily, it is very loosely
coupled to the rest of Git, so I don't see any urgency to having it in
core [1].  After people have had time to experiment with it, then it
could be moved to core.

Michael

[1] Having the script in contrib would also make it possible to
implement it use a scripting language to make it easier to iterate on
the design.  When the details are agreed it could have been
reimplemented in C.  But I guess that ship has already sailed.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
