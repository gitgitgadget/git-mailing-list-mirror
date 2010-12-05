From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 05 Dec 2010 12:15:50 -0800
Message-ID: <7vd3pgugax.fsf@alter.siamese.dyndns.org>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
 <AANLkTimX215CNAG_mosqzOh-EPBoSimK0s-n4YmKm1rb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Dec 05 21:16:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPL08-0002wU-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 21:16:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab0LEUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 15:15:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab0LEUP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 15:15:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 82360364C;
	Sun,  5 Dec 2010 15:16:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J1NA4NfvDR8bBYLw2XSI46T+FyI=; b=QDagNy
	GOsrOSfGAqz1EaQGM4fv7F5XGG/wXIdua+rxb7m9Wo1hNy08b/fiAa2ERE1SprGL
	nVKXthVXkHjT0y10m9mRibAfaC+qqFNUV6eDLExOc4obfknAly0ghJMod1Ww8/v9
	5vr2QjFVURgrVpkOMHx1art7iFk3g3VcFJS9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qUTRQgzY8FKPMsmVnC76471spYOwfkTI
	ypFQfRJ9YhXNnWI8rc9ZUnqixdjCgohOhLGtCRVqGVbeZy7l8bFrVSI3nQCROyjB
	pgHbOjIpY7q8gCFeBj+G+OTfZHnXPoS8M5K+8RqOlcGBaHdxTBDDQ6VsyeY9SQwO
	raN13+yUFjs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B4F0364A;
	Sun,  5 Dec 2010 15:16:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7F8873649; Sun,  5 Dec 2010
 15:16:13 -0500 (EST)
In-Reply-To: <AANLkTimX215CNAG_mosqzOh-EPBoSimK0s-n4YmKm1rb@mail.gmail.com>
 (Erik Faye-Lund's message of "Sun\, 5 Dec 2010 14\:00\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83993B00-00AC-11E0-955B-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162959>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Reroll, or squash?
>
> I was planning on re-rolling, but looking at it with fresh eyes it
> doesn't seem like there's much useful I can do. So feel free to just
> squash it. I think the original commit message still makes sense.

Thanks.
