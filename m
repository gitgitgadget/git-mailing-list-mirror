From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do_one_ref(): save and restore value of current_ref
Date: Fri, 19 Jul 2013 12:34:51 -0700
Message-ID: <7vppueuyw4.fsf@alter.siamese.dyndns.org>
References: <CAPWNY8Ua=3t4jeDvkj3Aw2Ouvv+0r1kWrET5GNq9uS8PasGudQ@mail.gmail.com>
	<1373901857-28431-1-git-send-email-mhagger@alum.mit.edu>
	<7voba04ir8.fsf@alter.siamese.dyndns.org>
	<51E97ACA.40300@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0GSA-0004DV-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab3GSTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:34:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab3GSTey (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:34:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5658321A4;
	Fri, 19 Jul 2013 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AASEagoMG6BeAZDK/80cJcUfeO4=; b=kuATCH
	DaFSH9k4xKeYiDSaaE+BFj7I6t0bAb5oZsdF0fGiPN90laURU6sqDo8JEN2l3j5F
	zLzx1il5DYCTIhKaoHKBAer/RNgzE/qsJ9+MGdeisw5SF25L8DgPBs282jOqWmRN
	N9hdW0TdVjaHHriIxqd7wihmrVdqj59uacy6w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fqqnDXKZcET2qEoz4d2qS5+hoe33u1Za
	Sj7MW6TqTjoLHYtila0bowsSYqbggdrFWtCBcjCZSkwLhdMzX/vrxSJG0WV2jTqF
	0dOqtp7R46BoRZQvCS7Q677IgPqLSA7f1hkuaKwgN3csasi9ypxF13j1DFT2+WbF
	6nGocNXYC/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CB83321A3;
	Fri, 19 Jul 2013 19:34:53 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13D67321A2;
	Fri, 19 Jul 2013 19:34:52 +0000 (UTC)
In-Reply-To: <51E97ACA.40300@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 19 Jul 2013 10:43:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48CAA964-F0AA-11E2-95E0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230842>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I sent the patch shortly before leaving for a trip so I didn't have time
> to make it as complete as I would have liked.  But given that the
> problem was already in master, and the fix is pretty simple, I wanted to
> send the fix right away.  When I have some time I can fix it up better,

That is very much appreciated.  How would you describe this fix in a
two-to-three line paragraph in Release Notes?
