From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 15:06:57 +0200
Organization: Private
Message-ID: <1w7w966m.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 14:08:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKvd2-0005xV-Ks
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 14:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760052AbYBANHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760018AbYBANHs
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 08:07:48 -0500
Received: from main.gmane.org ([80.91.229.2]:48716 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760032AbYBANHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 08:07:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JKvcG-0005zj-6R
	for git@vger.kernel.org; Fri, 01 Feb 2008 13:07:36 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 13:07:36 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 13:07:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:KHT9Ysv+RUr9w34EiLJ7juu90Sk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72170>

* Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m37iho9b70.fsf@localhost.localdomain
>
>
> 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
> 'git-stash' [save [<message>...]]
>
> Angle brackets if I understand correctly are meant to denote part
> which you have to enter, the user supplied info (the reast ou have to
> enter literally).

Nowhere I have seen "(" parenheses to mean "required". The angle
brackets are commonly used to tell that the part is to be required:

    command <option> <file ...>

Reads:

    command -l file.txt

Whereas this has no known meaning:

    command (option) <file ...>

But this does:

    command [option] <file ...>

That's why I suggested to use:

    git stash <list | show [<stash>] | apply [<stash>] | clear>
    git stash [save [<message>...]]

The nesting of <'s is normal. The above reads:

    1st line: You have to select one command, one of the alternatives
    listed inside <...>: either "list", "show" ...

    2nd line: you can type 'git stash', 'git stash save' or supply
    additional message with the stash.

NOTE:

There exists curly braces notation that is sometimes used for
"required" part, but that not very common elsewhere other than
printed books from commercial vendors.

    command {one|two|three}

I would hesitate to select parentheses notation, which is relatively unknown
to mean "required" in the context of command syntax SYNOPSIS.

>> Welcome to FOSS revolution: we fix and modify until it shines
>
> Nice one. Can I add it to http://git.or.cz/gitwiki/FortuneCookies ?

Sure,
Jari
