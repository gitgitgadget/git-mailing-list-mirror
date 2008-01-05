From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sat, 05 Jan 2008 14:11:42 -0800
Message-ID: <7vwsqn7wip.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801050507x369976b7sd5e112451bc90331@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Tsugikazu Shibata" <tshibata@ab.jp.nec.com>,
	"Jeff King" <peff@peff.net>, "Dan McGee" <dpmcgee@gmail.com>,
	"Dmitry Potapov" <dpotapov@gmail.com>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 23:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBHFv-0002bb-OJ
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 23:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757237AbYAEWLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2008 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757439AbYAEWLz
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 17:11:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60222 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927AbYAEWLy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2008 17:11:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5D38053;
	Sat,  5 Jan 2008 17:11:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A2D88050;
	Sat,  5 Jan 2008 17:11:44 -0500 (EST)
In-Reply-To: <e5bfff550801050507x369976b7sd5e112451bc90331@mail.gmail.com>
	(Marco Costalba's message of "Sat, 5 Jan 2008 14:07:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69686>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I understand the patch series is too intrusive now, but if you want I
> can send a simplified one that just fixes the off by one bug for now.

How about the one that fixes first and see how bad the remainder
looks again?  I recall that R=C3=A9ne were not entirely unhappy with
his last round.  And I do not think that change does not have to
be "a series" but can be a single change.  At least it did not
look so complicated, but I may be misremembering it.
