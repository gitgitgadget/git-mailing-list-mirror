From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add gitk-git Hungarian translation
Date: Sun, 13 Dec 2009 18:46:11 -0800
Message-ID: <7vskbejmrw.fsf@alter.siamese.dyndns.org>
References: <1258284204-17247-1-git-send-email-djszapi@archlinux.us>
 <19205.2740.244981.703612@cargo.ozlabs.ibm.com>
 <a362e8010911220005u1783cd44yf84ae5bc5b42d980@mail.gmail.com>
 <a362e8010911281833p58058a06sbe305d61709ac051@mail.gmail.com>
 <a362e8010912131030v4c1ef231r7246d7291f6a5677@mail.gmail.com>
 <20091213230305.GA8135@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Laszlo Papp <djszapi@archlinux.us>,
	Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 03:46:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK0xB-000190-6o
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 03:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbZLNCqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Dec 2009 21:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756471AbZLNCqY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 21:46:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472AbZLNCqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2009 21:46:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 703E2876A3;
	Sun, 13 Dec 2009 21:46:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EtnqnObnBShR
	0N5cVmstMNWvRKk=; b=cJPoIlIrkkIhiswgCxkB9d4XpH7EBGTY+fZYP/9aLIRe
	sb3b8Lw09Z8ARTncDDJNfp0oQWw65ypNQPXaQtqiv3WnYEAYhShaxITfAAW/3Xua
	qFpjazSRC0hdiEr+FgIYPB0bJisIWfbpPclJGXQhMFRCJQD0m5GiyhBfTVVNegc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nyPOUq
	T3Zj7B1jPZJaICrLndLoBmjOM/PWwOC2OGnmILwrrjTs97ioZtAZVPnUGECPC+J4
	jIF3HVH2/l2FPXRj4P9uKSWPv6UIdNzsQpZ/FEkeK21r5d7fyqqxYiuAiCdgkGfj
	O0sZXVsnf90CB8pIbXLo7Zb4ro0HjhNDCmCRI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB0A876A2;
	Sun, 13 Dec 2009 21:46:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29945876A1; Sun, 13 Dec
 2009 21:46:13 -0500 (EST)
In-Reply-To: <20091213230305.GA8135@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Mon\, 14 Dec 2009 10\:03\:05 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DAB1D250-E85A-11DE-A6E9-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135165>

Paul Mackerras <paulus@samba.org> writes:

> In any case, your patch has problems: I applied it and then ran
> make to update the message catalogs, and I got these errors:
>
> Generating catalog po/hu.msg
> msgfmt --statistics --tcl po/hu.po -l hu -d po/
> po/hu.po:41: end-of-line within string
> po/hu.po:41:4: syntax error
> po/hu.po:42: end-of-line within string
> po/hu.po:666: end-of-line within string
> po/hu.po:666:10: syntax error
> po/hu.po:667: end-of-line within string
> msgfmt: found 6 fatal errors
> make: *** [po/hu.msg] Error 1
>
> so I reverted it.

Syntactically there seem to be only two line-wrapping caused by MUA on =
the
originating side that caused this.  Munging the problematic lines seems=
 to
fix the above.

Now, I don't read _any_ Hungarian, so it could very well be that my fix=
-up
is wrong and there shouldn't be any SP between two words in 'f=C3=A1jlo=
n bel=C3=BCl'
and 'm=C3=A9g nincsenek'; if we hear from some Hungarian capable reader=
s that the
fix-up below makes sense, perhaps squashing it in would be the easiest =
way
to move forward?

diff --git b/gitk-git/po/hu.po a/gitk-git/po/hu.po
index d281e3c..cbaa93d 100755
--- b/gitk-git/po/hu.po
+++ a/gitk-git/po/hu.po
@@ -37,8 +37,7 @@ msgid ""
 "No files selected: --merge specified but no unmerged files are within=
 file "
 "limit."
 msgstr ""
-"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon
-bel=C3=BCl "
+"Nincsen f=C3=A1jl kiv=C3=A1lasztva: --merge megadva, de nincsenek unm=
erged f=C3=A1jlok a f=C3=A1jlon bel=C3=BCl "
 "limit."
=20
 #: gitk:361 gitk:508
@@ -662,8 +661,7 @@ msgstr "Nem el=C5=91d"
=20
 #: gitk:4842
 msgid "Local changes checked in to index but not committed"
-msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g
-nincsenek commitolva"
+msgstr "Lok=C3=A1lis v=C3=A1ltoztat=C3=A1sok, melyek be vannak t=C3=A9=
ve az indexbe, de m=C3=A9g nincsenek commitolva"
=20
 #: gitk:4878
 msgid "Local uncommitted changes, not checked in to index"
