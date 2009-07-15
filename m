From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Correct way of making existing remote repository "bare"
Date: Wed, 15 Jul 2009 12:39:31 -0700
Message-ID: <7vws69enws.fsf@alter.siamese.dyndns.org>
References: <h3khis$3tq$1@ger.gmane.org> <4A5DE3DA.1010004@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Graeme Geldenhuys <graemeg@gmail.com>, git@vger.kernel.org
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Wed Jul 15 21:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRAKO-00064m-Jf
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 21:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136AbZGOTjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jul 2009 15:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756087AbZGOTjh
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 15:39:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38494 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbZGOTjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 15:39:37 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F034C5387;
	Wed, 15 Jul 2009 15:39:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4B2245385; Wed,
 15 Jul 2009 15:39:33 -0400 (EDT)
In-Reply-To: <4A5DE3DA.1010004@dirk.my1.cc> ("Dirk =?utf-8?Q?S=C3=BCsserot?=
 =?utf-8?Q?t=22's?= message of "Wed\, 15 Jul 2009 16\:12\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3AD42436-7177-11DE-ADFE-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123332>

Dirk S=C3=BCsserott <newsletter@dirk.my1.cc> writes:

> I think what you did is 'porcellain' while my solution is 'plumbing'.
> Any complaints?

No.

We need to be careful and either (1) to have anybody who adds 'plumbing=
'
procedure to any FAQ responsible for keeping it up to date, as the
implementation detail is subject to change, or (2) only to have
'Porcelain' description in the documentation.
