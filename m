From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Sat, 02 Feb 2008 04:00:34 +0200
Organization: Private
Message-ID: <tzks5d8d.fsf@blue.sea.net>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net> <m33asc94xn.fsf@localhost.localdomain>
	<k5lo716v.fsf@blue.sea.net> <m3y7a46vmf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 03:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL7ha-0005Av-Rs
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 03:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbYBBCBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 21:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbYBBCBW
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 21:01:22 -0500
Received: from main.gmane.org ([80.91.229.2]:57678 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbYBBCBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 21:01:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JL7gv-0000TC-8s
	for git@vger.kernel.org; Sat, 02 Feb 2008 02:01:13 +0000
Received: from a91-155-183-103.elisa-laajakaista.fi ([91.155.183.103])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 02:01:13 +0000
Received: from jari.aalto by a91-155-183-103.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 02:01:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-183-103.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:LMQ9Dkwuvh0udYq0lpa/7MgrCbM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72206>

* Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
* Message-Id: m3y7a46vmf.fsf@localhost.localdomain
> It seems that I was mistaken about that. Junio suggestion of following
> others example and using "{}" curly brackets for grouping alternate
> choices is IMHO a good solution.

That is another common syntax which I presented previously.

> The traditional manpages use /italics/ (usually rendered as
> _underlined_ text on terminals) to denote placeholders (user supplied
> input).

That does not matter. The text should stand out as it it in environment,
which do not render termcap or other terminal capabilities.

> From http://www.linux.com/articles/34212

Here are the POSIX/Susv guidelines for the manual pages, I've marked the
relevant points with **....**. We were both right: Angles mean required
and grouping.

I think Git's manual pages should follow standard notation. E.g. the
use of parentheses should be replaced with curly braces.

Jari

-----------------------------------------------------------------------
http://www.opengroup.org/onlinepubs/009695399/utilities/xcu_chap01.html#tag_01_11

12.1 Utility Argument Syntax
http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html#tag_12_01

    [...]

    4. Frequently, names of parameters that **require** substitution by
    actual values are shown with embedded underscores. Alternatively,
    parameters are shown as follows:

        <parameter name>

    The angle brackets are used for the symbolic grouping of a phrase
    representing a single parameter and conforming applications shall
    not include them in data submitted to the utility.

    [...]
    7. Arguments or option-arguments enclosed in the '[' and ']'
    notation are **optional** and can be omitted. Conforming applications
    shall not include the '[' and ']' symbols in data submitted to the
    utility.

    8. Arguments separated by the '|' vertical bar notation are
    **mutually-exclusive.**

    9. Ellipses ( "..." ) are used to denote that one or **more**
    occurrences of an option or operand are allowed. When an option or
    an operand followed by ellipses is enclosed in brackets, **zero** or
    more options or operands can be specified.

        utility_name [-g option_argument]...[operand...]
