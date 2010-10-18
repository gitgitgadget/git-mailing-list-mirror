From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Stable ab/i18n branch
Date: Mon, 18 Oct 2010 16:39:31 -0700
Message-ID: <7vmxqb2hqk.fsf@alter.siamese.dyndns.org>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
 <AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
 <20101014200027.GA18813@burratino> <7vwrph4eeb.fsf@alter.siamese.dyndns.org>
 <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 01:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7zJ2-0002zb-5E
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 01:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844Ab0JRXjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Oct 2010 19:39:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab0JRXjo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 19:39:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE2A0DF471;
	Mon, 18 Oct 2010 19:39:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8n5xQWFpAD1y
	rTVPbk8pttILzjI=; b=C+YU10fWuiWlWOx1r1d1Ix0GnfEyFVOzNmmf7jGAr6Qu
	rDZ8Z64rK4zA64FW0i7ARb8FWKV6PolNYMyL5EXkianXr8M9UpZsJjGdtOef+Htf
	6PwClmk2CUKKclxgusyN/s71UmPgu+6kobYPTX19Jd+UKROz6ouy/GPXLfrLfGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pwe2BT
	GjqdpuC61GrHq7fwLLs4qPbTLjBNoKtlx8IUHIIv5jGNtOBmuSHPhbiOY81pVleT
	wKCwd5oYIhPuDxIyvb448IFHUGUb2KsQRr+nQEyYLSPX74VRcR0yBJ5tPTjGkiWW
	OpernCubAZCsG4HJqWs6ZAmMMHZFsLbWt8MVg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67AC3DF46E;
	Mon, 18 Oct 2010 19:39:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 695D5DF469; Mon, 18 Oct
 2010 19:39:33 -0400 (EDT)
In-Reply-To: <AANLkTikc80ev+ex6-9RDgO_h-4LEuZf6M9hPAfVQ9oSX@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun\, 17 Oct
 2010 12\:33\:56 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8C40534-DB10-11DF-9049-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159296>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Do you mean to re-arrange it so that there's a patch at the front of
> the series that introduces gettext.h with only the fallbacks:
>
>     #define _(s) (s)
>     #define N_(s) (s)
>
> And then merge the ~120 gettextize patches first and do the
> infrastructure later?

Not really.

Two pieces that would be nice to have in 'master' (or even 'maint', if =
we
consider avoiding merge conflicts and mismerges when fixes are queued
there) are:

 1. preparatory fixes to code that builds message string by concatenati=
ng
    parts of speech in English word ordering into buffer or emitting to
    output stream piece by piece; they should convert them to some form=
 of
    sprintf-like format strings plus arguments.  This does not necessar=
ily
    have to mark the format strings with _(s).

 2. the empty definitions for _(s) and N_(s).

I would consider the first one part of general clean-up job, which we k=
now
will help i18n, but which we would want to do regardless of i18n.  And =
it
is probably the most error prone part in the whole process.  The sooner
the result of these two steps hit 'master', the less pain for everybody=
=2E

And then:

 3. actual marking of strings with _(s) and N_(s).

which can be merged to 'next' after vetting for regression (the first t=
wo
classes).

 4. Adding and polishing of *.po files for actual messages and language=
s,
    i.e. l10n.

This can happen pretty much independently from 3.  Honestly I would be
happier if I do not have to keep track of the actual l10n part.

I think the current series to some degree conflates steps 1. and 3.  As
the list of risks I outlined in the previous message show, mistakes in =
1.
is much more grave than mistakes in 3. (iow, no big deal for having a f=
ew
untranslated messages during early rounds of i18n support); I would hav=
e
preferred these two steps were clearly separated, so that we can push t=
he
first two steps out to the 'master' sooner.
