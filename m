From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 16:32:56 +0200
Organization: Private
Message-ID: <k5ln4eef.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
	<tzks5d8d.fsf@blue.sea.net> <m3tzks6qfm.fsf@localhost.localdomain>
	<ejbv6813.fsf@blue.sea.net> <m3prvf7ku2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: asciidoc-discuss@lists.metaperl.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 15:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLJRl-0005xo-5G
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 15:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbYBBOdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 09:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbYBBOdo
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 09:33:44 -0500
Received: from main.gmane.org ([80.91.229.2]:49299 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753888AbYBBOdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 09:33:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLJR7-0004N5-Iw
	for git@vger.kernel.org; Sat, 02 Feb 2008 14:33:41 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 14:33:41 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 14:33:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:Ds1X6dwtpb8nSsm8D8SIVY37TLY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72278>

* Sat 2008-02-02 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m3prvf7ku2.fsf@localhost.localdomain
>>>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html
>> 
>>     4. Frequently, names of parameters that _require_ substitution(...)
>> 
>>         <parameter name>
>
> Excuse me, but item is "required" if it is not marked (...)
> Angle brackets does not mean required parameters. Please read
> carefully; they denote parameters which _require substitution_ (note
> those _two_ words together), i.e. parameters that the user need to
> replace with appropriate input.

We're talking about the same subject. You emphasize the "substitution"
aspect, which by nature of the context, is inherently present. If you
read your paragraph, you also conclude "required" -- which I emphasised
initially.

SYNOPSIS dyntax:

    command option

Is inherently same as by spelling it more stronger:

    command <option>

But different from

    command "option"

The reason why I might be inclined to be on for angles is that they are
commonly used in BNF, and thus familiar to many:

    <A> ::= <B> <C>

>>> Note that in the POSIX/SUSV below parentheses / curly braces are not
>>> mentioned.
>> 
>> True. The precedence of curlies has however been set long ago in
>> software books and in other Unix manaul pages.
>
> I have checked a bit of manual pages (in Linux), and only very few use
> this convention. Do you have any statistics?

If you have ever skimmed Unix program book manuals, say before Linux, in
the Unix era, the industry quite feruently used angle curlies:

    command [<options>] {save|load}

Even today the braces are used to say "you must choose". E.g. in Oracle's
SQL manuals. This is quite self explanatory for the basic SQL:

    SELECT [DISTINCT] {*, column [AS ["<alias>"]], ...}
    FROM   <table>
    ;

>>>> -----------------------------------------------------------------------
>>>> http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap01.html#tag_01_11
>>>> 
>>>> 12.1 Utility Argument Syntax
>>>> http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html#tag_12_01
>>>> 
>>>>     [...]
>>>> 
>>>>     4. Frequently, names of parameters that **require** substitution by
>>>>     actual values are shown with embedded underscores. Alternatively,
>>>>     parameters are shown as follows:
>>>> 
>>>>         <parameter name>
>>>> 
>>>>     The angle brackets are used for the symbolic grouping of a phrase
>>>>     representing a single parameter and conforming applications shall
>>>>     not include them in data submitted to the utility.
>>>
> Again: it is required if it is not optional. There is no notation for
> required parts, except that they are not marked as optional. In the
> "cmd <file>" it is not angle brackets around <file> that denotes that
> this parameter is requires, it is lacks of "[" "]" brackets around
> parameter that tells it.
>
>>     command <arg> <arg>
>>     command <arg> [<message>]
>>     command <arg> [-lbc]
>> 
>> The <message> here is symbolic and not to be taken literally, whereas
>> text that is not eclosed inside angles, "-lbc", is to be taken
>> literally and interpreted by the rules of "set of options".
>
> All true. And all what I wanted to tell.

I think we both read the instructions the same way. Perhaps our views do
not differ. I'd be surprised, because that's the convention people are
used to having read the notations so long.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
