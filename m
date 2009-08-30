From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in layman terms
Date: Mon, 31 Aug 2009 02:06:49 +0300
Organization: Private
Message-ID: <87ab1gaol2.fsf@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jari.aalto@cante.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 01:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhtV3-0005P1-63
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 01:07:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbZH3XG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 19:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754216AbZH3XG4
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 19:06:56 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45203 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZH3XGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 19:06:55 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 8533918D013;
	Mon, 31 Aug 2009 02:06:56 +0300 (EEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0461383166; Mon, 31 Aug 2009 02:06:56 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3C907E51A4;
	Mon, 31 Aug 2009 02:06:52 +0300 (EEST)
In-Reply-To: <7vskf954sr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Aug 2009 15:13:08 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127444>

Junio C Hamano <gitster@pobox.com> writes:

> Sections that are common in all manual pages (e.g. NAME, SYNOPSIS,
> DESCRIPTION, EXAMPLES, SEE ALSO) are often spelled in and referred to in
> caps. 

Not just common ones. All sections that are top level heading are best
spelled out consistently. Examples can be found from the URL to
POSIX/Susv in my other post.

[I'll get back to the CAPS patch in anaother post if we can sort this out]

> See http://www.kernel.org/pub/software/scm/git/docs/git-add.html#_interactive_mode
> for what I mean.

I think the convention used in git's manual pages deviate from the
standard practise. We could make the git manual pages into line of:

- write all the first level headings in all caps: "HEADING LIKE THIS"
- write second level heading: start Upper-lower: "Heading like this"

Cf. rsync(1), ssh(1) etc. many pages prior git's existense.

>>> I personally think fixing misworded phrase "initial command loop" would be
>>> sufficient.  It should read "initial command menu".  Perhaps like this.
>>>
>>> 	Run ``add --interactive``, but bypass the initial command menu and
>>> 	directly jump to `patch` subcommand.  See ``Interactive mode'' for
>>> 	details.
>>
>> It's still too technical. The 1st line should go right into business:
>>
>>  	Patch each file on command line interactively. This is this is
>>  	the same as ``add --interactive``, but bypass the initial
>>  	command menu and directly jump to `patch` subcommand. See
>>  	``Interactive mode'' for details.
>
> I do not think it is better than the original.

Your proposal that starts:

    ...but bypass the initial command menu

Mine:

    Patch each file on command line interactively

The first line should somehow strike immediately what the command does.
I would like to see a suggestion that has 'patch(ing)' somewhere at the
very first row. I hope we can find compromise.

Jari
