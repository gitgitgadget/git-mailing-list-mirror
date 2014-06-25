From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t7510: Skip all if GPG isn't installed
Date: Wed, 25 Jun 2014 15:24:00 -0700
Message-ID: <xmqqwqc46327.fsf@gitster.dls.corp.google.com>
References: <1403585536-32185-1-git-send-email-brian@gernhardtsoftware.com>
	<xmqqfvis8zaw.fsf@gitster.dls.corp.google.com>
	<20140625214217.GA13564@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:24:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzvcG-00089q-7C
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 00:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbaFYWY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 18:24:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51968 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755519AbaFYWYH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 18:24:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72DBF228FF;
	Wed, 25 Jun 2014 18:24:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2ro0G9HLlDse5okZWziRs8x+uSU=; b=fCUhYE
	Dt2b5CI+udQKoWr+KCI0OLEtBkSlkhbW7T7XJRuMofIqVy7nCtkmX4RY85ThUWSx
	641/ZuspxxlNUYfLMKJm+1o+yAS3vaqH4MdSg1Ctn7r98ruml1++tg+cgmMMCUOT
	n1blbIZ2IAMY7Pjl1YxvRvZde6jq+FkFK1YsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhQPmQ3FnZR01f/yq9tbK0Gx+mS/CkR3
	J0kbQP43KChhOg+dK1O7CqW0suWSuNv1hfK8O0FkZ4HnjEkYJp3Q0dYJ4etD5KJU
	v4qDKZN7j1KIX6OZuB8aOdy1UwQ09T0XONRxrfAMgir9AC+TosjC3Vrtwutnm40S
	+vesOBNMu9w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BC96228FE;
	Wed, 25 Jun 2014 18:24:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9765A228FD;
	Wed, 25 Jun 2014 18:23:55 -0400 (EDT)
In-Reply-To: <20140625214217.GA13564@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Jun 2014 17:42:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65147D2E-FCB7-11E3-B199-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252469>

Jeff King <peff@peff.net> writes:

> ...
> I think it may make more sense to just configure gpg.program to "false"
> for the NOGPG case. Then you get coverage both on systems with it
> installed, and without (you could also just test it on GPG systems, and
> drop the "ship commits in fast-import form" part of the plan).
>
> Anyway, that is all outside the scope of the immediate problem. Here's
> the patch to fix jk/pretty-G-format-fixes.

All sounds sensible.  Thanks.
