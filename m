From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 13:27:28 -0700
Message-ID: <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjyps-0001Ed-Av
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370Ab2F0U1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:27:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54737 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462Ab2F0U1c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:27:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E2E791E8;
	Wed, 27 Jun 2012 16:27:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=En5VYVx5BV5Hh19zOJewLW+TAI8=; b=OLSONH
	4Yc4S/CU8JWCP3hMssdFofReKRIrAb2YuoWGU3dBh47oFAMsr3cVudlUGhKyuhxu
	aiXeE3p2gYHgmIiEpOC4hK/L71/QT/I6lPI4a+bLWGkcqtLDvztvZSMarAMdGzW+
	1OZ/LYOz8qvC5uRKHGRIO5ECryRMaLiyF0ycc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zd228hHOoiSkaf/UtdWBiG1PzqG0e3Td
	lcAtIwcSIvag0syGPN1reispu0RiVNe2oisedFKoSAc8pnt2OUSd+TuXjf3ArMUU
	dEHEgwUFGujgOUm84awiLIajySA27aEdd3wvP3HciAJqvzdptVRE5YYWQSBKYBmd
	5IhBQ3EOT84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5563A91E7;
	Wed, 27 Jun 2012 16:27:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA28791E6; Wed, 27 Jun 2012
 16:27:30 -0400 (EDT)
In-Reply-To: <20120627195205.GA11700@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Jun 2012 15:52:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8517CF86-C096-11E1-BCB7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200742>

Jeff King <peff@peff.net> writes:

> but that code path should be fixed properly (with a use_stdin flag in
> the filespec).

Yes, just as I said; I am finding more and more issues with the
no-index hack that I have been fixing a bit by bit since I send the
message you responded to.
