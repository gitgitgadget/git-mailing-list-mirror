From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] SubmittingPatches: Cite the 50 char subject limit
Date: Wed, 28 Jul 2010 10:23:24 -0700
Message-ID: <7vzkxb4j1v.fsf@alter.siamese.dyndns.org>
References: <1280326285-10203-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAM9-0002yk-6H
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906Ab0G1RXe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 13:23:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889Ab0G1RXb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jul 2010 13:23:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 28483C8C3E;
	Wed, 28 Jul 2010 13:23:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=IYv38yUlIgoOGcYvZukG57Na4
	2s=; b=xzgJCC0Z8XW47Z6wzuixNr+zbcwfeLhs282a2VNO88NMkFkiOMAyBvdlD
	qjxPtnD4kz1bubtFnnaoywAKNA9RqyoMQiQYJUbCkc5+3oncMTVoG0TUpbm+K54g
	0IfQtMG1UKcmAOCFI6kXdUToNv1e4FI2OLC5QUSbsNUyO3p6M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KkYk+SMiQd2zuE7KYca
	/rLQ/pOf1yx30vRohfBMe+TShxSlZ4UDCMIjXVNtqrGR9WYjAWGIezjv9BsIgIBC
	WyAjDaQWa2KJEPczsDk5px+yCpEESLAAC+e0QHluWTuFHnpXq8ryBUQnG1BHreo+
	V5bv2DjrQ8BfUnYB5eIE1z64=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05BA6C8C3B;
	Wed, 28 Jul 2010 13:23:29 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43501C8C38; Wed, 28 Jul
 2010 13:23:26 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D679F1DA-9A6C-11DF-90CE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152106>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Change the SubmittingPatches recommendations to mention the 50
> character soft limit on patch subject lines. 50 characters is the sof=
t
> limit mentioned in git-commit(1) and gittutorial(7), it's also the
> point at which Gitweb, GitHub and various other Git front ends start
> abbreviating the commit message.

Hmph, we probably would want to do s/50 character/&s/ in the two manual
pages.  I do not think if anybody is ready to stand behind the specific
number "50", and we can bikeshed about it separately.

The spirit of having a soft limit is twofold:

 - It should fit on "git log --oneline" comfortably;

 - If your change is too complex to be summarized in such a short
   sentence, you probably are doing too many things in one commit.

The first does not justify "50" any better than other arbitrary limit, =
but
with things like --graph and --source, anything longer makes the result=
ing
output very close to the edge of an 80-column terminal.

The second does not justify "50" either, as your language may be verbos=
e
or terse (e.g. Japanese can cram far more information in a 140-char twe=
et
than somebody writing in English), but it is a more important one betwe=
en
the two rationales above.
