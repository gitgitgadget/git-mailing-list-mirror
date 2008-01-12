From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 11:09:19 -0800
Message-ID: <7vhchiuahs.fsf@gitster.siamese.dyndns.org>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
	<200801120926.14307.ismail@pardus.org.tr>
	<7vejcnwl85.fsf@gitster.siamese.dyndns.org>
	<200801120947.48602.ismail@pardus.org.tr>
	<20080112090432.GA6134@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:09:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDljv-0007WS-8J
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758205AbYALTJ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2008 14:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757954AbYALTJ1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:09:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740AbYALTJ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 14:09:26 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5632D52C2;
	Sat, 12 Jan 2008 14:09:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E131952C1;
	Sat, 12 Jan 2008 14:09:21 -0500 (EST)
In-Reply-To: <20080112090432.GA6134@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 12 Jan 2008 04:04:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70347>

Jeff King <peff@peff.net> writes:

> It might be more readable to actually set a variable pathspec_size an=
d
> use that.

Ahh.

Yes, the "seen" thing as R=C3=A9ne suggests is moderately painful to
get right and in the longer run I think we need an API clean-up
around pathspec handling.  In any case, the fix looks correct.

Thanks for catching this.
