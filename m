From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] subtree: add makefile target for html docs
Date: Wed, 30 Oct 2013 10:48:36 -0700
Message-ID: <xmqqwqkubqff.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO1xPrAFG1tvS5zaVD9yefa2VUNYM93YLt1pQ1yJwHkrw@mail.gmail.com>
	<20131029155037.GA3628@sigill.intra.peff.net>
	<CAHGBnuNDBH-V+Ebi27BOE8ebNQdhn+MCvabh97_zL3nTctz4yA@mail.gmail.com>
	<20131029163037.GB3628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, greened@obbligato.org,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZss-0001PG-0K
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3J3Rsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:48:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579Ab3J3Rsl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:48:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B43044E215;
	Wed, 30 Oct 2013 13:48:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=11P+/OA8cDcZnfajKpyDx9eYhe0=; b=XqvuzW
	T1JhCnwum/O2dxCixbdJj2+OB+3T668V1TMvTiWlVWzzQvlchSadeetTs9TCpO58
	ivLBe26bYTzLQlcp+2JpCnPuLvM133fuoO3OrVndWVVE7T2x9bq0bNusMw1SdNyV
	n2Od9lxpE8wKFu8eJYuUcYj/iYJUGGlk3Ipmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHhioJuS5JpfhE2TO7b4uiNyf6mxARaw
	lMIiwcITHnmBJYRFdQrAxkltG+2gvAxyqUj+mWEJje4ZbRgiAqlvWOeuGqEhOrBr
	RL1hoFXq0HIxEGFlF4mD4pk8/xLzzZbwQMHygULWXPAkYZ6FMcnNC+VU4C6ZQqBR
	7EpwSM/CX9E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A51004E214;
	Wed, 30 Oct 2013 13:48:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED7DF4E20D;
	Wed, 30 Oct 2013 13:48:37 -0400 (EDT)
In-Reply-To: <20131029163037.GB3628@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Oct 2013 12:30:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 817B03B2-418B-11E3-A569-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237048>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 29, 2013 at 05:03:53PM +0100, Sebastian Schuberth wrote:
>
>> I just gave it a try and it works nicely:
>> 
>> Tested-by: Sebastian Schuberth <sschuberth@gmail.com>
>> 
>> Also, the clean target already contains "*.html", so nothing else to
>> do there. Any chance to get this queued in pu?
>
> Here it is with a commit message, and the additional wiring into "make
> doc".

Thanks, both.
