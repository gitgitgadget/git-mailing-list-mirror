From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files for
  external diff
Date: Sun, 22 Mar 2009 16:12:08 -0700
Message-ID: <7vwsahb19z.fsf@gitster.siamese.dyndns.org>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de>
 <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
 <7v8wmybf06.fsf@gitster.siamese.dyndns.org>
 <7vzlfe9ynj.fsf@gitster.siamese.dyndns.org>
 <20090322061046.GA14765@coredump.intra.peff.net>
 <7v63i281py.fsf@gitster.siamese.dyndns.org>
 <20090322074643.GA4826@coredump.intra.peff.net>
 <bdca99240903220830u50999dfcnee0f0091b4dec835@mail.gmail.com>
 <7vljqxcj84.fsf@gitster.siamese.dyndns.org>
 <bdca99240903221548y38f31177q6abb88c2f7f87a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:13:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlWrV-0004n6-27
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 00:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268AbZCVXMT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 19:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756142AbZCVXMT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 19:12:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZCVXMT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 19:12:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EFC7E8D9C;
	Sun, 22 Mar 2009 19:12:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 302DE8D9B; Sun,
 22 Mar 2009 19:12:11 -0400 (EDT)
In-Reply-To: <bdca99240903221548y38f31177q6abb88c2f7f87a73@mail.gmail.com>
 (Sebastian Schuberth's message of "Sun, 22 Mar 2009 23:48:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E247D5B4-1736-11DE-9664-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114199>

Sebastian Schuberth <sschuberth@gmail.com> writes:

>> The discussion in the last few messages in this thread speculates th=
at the
>> external programs are more likely to expect representations suitable=
 in
>> the work tree, aka "smudged", than "clean" one. =C2=A0It would be ni=
ce to get a
>> datapoint from you as the original reporter to confirm or refute tha=
t
>> speculation.
>
> I agree to the speculations. IMHO calling an external diff tool with
> two revisions of a file should result in the same as e.g. checking ou=
t
> the two revisions in two different working trees and then launching
> the user's external diff tool on the two working tree files.

Ok.
