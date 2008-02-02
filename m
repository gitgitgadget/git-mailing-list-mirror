From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 11:07:36 +0200
Organization: Private
Message-ID: <ejbv6813.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
	<tzks5d8d.fsf@blue.sea.net> <m3tzks6qfm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srackham@methods.co.nz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 10:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLENH-0005rQ-Qx
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 10:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761240AbYBBJIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765740AbYBBJIf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 04:08:35 -0500
Received: from main.gmane.org ([80.91.229.2]:51351 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932445AbYBBJIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 04:08:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLEMC-00077y-MF
	for git@vger.kernel.org; Sat, 02 Feb 2008 09:08:16 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 09:08:16 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 09:08:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:VPM+ZJgEHkDiPfu0a8aQ64mkFKw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72235>

* Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m3tzks6qfm.fsf@localhost.localdomain

>> he text should stand out as it it in environment,
>> which do not render termcap or other terminal capabilities.
>
> Nevertheless it would be nice if our AsciiDoc configuration generated
> italics or underline ...for manpage, and italics for HTML output for
> placeholders, *in addition* to using angle parentheses (angle braces)
> as delimites for placeholder parameters.

Sure, let's notify the asciidoc maintainer know about the wishes (CC'd)

>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html
>>
>> Here are the POSIX/Susv guidelines for the manual pages, I've marked the
>> relevant points with **....**. We were both right: Angles mean required
>> and grouping.
>
> Errr... as far as I understand angles means placeholders, i.e. user
> supplied input. You can use "[<file>...]" for optional placeholder;
> everything which is not inside brackets is required.

If you choose to use the "optional", then you are _required_ to fill in
the mentioned item. The "[....]" is applied in your example as well. The
angles always keep it's nature, which is a requirement:

    4. Frequently, names of parameters that _require_ substitution(...)

        <parameter name>

> It is used quite frequently in git manpages. Using parentheses to
> delimit required alternate parts seems quite sensible.
>
>   'git-branch' (-m | -M) [<oldbranch>] <newbranch>

The change is small, but important. People look at the manual paged any
will get the wrong impression on "the standard notation"

    git-branch {-m | -M} [<oldbranch>] <newbranch>
               =       =
               Change to use curlies

> Note that in the POSIX/SUSV below parentheses / curly braces are not
> mentioned.

True. The precedence of curlies has however been set long ago in
software books and in other Unix manaul pages.

>> -----------------------------------------------------------------------
>> http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap01.html#tag_01_11
>> 
>> 12.1 Utility Argument Syntax
>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html#tag_12_01
>> 
>>     [...]
>> 
>>     4. Frequently, names of parameters that **require** substitution by
>>     actual values are shown with embedded underscores. Alternatively,
>>     parameters are shown as follows:
>> 
>>         <parameter name>
>> 
>>     The angle brackets are used for the symbolic grouping of a phrase
>>     representing a single parameter and conforming applications shall
>>     not include them in data submitted to the utility.
>
> This means that <param> denotes placeholder: parameter that requires
> **subsititution** (this part should be emphasized!). Such parameter
> might have multi-word name. Such parameter might be required, but
> might be optional.

It's never optional. For optionality, there is specific notation.
Everybody knows how to read these; what is required and what is not:

    command <arg> <arg>
    command <arg> [<message>]
    command <arg> [-lbc]

The <message> here is symbolic and not to be taken literally, whereas
text that is not eclosed inside angles, "-lbc", is to be taken
literally and interpreted by the rules of "set of options".

>>     [...]
>>     7. Arguments or option-arguments enclosed in the '[' and ']'
>>     notation are **optional** and can be omitted. Conforming applications
>>     shall not include the '[' and ']' symbols in data submitted to the
>>     utility.
>> 
>>     8. Arguments separated by the '|' vertical bar notation are
>>     **mutually-exclusive.**
>
> Note that is natural that '[' and ']' also are limits of mutualy
> exclusive parameters: "cmd [ A | B ]" means "cmd" or "cmd A" or "cmd B".
> It is not specified explicitely, but IMHO is quite natural. And it is
> what is used in different manpages, see examples I have provided in my
> previous post in this subthread.

We are in all agreement on this one.

>>     9. Ellipses ( "..." ) are used to denote that one or **more**
>>     occurrences of an option or operand are allowed. When an option or
>>     an operand followed by ellipses is enclosed in brackets, **zero** or
>>     more options or operands can be specified.
>> 
>>         utility_name [-g option_argument]...[operand...]
>
> Note that one is not followed strictly, and one should take note of
> that. For example to make sure that everybody knows that it is zero or
> more one would use [<param>...], and to make use that it is one or
> more one would use "<param> [<param>...]", just to be sure.

That's what it says. Outside of "[]" the ellipses mean (1+), indiside
"[]", by rules of the brackets, it means (0+). I forgot to paste the
two examples. Here:

    utility_name -f option_argument...[operand...]
    utility_name [-g option_argument]...[operand...]

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
