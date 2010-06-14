From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] git-gui blame: use textconv
Date: Mon, 14 Jun 2010 10:29:50 -0700
Message-ID: <7vr5k9a5f5.fsf@alter.siamese.dyndns.org>
References: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
 <c80899f148cbfc9446554c6c706fdbfb@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <spearce@spearce.org>, <git@vger.kernel.org>
To: clement.poulain@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 14 19:30:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OODU6-0000yd-J2
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab0FNRaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 13:30:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0FNR37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 13:29:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2896BC3AB;
	Mon, 14 Jun 2010 13:29:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fpptu9lY9mM5
	841T+ZzAqJrpD3Y=; b=Gx3yLgC0v8i+eGJjzqS36XBiMdb6UagnSnrVq8PAYJdn
	EW14vSARZXD9Aqhnrmfgn/20krrbPgh4zO7Ndjvgi35c10T49UkCCCt67AXl20IP
	IEJOMYVE1UvfZSybnmgNi0XjSwdq+V+IGqAYhftrX3h+j8VhbkEgRMB9JQ4pj4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fHU9rY
	aZvDBQcLGNxZG1oZ0JO6u0jWu8idQCDsifEUxHW9Bmo8ynZDsPd5RqmDkog84TOR
	eZW8LU6hT16IkT+KsmRQzXv+u2QUPLWUros9umD4Xo3t8/aU/L+BbMZsVzrXYfNo
	XXw1ognTnCsj3bU1wstPQBKNFEzUi/PAzy2bE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E1F5BC3A4;
	Mon, 14 Jun 2010 13:29:55 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B87EEBC3A3; Mon, 14 Jun
 2010 13:29:51 -0400 (EDT)
In-Reply-To: <c80899f148cbfc9446554c6c706fdbfb@ensimag.fr> (=?utf-8?Q?=22C?=
 =?utf-8?Q?l=C3=A9ment?= Poulain"'s message of "Mon\, 14 Jun 2010 19\:18\:36
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72B62916-77DA-11DF-8EB5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149132>

Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr> writes:

> I've seen this series is now on pu. I have 2 questions concerning the
> fourth patch (ca23df5e, Cl=C3=A9ment Poulain, 2010-06-09 19:02:08) ta=
gged with
> [DONTMERGE] and annotated with [jc: shouldn't merge this to 'next' or
> higher but take it via Shawn].
>
> First, is the tag only for this patch, or for the whole series?=20
> Then, do we have something more to do?

That was primarily a note to myself attached to that one commit.

Because I pull all the changes to git-gui from Shawn (and gitk from
Paulus) using subtree merge, I do not want to apply patches that touch
git-gui/ (or gitk-git/) part myself.  Sometime later when the earlier
patches in your series prove to be 'next'-worthy, I'll have to nag Shaw=
n
to accept it to his tree (we might need to devise a transition strategy=
 so
that people who want to use slightly newer git-gui with older git won't
get hurt).

Thanks for asking.
