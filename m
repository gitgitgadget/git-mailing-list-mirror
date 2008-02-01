From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 00:37:44 +0200
Organization: Private
Message-ID: <k5lo716v.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 23:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL4XO-0001MA-2V
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 23:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063AbYBAWif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 17:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761385AbYBAWie
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 17:38:34 -0500
Received: from main.gmane.org ([80.91.229.2]:55400 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761356AbYBAWic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 17:38:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JL4Wf-0000pv-BI
	for git@vger.kernel.org; Fri, 01 Feb 2008 22:38:25 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 22:38:25 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 22:38:25 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:uTrYHetLKiw1OoZZdPczsWcRG1A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72186>

* Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m33asc94xn.fsf@localhost.localdomain
> Jari Aalto <jari.aalto@cante.net> writes:
>
>> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
>> * Message-Id: m37iho9b70.fsf@localhost.localdomain
>> >
>> >
>> > 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
>> > 'git-stash' [save [<message>...]]
>> >
>> > Angle brackets if I understand correctly are meant to denote part
>> > which you have to enter, the user supplied info (the reast ou have to
>> > enter literally).
>> 
>> Nowhere I have seen "(" parenheses to mean "required". 
>
> The "(" parentheses does not mean "required". They do mean "group",
> just like for regular expressions. So "A (B | C)" means "A B" or
> "A C".

In regexp language yes, but in describing the command syntaxes, I do not
have come accross this. Would you have descriptive examples?

>> The angle brackets are commonly used to tell that the part is to be
>> required:
>> 
>>     command <option> <file ...>
> No, the "<" angle brackets are meant to denote: substitute your own
> (user) input, and not use as literal value. So "command <option>"
> mean select one of options ant put it in place of "<option>"

The angles primarily denote "required", and secondarily that you put
there there the asked input.


>       command (subcmd1 | subcmd2) <file ...>

Tat is highly uncommon. In angle bracket notation this is unabiguous:

        command <parameter1|parameter2> <file ...>
                A                       B

In angles, it's clear that both A and B are required; in A, you must
choose one.

> The "[" brackets mean both "optional" and "group" (to reduce number of
> parentheses-like operators).

The bracket's primary meaning is to say "optional" in command
definitions. They do not "group"; they nest -- saying that there are
more "optionality" included.

>> That's why I suggested to use:
>> 
>>     git stash <list | show [<stash>] | apply [<stash>] | clear>
>>     git stash [save [<message>...]]
>
> I hope that I have explained above why I think it is wrong. IMHO the
> "<" angle brackets mean: substitute your own input, and are not meant
> for grouping (limiting where alternates start and where end).

Angle brackets do not mean "substitute your own input", but they deonote
a requirement; how the requirement is filled is done according to the
description in the documentation.

    command <"save"|"load">

In unabiguous way to say that the choices for words are "save" and
"load" of which one of them must be supplied.

The reason why angle angles are used is that they are shell redirection
metacharacters --- which never appear in that quality in standard manual
page SYNOPSIS. The angles cannot be understood in any other way than as
a "requirement" in the command definition.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
