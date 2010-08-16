From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t7006 (pager): add missing TTY prerequisite
Date: Mon, 16 Aug 2010 09:41:48 -0700
Message-ID: <7vd3ticxwz.fsf@alter.siamese.dyndns.org>
References: <20100626192203.GA19973@burratino>
 <20100806023529.GB22369@burratino> <20100806031204.GK22369@burratino>
 <201008160921.33198.trast@student.ethz.ch> <20100816080709.GA17566@burratino>
 <20100816081126.GC17566@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 18:42:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol2lJ-0003Nd-20
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 18:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0HPQmG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 12:42:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab0HPQmE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 12:42:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36601CDDD0;
	Mon, 16 Aug 2010 12:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PwDhdeySc2JJ
	akpQVNVuDXEBIxA=; b=DYHPwBo7nSkts2H0CAsFs359fnpPpHdA/vcWiEVc9LmI
	GssN0rXGL6A8laJYfYReGVsoOgEcUnJBOutCmFQfQ4qC6aqWiweA4wvru7E6UqPc
	t3W8OjdkV954Jl1d36iWjuY3CNaUkVwnnQEAAktF5tZq88ZKWlOjYVcmny5xTqQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OEBajO
	MGd4jPdloSVYDhaC1L/Ov6dG8tUirohdh9M7Tll+NEnUuqgOylyCee65OnUS+kVV
	hJKWAe2K35+QzHiMMPhLVzQR5VxwU7jdzCi+wwz29RlxIZPQJ3CpVUfS27YCvHHv
	qRfeJOccZKINjz5Cz/qu3bLcLH3ImYdM0FAA0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1548CDDCC;
	Mon, 16 Aug 2010 12:41:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81BCCCDDC5; Mon, 16 Aug
 2010 12:41:50 -0400 (EDT)
In-Reply-To: <20100816081126.GC17566@burratino> (Jonathan Nieder's message of
 "Mon\, 16 Aug 2010 03\:11\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F6F26CE-A955-11DF-AC9C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153662>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The config pagination test should not run if there is not a tty
> available to force pagination on.
>
> Reported-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This one fixes for =E2=80=9Cconfig: run setup_git_directory_gently()
> sooner=E2=80=9D.

Somehow we didn't seem to have got 1/2, but here is what I'll queue.

By the way, could you stop using those "pretty quotes" and stick to the
good old "ASCII 0x22" double-quotes?  I find them ugly in the git log
output.

-- >8 --
=46rom: Jonathan Nieder <jrnieder@gmail.com>
Date: Mon, 16 Aug 2010 03:08:34 -0500
Subject: [PATCH] t7006 (pager): add missing TTY prerequisites

The "git bundle unbundle" and "git config" pagination tests are not
supposed to run when stdout is not a terminal and IO::Pty not available
to make one on the fly.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7006-pager.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 017565f..fb744e3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -134,7 +134,7 @@ test_expect_success TTY 'configuration can disable =
pager' '
 	! test -e paginated.out
 '
=20
-test_expect_success 'git config uses a pager if configured to' '
+test_expect_success TTY 'git config uses a pager if configured to' '
 	rm -f paginated.out &&
 	git config pager.config true &&
 	test_when_finished "git config --unset pager.config" &&
@@ -142,7 +142,7 @@ test_expect_success 'git config uses a pager if con=
figured to' '
 	test -e paginated.out
 '
=20
-test_expect_success 'configuration can enable pager (from subdir)' '
+test_expect_success TTY 'configuration can enable pager (from subdir)'=
 '
 	rm -f paginated.out &&
 	mkdir -p subdir &&
 	git config pager.bundle true &&
--=20
1.7.2.1.224.g2f41ea
