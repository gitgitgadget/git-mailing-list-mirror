From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 16:09:09 -0700
Message-ID: <7vlis0oj1m.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
 <CA+55aFzedaAzzWfzhqVf8y8ZW0jeb56hZwdV3UodSp8Q_Qhc2A@mail.gmail.com>
 <7vvcr4ojvp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Nov 01 00:09:26 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RL0yq-000854-AV
	for glk-linux-kernel-3@lo.gmane.org; Tue, 01 Nov 2011 00:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732Ab1JaXJO (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 31 Oct 2011 19:09:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49785 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab1JaXJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2011 19:09:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD66758E3;
	Mon, 31 Oct 2011 19:09:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6yp8Nw/DJLiLxcECoqGeGUjyHao=; b=R87alb
	nWmus3pPO7FkDZz2GQcOwD8L0IIKfpk7I45n4KRWOcfXabK9gSnFwKmytBBH7xoq
	1rE86yObQRqFFiSSkhigJfA2joFmxISga0+gtt/UM2x2O4i76uismMkslWNNAXgG
	9ndYciz7IscQJIrqCRus7EZpZ2Wloo8G3PtP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgiZ5fLA6syMEPs7aV4YU7y/pBMYjmQy
	8qKgaNhI7av0C6/11wFSVXjF7S+QOX178MStl/TPmSMvuybLGeDHOj8tKrTAnNJf
	iPP+y5GQ7pUECHOBueJoW9htT8Tik04W0It9S1muvjUc/JwXzu9LiXpK5kFcELzS
	IuZLqUhfBe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A374C58E2;
	Mon, 31 Oct 2011 19:09:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0058B58E0; Mon, 31 Oct 2011
 19:09:10 -0400 (EDT)
In-Reply-To: <7vvcr4ojvp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 31 Oct 2011 15:51:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57B975AA-0415-11E1-8ED5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184543>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
> As I already said, I do not think notes is a good match as a tool to do
> this.
>
>> matters is that "git push" and "git pull" would JustWork(tm), and
>> check the signature if one exists, without having to cut-and-paste
>> data that simply shouldn't be visible to the user.
>>
>> I abhor the interface Ingo suggested, for example....
>
> Some cut-and-paste (or piping the e-mail to a command) would be necessary
> evil, though, as you would have GPG keys from more than one trusted person
> in your keyring, and when you are responding to a pull-request from person
> A, finding a valid commit signed by person B should not be a success, but
> at least should raise a warning.

So here is a quick hack that does not involve cut-and-paste (it depends on
the signed-commit topic in 'next').

 $ git pull --require-signature

would trigger signature verification and stops you after fetching but
before merging.

 git-pull.sh |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9868a0b..f3b4c93 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -39,7 +39,7 @@ test -z "$(git ls-files -u)" || die_conflict
 test -f "$GIT_DIR/MERGE_HEAD" && die_merge
 
 strategy_args= diffstat= no_commit= squash= no_ff= ff_only=
-log_arg= verbosity= progress= recurse_submodules=
+log_arg= verbosity= progress= recurse_submodules= must_be_signed=
 merge_args=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
@@ -60,6 +60,8 @@ do
 		diffstat=--no-stat ;;
 	--stat|--summary)
 		diffstat=--stat ;;
+	--require-signature)
+		must_be_signed=yes ;;
 	--log|--no-log)
 		log_arg=$1 ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
@@ -208,6 +210,27 @@ orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
 
+if test -n "$must_be_signed"
+then
+	signature=$(git show -s --format='%G?' FETCH_HEAD)
+	case "$signature" in
+	G)
+		case "$verbosity" in
+		*' '-v*)
+			git show -s --show-signature FETCH_HEAD ;;
+		esac
+		;;
+	B)
+		echo >&2 "Bad signature on the tip commit"
+		exit 1
+		;;
+	*)
+		echo >&2 "Tip commit must be signed"
+		exit 1
+		;;
+	fi
+fi
+
 curr_head=$(git rev-parse -q --verify HEAD)
 if test -n "$orig_head" && test "$curr_head" != "$orig_head"
 then
