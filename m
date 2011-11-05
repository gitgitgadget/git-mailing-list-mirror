From: Junio C Hamano <junio@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Sat, 05 Nov 2011 16:49:15 -0700
Message-ID: <7vsjm2870k.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
 <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v1utn9it8.fsf@alter.siamese.dyndns.org>
 <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Sun Nov 06 00:49:29 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RMpzM-0001jk-Jx
	for glk-linux-kernel-3@lo.gmane.org; Sun, 06 Nov 2011 00:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab1KEXtV (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sat, 5 Nov 2011 19:49:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63512 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762Ab1KEXtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2011 19:49:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A0E96D1F;
	Sat,  5 Nov 2011 19:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PdzFP3hUH1TCkp8DZtUdiYl+4VE=; b=l2+WKs
	nbsuFKxpW74k1xVGlQfA620BIXveESy6mLsQ47um7jm4NEo0SPhX2VarqN8Bf7QB
	5kA/K6o+AwSqyw9D5H8+Bwsg0hB5biJM88tTYT+mkv/TqKtduWHMi4EMX/9nIRUX
	Lcg3iBKyqXhLbbZgcvanxNQKcttbPUKNpq27U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbBBWMdA1rUq4eZTAgmpRnlB98BeWZhP
	rICReOPYy5NSOKleNcJIN6ILiCtWMyGfO3tdrvMKCwD5P8g8xyaZSoKzNmEUP5YN
	tBIoTG5xAMUZ7PEwRMWMHsqYE0lzw4eDWPv6UohHf6rBR5QZzu/GTNkR6pCEunbY
	bvsKTGHAIwY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401946D1E;
	Sat,  5 Nov 2011 19:49:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96D6A6D1C; Sat,  5 Nov 2011
 19:49:17 -0400 (EDT)
In-Reply-To: <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com> (Linus
 Torvalds's message of "Sat, 5 Nov 2011 09:41:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C63F2DC0-0808-11E1-A5A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184880>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I'd really like some way to not see it.
>
> Ted suggested a NUL character in the commit message in front of the
> "hidden content". What do you think?

You do not have to resort to NUL; we could just stuff whatever you do not
need to see but needs to be left *intact* in the new header fields just
like the embedded GPG signatures are stored in signed commits.

By the time the integrator is presented the merge commit template, we
would have:

 1. The merge title (e.g. "Merge tag for-linus of git://.../rusty.git/");

 2. Payload of the signed tag (or just "annotated tag"), which is used to
    convey meaningful topic description from the lieutenant;

 3. The signature in the tag, if the tag is not just merely annotated, but
    is signed;

 4. The output from GPG verification of the above (only when 3. is
    available); and

 5. The traditional "merge summary", if merge.log is enabled.

The 10-patch series I sent earlier appends 2 and 3 with "tag:" prefix and
4 with "# " prefix in the commit log template, but it does not have to be
that way. We could arrange things so that we put only 1, 2, 4 (still with
"# " prefix because this is meant to help you verify the authenticity, not
for later third-party audit, and to be stripped away with stripspace
before the commit is made) and 5 in the commit log template, and the
original signed tag contents (only when the tag is signed, not merely
annotated) in a separate file MERGE_SIG in $GIT_DIR/ next to MERGE_MSG,
and teach "git commit" to pick it up and stuff it in a new header field.

That way, the integrator can use the message 2 for the commit log message
and is free to typofix it, without breaking later third-party audit which
would use what is taken literally from the signed tag and stored in the
new header field, because the integrator's editor would never touch the
latter.
