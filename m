From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a commit.signoff configuration variable to always
 use --signoff.
Date: Fri, 26 Dec 2008 16:36:38 -0800
Message-ID: <7vabaijvxl.fsf@gitster.siamese.dyndns.org>
References: <1230296219-16408-1-git-send-email-dato@net.com.org.es>
 <20081227070228.6117@nanako3.lavabit.com>
 <20081226221033.GA841@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Sat Dec 27 01:38:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGNBy-0004L6-5P
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 01:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbYL0Agr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Dec 2008 19:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYL0Agr
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 19:36:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYL0Agq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Dec 2008 19:36:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D7E61B27D;
	Fri, 26 Dec 2008 19:36:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D74D11B27C; Fri,
 26 Dec 2008 19:36:40 -0500 (EST)
In-Reply-To: <20081226221033.GA841@chistera.yi.org> (Adeodato =?utf-8?Q?Si?=
 =?utf-8?Q?m=C3=B3's?= message of "Fri, 26 Dec 2008 23:10:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7046077C-D3AE-11DD-B6AB-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103971>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> ... I'd
> still like to hear if my patch would be suitable for inclusion, becau=
se
> it's much more straightforward to use (and to discover).

But "straightforward to discover" is not an advantage in this case.

As long as it comes with documentation that clearly explains why this
feature should not be used blindly in order to avoid diluting the value=
 of
S-o-b, I think the feature itself is not a harmful thing to have.  Dsch=
o's
argument in the quoted thread that says it should be a conscious act to
add S-o-b (except for the part he misunderstands what S-o-b attests), i=
s a
good one and still is valid.

By the way, please do not deflect away responses meant to you by using =
a
Mail-Followup-To header that points at the git mailing list.  It is rud=
e.
