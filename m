From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Documentation: fix typos, grammar, asciidoc syntax
Date: Sat, 20 Dec 2008 22:39:10 +0200
Message-ID: <87tz8yponl.fsf@iki.fi>
References: <200812191314.19302.markus.heidelberg@web.de>
	<7v3agj1gvp.fsf@gitster.siamese.dyndns.org>
	<200812201418.38707.markus.heidelberg@web.de>
	<7v3agiy5gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8cp-0001mz-En
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYLTUjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Dec 2008 15:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYLTUjV
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:39:21 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43771 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181AbYLTUjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:39:20 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48FC5AC902CAF7A6; Sat, 20 Dec 2008 22:39:17 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LE8bO-0001C8-RT; Sat, 20 Dec 2008 22:39:10 +0200
In-Reply-To: <7v3agiy5gs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 20 Dec 2008 12\:08\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103664>

Junio C Hamano (2008-12-20 12:08 -0800) wrote:

> Markus Heidelberg <markus.heidelberg@web.de> writes:
>
>> Junio C Hamano, 20.12.2008:
>>> Markus Heidelberg <markus.heidelberg@web.de> writes:

>>> > -$ git show-branch --reflog=3D'10,1 hour ago' --list master
>>> > +$ git show-branch --reflog=3D"10,1 hour ago" --list master

>>> Is this just a personal taste, or a correction to typography?
>>
>> When using single quotes, the manpage displayed backticks.
>
> It does not seem to do that to me:

The single quote (') in asciidoc turns into \' in the man page
typesetting language and its meaning is acute accent (=B4, U+00B4). In
Ascii-only environment \' is displayed as a single quote but it is stil=
l
logically an acute accent. For example, my UTF-8 terminals as well as
Postscript output (man -Tps) display \' as acute accent.

To get the logical single quote the man page source should contain \(aq
or \[aq] . Don't know how to make asciidoc do this.
