From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 12:23:22 -0800
Message-ID: <7vd436uzet.fsf@alter.siamese.dyndns.org>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911250656k31229c42jd79fb94c1a619e59@mail.gmail.com>
 <7vr5rmwgbn.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOOy-0002Ex-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935017AbZKYUX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935021AbZKYUX2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:23:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934960AbZKYUX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:23:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB9BE8206D;
	Wed, 25 Nov 2009 15:23:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+vIk34Glybj6suM8RKSHj3jhTg=; b=OyMxfu
	g7OyFjE/FkmdPBvbIIH4/XSq6LkccEsDmjauLjRiXEAjeXZhDnd2+OImf2/th0/l
	5awDtoS5ItebgiG1tJbBKzwiPSv0+Ga81WLqNh9f/67HQGXJZXdEdkA2RRgaVv1L
	AhOS9QzfqOJSieB1hUA9QBfFG4e4+ST6/tbmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHatYNY8jjYDVSgVDFBl4rKTpaC6Q9ob
	Px/oGtPNmPcUB4Z0z2OchXUZJ/f90dYK9oESB4FkK2BdJPRUOAjUGUYD/cp/TWUp
	LsICX5ztrMfZX7E1ySHtOAgU8VYPib/wzFONBf04oMwpHOtfyY7sU4yBBwfYXMoW
	cuxRemUeye8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B38F8206C;
	Wed, 25 Nov 2009 15:23:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F8F38206A; Wed, 25 Nov
 2009 15:23:23 -0500 (EST)
In-Reply-To: <fabb9a1e0911251219t3ad0dacen67d8615ef6eefa02@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 25 Nov 2009 21\:19\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 62EA3D6A-DA00-11DE-866C-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133668>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Nov 25, 2009 at 20:32, Junio C Hamano <gitster@pobox.com> wrote:
>> The standard answer given by others has been "you can always say '.' at
>> the end; having to remember/count number of ../ necessary is much much
>> more inconvenient".
>
> A commandline flag to keep the old behavior then perhaps? "git config
> alias.gr 'grep --no-full-tree'" is not that hard to write either.

But then you can alias "gr 'grep --full-tree'" with the same ease and
there is no reason to change the default.
