From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] asciidoc: add minor workaround to add an empty line after code blocks
Date: Thu, 30 Oct 2008 14:56:15 +0200
Message-ID: <8763nautqo.fsf@iki.fi>
References: <87skqfus7v.fsf@iki.fi>
	<2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
	<87od13ujm4.fsf@iki.fi> <20081030104503.GA17131@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:57:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvX5j-0000qd-5N
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 13:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944AbYJ3M4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 08:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYJ3M4V
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 08:56:21 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55545 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944AbYJ3M4U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 08:56:20 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.inet.fi (8.5.014)
        id 48FC59C7008F7880; Thu, 30 Oct 2008 14:56:19 +0200
In-Reply-To: <20081030104503.GA17131@diku.dk> (Jonas Fonseca's message of "Thu\, 30 Oct 2008 11\:45\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99466>

Jonas Fonseca (2008-10-30 11:45 +0100) wrote:

> Insert an empty <simpara> in manpages after code blocks to force and
> empty line.

>  This is an old issue reported by Theodore Ts'o and fixed partially in
>  commit 63c97ce228f2d2697a8ed954a9592dfb5f286338 for the URL section
>  of the fetch/pull/push manpages. I have fixed this in tig using an
>  approach similar to the attached. Simple and clean, but only tested
>  with docbook-xsl version 1.72 so I have made it conditional.

Thanks. Your patch seems to work and code blocks look much nicer now. I
tested command-line "man" as well as Emacs' "M-x man" and "M-x woman".
I'm using docbook-xsl Debian package version 1.73.2.dfsg.1-4.

Another kind of formatting issue exists with some other example
commands, like in "git rebase" manpage, for example. Not that I care
that much, but here's an example. The asciidoc source (git-rebase.txt)
contains:

    then the command

        git rebase --onto topicA~5 topicA~3 topicA

    would result in the removal of commits F and G:

In final manpage output it looks like this:

    then the command                               

        git rebase --onto topicA~5 topicA~3 topicA 
    would result in the removal of commits F and G:
