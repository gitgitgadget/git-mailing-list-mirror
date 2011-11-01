From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 01 Nov 2011 14:56:47 -0700
Message-ID: <7vk47jld5s.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Nov 01 22:57:01 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLMKL-00022K-DR
	for glk-linux-kernel-3@lo.gmane.org; Tue, 01 Nov 2011 22:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab1KAV4x (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 1 Nov 2011 17:56:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58733 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263Ab1KAV4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2011 17:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E313257D8;
	Tue,  1 Nov 2011 17:56:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rjpqc9P23JgDZ/97i31AWa69Mv0=; b=pqcPPv
	WRIb+aVGgMIEzxvkAWaOiGGMo7jtgYp+yJafsk8m00wcIk8aQ5eWh/cXhidhFTh8
	LuN2SrGlAwkWB4hFRi++WFOVUVAfLpYnLbo6BcUoGTQsrvoTOaSGAnDCKnLiGMJp
	Vfq8ivMkopzoGSE9Byf4LgbZzp1+jZ4pl2pck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LoZTC0NsKcvCF1IsOnEjmRiJ/waa9dOW
	yMJUYcHg0VIR//SafI/8yxSw2SEW71qv1lm7n6olwHL/CLJV9vRwL2x6u0NNZDgT
	d5rbBjbdPKQ6YJ9Jyiiwnn5k1xKJ/oj65bKwKQymSnIsaI8dd7mNvLEC/sQIlmMw
	Vrjv1npydxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C9157D7;
	Tue,  1 Nov 2011 17:56:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1273D57D6; Tue,  1 Nov 2011
 17:56:49 -0400 (EDT)
In-Reply-To: <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 1 Nov 2011 14:21:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 662565A8-04D4-11E1-9411-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184596>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Having thought about it, I'm also not convinced I really want to
> pollute the "git log" output with information that realistically
> almost nobody cares about. The primary use is just for the person who
> pulls things to verify it, after that the information is largely stale
> and almost certain to never be interesting to anybody ever again. It's
> *theoretically* useful if somebody wants to go back and re-verify, but
> at the same time that really isn't expected to be the common case.
> ...
> So I'm wondering if we want to save it at all. it's quite possible
> that realistically speaking "google the mailing list archives" is the
> *right* way to look up the signature if it is ever needed later.

I'd rather want to hear opinions from people who base their work on public
kernels (e.g. distros, and companies who roll their own prod kernels), on
that.

But my gut feeling is that "usually hidden not to disturb normal users,
but is cast in stone in the history and cannot be lost" strikes the right
balance. Both your "next merge commit records the signature together with
the largely useless merge summary cruft but everybody learned to ignore it
with 'log --no-merges' anyway so it does not hurt to have it there" and
the commit signature topic from the next branch [*1*] that puts the
signature in the object header and teaches '--show-signature' option to
the log family to show it share this property.

> Maybe just verifying the email message (with the suggested kind of
> change to "git request-pull") is actually the right approach. And what
> I should do is to just wrap my "git pull" in some script that I can
> just cut-and-paste the gpg-signed thing into, and which just does the
> "gpg --verify" on it, and then does the "git pull" after that.
>
> Because in many ways, "git request-pull" is when you do want to sign
> stuff. A developer might well want to push out his stuff for some
> random internal testing (linux-next, for example), and then only later
> decide "Ok, it was all good, now I want to make it 'official' and ask
> Linus to pull it", and sign it at *that* time, rather than when
> actually pushing it out.
>
> And I suspect signing the pull request fits better into peoples
> existing workflow anyway - sending out the email to ask the maintainer
> to pull really is the "special event", rather than pushing out the
> code itself.

"I can silently push and re-push or even rewind-and-then-push until I
officially send pull-request out" fits well with the "defer the decision
as much as possible" model Git takes in general, and I find certain
attractiveness in it.

But on the other hand, in many ways, publishing your commit to the outside
world, not necessarily for getting pulled into the final destination
(i.e. your tree) but merely for other people to try it out, is the point
of no return (aka "don't rewind or rebase once you publish").  "pushing
out" might be less special than "please pull", but it still is special.

Also there is nothing lost if you sign commits whenever you push them
out.


[Footnote]

*1* Here are three examples on the same commit that is signed for
illustration.

------------------------------------------------
$ git show -s pu
commit c9d870fceac787fdb1c1c43b136c1a94ab2ab005
Merge: 8367c51 71f45ee
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Oct 31 20:06:58 2011 -0700

    Merge branch 'jc/stream-to-pack' into pu
    
    * jc/stream-to-pack:
      Bulk check-in
      finish_tmp_packfile(): a helper function
      create_tmp_packfile(): a helper function
      write_pack_header(): a helper function
------------------------------------------------
$ git show -s --show-signature pu
commit c9d870fceac787fdb1c1c43b136c1a94ab2ab005
gpg: Signature made Mon 31 Oct 2011 08:07:04 PM PDT using RSA key ID 96AFE6CB
gpg: Good signature from "Junio C Hamano <gitster@pobox.com>"
gpg:                 aka "Junio C Hamano <junio@pobox.com>"
gpg:                 aka "Junio C Hamano <jch@google.com>"
Merge: 8367c51 71f45ee
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Oct 31 20:06:58 2011 -0700

    Merge branch 'jc/stream-to-pack' into pu
    
    * jc/stream-to-pack:
      Bulk check-in
      finish_tmp_packfile(): a helper function
      create_tmp_packfile(): a helper function
      write_pack_header(): a helper function
------------------------------------------------
$ git cat-file commit pu
tree 9add290d468800c3c51ff68fedfb3d16427872ff
parent 8367c51becc5a225b9a192348b7d7c615fb6d250
parent 71f45eeb8278670257bea83620f7d3eac174eee7
author Junio C Hamano <gitster@pobox.com> 1320116818 -0700
committer Junio C Hamano <gitster@pobox.com> 1320116824 -0700
gpgsig -----BEGIN PGP SIGNATURE-----
gpgsig Version: GnuPG v1.4.10 (GNU/Linux)
gpgsig 
gpgsig ...
gpgsig =c62U
gpgsig -----END PGP SIGNATURE-----

Merge branch 'jc/stream-to-pack' into pu

* jc/stream-to-pack:
  Bulk check-in
  finish_tmp_packfile(): a helper function
  create_tmp_packfile(): a helper function
  write_pack_header(): a helper function
------------------------------------------------
