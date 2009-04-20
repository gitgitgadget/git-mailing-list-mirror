From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 03:33:00 -0700
Message-ID: <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:34:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvqpo-0000cW-GM
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbZDTKdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 06:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbZDTKdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:33:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590AbZDTKdJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 06:33:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 74D7810979;
	Mon, 20 Apr 2009 06:33:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C23F910978; Mon,
 20 Apr 2009 06:33:03 -0400 (EDT)
In-Reply-To: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 20 Apr 2009 11:48:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A33C6C60-2D96-11DE-AD34-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116962>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Ideally, "git push" from an empty repository to another empty one
> should be a no-op, or perhaps should error out cleanly. Currently, it
> just segfaults.

Didn't we see this fixed by Nguy=E1=BB=85n with 55f0566 (get_local_head=
s(): do not
return random pointer if there is no head, 2009-04-17)?
