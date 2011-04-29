From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] git-svn: don't confuse editors with an apostrophe
Date: Fri, 29 Apr 2011 09:28:44 -0700
Message-ID: <7viptxxbr7.fsf@alter.siamese.dyndns.org>
References: <1304077214-1707-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:29:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqYv-0006KZ-5x
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760064Ab1D2Q24 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 12:28:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760022Ab1D2Q2z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 12:28:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C893251A5;
	Fri, 29 Apr 2011 12:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kbOmJZdoHnI6Z02n/ZKp4bI4p
	Hs=; b=lzYHKbXbbeQjXhH0SGhoGkCRE4SjiNQwGr9N2X7zI8OBdEysNOUi2CPA+
	w2wV7ycnCGM135fqVzd1ik5I3rDBS/Zze9Wy6D+zBGzeQU6VlGkT/FNdfrL6fdyN
	CFmKno3AZMDIIqV8fTtoSx6YdHDUkmTYgpv0tJJ8Gs/uBP+XJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=k0L7eNHnFUvVyXKCE8N
	ElcQeKDUjnpfC6SmarMFAt6dn7SrUVT57stU5wTSxuf5L5fw1mof69Q93ysqM5QL
	DcGbh41e1n02dMfjjCl30x7BjOC3oaoZCoRlO8+nnS5nJgdPYfh9PkKXZmkyccbP
	AWxbi0hc9FkDd3GbSMphS4OY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9731851A4;
	Fri, 29 Apr 2011 12:30:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 69F4C51A0; Fri, 29 Apr 2011
 12:30:49 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D47883C-727E-11E0-85AD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172467>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The quotation mark serving as an apostrophe confuses editors and they
> think a large part of the rest of the file is a string. Change
> "you're" to "you are" to avoid this.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> Acked-by: Eric Wong <normalperson@yhbt.net>
> ---
>
> I sent this on 31-03-2011 but apart from Eric's ack, there was no
> reaction and I don't see it in the patch queue.

It was on purpose that I did not apply it, as the usual mode of operati=
on
has been for me to pull git-svn changes via Eric, and more importantly,=
 I
did not think it was important.

It did not look like a bugfix that needed to be handled quickly (even b=
y
bypassing Eric if needed), and more importantly, I did not think your
justification of the patch was sound. So I (implicitly) made it up to
Eric either to discard it or to include it as part of his pull-request.

The explanation Eric gave (Avoiding contractions may make life easier f=
or
folks less familiar with English overall) makes some sense to me, but
after re-reading your justification today, it still does not make sense=
=2E

=46or one thing, many editors would not even think "you" is not a strin=
g and
"re" and everything follows is a string, when "you're" is given to
them. Everything is a string in a text editor, isn't it?

I suspect that you are talking about syntax highlighting, and some synt=
ax
highlighter may be stupid to be confused, but in that case, at least yo=
u
would need s/editors/some editors/.

Most fundamentally, I do not see why output from "sub usage" that lists
available commands when "git svn -h" is asked for has anything to do wi=
th
an editor getting confused. Why do you have that output in your editor =
in
the first place?

Even if the reason you have that output in your editor were sane, do yo=
u
mean to say that _all_ messages we output from our program, not just "g=
it
svn", need to be cleansed of contractions? That is madness, and I do no=
t
think that is what you meant. You need to clarify when your "do not
contract" rule applies fairly narrowly to avoid such a misunderstanding=
=2E
