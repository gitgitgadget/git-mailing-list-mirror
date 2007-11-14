From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 12:04:05 -0800
Message-ID: <7v4pfoh9vu.fsf@gitster.siamese.dyndns.org>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com>
	<Pine.LNX.4.64.0711141717570.4362@racer.site>
	<622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOTT-0000lo-53
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756527AbXKNUEO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756272AbXKNUEO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:04:14 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39202 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbXKNUEN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 15:04:13 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3029B2F0;
	Wed, 14 Nov 2007 15:04:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7520F95BDD;
	Wed, 14 Nov 2007 15:04:29 -0500 (EST)
In-Reply-To: <622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com> (Wincent
	Colaiuta's message of "Wed, 14 Nov 2007 20:00:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65004>

Wincent Colaiuta <win@wincent.com> writes:

> El 14/11/2007, a las 18:19, Johannes Schindelin escribi=C3=B3:
>
>> Besides, is it really necessary to be as explicit as you word it?
>> IOW is
>> this patch needed?
>
> I was basically just trying to help new people from making the same
> mistake that I did; ie. not knowing if there was an official limit,
> looking at the maximum line length in a file, making sure my patch
> didn't exceed that length (and re-wrapping to avoid exceeding it), an=
d
> then getting reprimanded for gratuitous re-wrapping.

Sorry about that "reprimanded" part.  I should have been more
careful -- I did not really mean it that way.  It was more like
"it would have been nicer ... so please try to next time".

I know how stressful a life is for a contributor new to a
project.  You not only need to make sure the meat of your change
is good, but worry about the technicalities, such as the
presentation and style, the tone of the proposed log message
that addresses other peoples efforts you are building on; in
short, finding out the lay of the land, making yourself blend
well in the comminity.

We have a great way to quickly tell if somebody is new to the
project (i.e. "git shortlog --author=3DWincent master").  I should
use it more often and adjust my tone accordingly.  It's only
fair for me to do so when the new person surely is trying hard
to do his part.

> diff --git a/Documentation/CodingGuidelines b/Documentation/
> CodingGuidelines
> index 3b042db..d2d1f32 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -58,8 +58,6 @@ For C programs:
>   - We use tabs to indent, and interpret tabs as taking up to
>     8 spaces.
>
> - - We try to keep to at most 80 characters per line.
> -
>   - When declaring pointers, the star sides with the variable
>     name, i.e. "char *string", not "char* string" or
>     "char * string".  This makes it easier to understand code

I agree that "80 columns" sits better in that new "Line
wrapping" section.  I wonder if "tabs are 8 spaces wide" also
belong there.

> @@ -110,3 +108,14 @@ For C programs:
>     used in the git core command set (unless your command is clearly
>     separate from it, such as an importer to convert random-scm-X
>     repositories to git).
> +
> +Line wrapping:
> +
> + - We generally try to keep scripts, C source files and AsciiDoc
> +   documentation within the range of "80 columns minus some slop"
> +   to accommodate diff change marks [-+ ] and quoting ">> " in
> +   emails.
> +
> + - When submitting patches use common sense to decide whether to
> +   rewrap (or reindent), avoiding gratuitous changes.
> +
