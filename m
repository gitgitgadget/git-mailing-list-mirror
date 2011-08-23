From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Tue, 23 Aug 2011 11:09:17 -0700
Message-ID: <7vaab0rodu.fsf@alter.siamese.dyndns.org>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
 <4E4D7DD3.2000701@obry.net> <7vhb5e73hy.fsf@alter.siamese.dyndns.org>
 <4E502302.4000300@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pascal@obry.net, git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Aug 23 20:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvvPi-0005be-MG
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 20:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab1HWSJW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Aug 2011 14:09:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab1HWSJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2011 14:09:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C691947AD;
	Tue, 23 Aug 2011 14:09:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fNaDtG37Cq78
	/UDo7SbUqChI4xU=; b=D8n7kWTOQRIV9q4pNR13c4SQ7MZXw8YOg4i3RP3Xg16+
	UNse4uaHL5lxdfGL7j1MyKQ6r0l4hOMxKiavKUIodhw/ti2/zfTDUkoy1umcb6HQ
	+0DGHf5ZcaYedf9ZMrkxMeKhp1FblEJWNZ8FqQea/oRnXWDqmuJjfDsHLrrnJj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=c9JgLp
	72ZHNeD8iHJpX+HJ1FBdmW6zxwtAwkxlZRwV5IosPOiOvwRUL8vk1ls8tTewFcRp
	uYByLMxG1Z22iJ4w8zTGpHU0Qsa+EQVaseqZlcPF5xu0W2x/uyfhnQ6LZSTfURVW
	M2eQ0c5lc92ERw0mwNTe5k1h+DGNeRDM++ft0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC1547AC;
	Tue, 23 Aug 2011 14:09:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04FB247AB; Tue, 23 Aug 2011
 14:09:18 -0400 (EDT)
In-Reply-To: <4E502302.4000300@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 20 Aug 2011 22:11:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0526083C-CDB3-11E0-8B4C-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179955>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Commit 704c335 (On Cygwin support both UNIX and DOS style path-names,
> 05-08-2011) in pu needs an update to fix the commit message.

Thanks for a reminder, Ramsay.

Here is the exchange where fixing the commit log was mentioned.

    From: Pascal Obry <pascal@obry.net>
    Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style =
path-names
    To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
    Cc: git@vger.kernel.org
    Date: Sat, 13 Aug 2011 19:34:37 +0200
    Message-ID: <4E46B5AD.5050806@obry.net>

    Le 11/08/2011 22:35, Ramsay Jones a =C3=A9crit :
    >   ... could you please correct your commit message. Thanks!

    Done, thanks for your review.

> Also, I didn't see any response to Johannes Sixt's query concerning
> backslash in pathspec. (I personally don't want to go down that
> route, but ...)

Here is what J6t said in the message:

  From: Johannes Sixt <j6t@kdbg.org>
  Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style pa=
th-names
  Date: Tue, 09 Aug 2011 21:47:15 +0200
  Message-ID: <4E418EC3.4070904@kdbg.org>

  > Do you also want to support this:
  >      $ git add src\file.c
  > i.e., backslash in pathspec? Then you need more than this:
  > > +#define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1=
] =3D=3D ':')
  > > +#define is_dir_sep(c) ((c) =3D=3D '/' || (c) =3D=3D '\\')
  >
  > In particular, you have to enable backslash processing in
  > setup.c:prefix_filename(), but then you lose the ability to escape
  > special characters with the backslash.

When "git add src\file.c" is given from the command line, what does our
main() see in argv[2]? Do cmd.exe and bash give us the same thing? What=
 if
the command line is "git add 'src\*.c'"?

I vaguely recall that on Windows you only get a single parameter string
from the program loader, and arguments are split in the invoked process=
,
but that is so common that as far as our main() is concerned we can exp=
ect
the example command line to give us argc=3D3 and argv=3D{ "git", "add",=
 "???",
NULL }. What I do not recall is if there is some other magic such as
expanding shell globs and swapping the direction of slashes in strings
involved when this argument processing is done.

You probably _could_ do '\\' -> '/' inside prefix_filename() and
get_pathspec(), but as J6t mentioned, we _do_ handle backslash as a
quoting character, and this is _not_ going to change.

So even if we were to go that route, the user would need to make git se=
e
"src\\file.c" or "src\\*.c" in order to make it turn into "src/file.c" =
and
"src/*.c" pathspec. If it means that the user needs to type:

	$ git add src\\\\file.c

I would have to say that it would be simpler for them to say

	$ git add src/file.c

even on Cygwin. After all, isn't Cygwin for people who are forced to be=
 on
Windows and miss POSIXy environments?

By the way, Johannes, how does Git for Windows handle pathspecs?
