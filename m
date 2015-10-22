From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Remove unused #include "sigchain.h"
Date: Thu, 22 Oct 2015 10:30:11 -0700
Message-ID: <xmqqr3kmstek.fsf@gitster.mtv.corp.google.com>
References: <1445517810-13998-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 19:30:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpJh5-0007su-3z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 19:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbbJVRaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 13:30:22 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751574AbbJVRaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 13:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC95B24544;
	Thu, 22 Oct 2015 13:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H0ra+51c90D5EMKcsf9OrMeOouo=; b=OBv2GK
	vhdBDhSTXvQagklQ5UKvRcLH402MLqK1XUhSiaglxBdQiodRCa1Bkc63cKAwqf7m
	fcyJXe9e/Y61+hEEQ7sH7b6kRuyLl9CrJO6eYhAq3reAtgVJgX9lzP4IMXc9w2sA
	xGOjeaxcyZeTFltrjTiTQeMDcx6GrXlysLEDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jm3zijr5rQ+7/7UTsyEvT2d9vm7bbBxD
	rjzJIUD+4ZwY1uhkKiybV+oT6Pw3+L2WTTFB/TWT6Axt6sFMj8iqvn1KWVNJOneE
	+ShnRgJZ3jyutDqXSRr8PLzuOxMqUaMfNVkPYhgUBJAx/DWeTn4NiTH/lQBp6K2y
	/rhbtvV0ajk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8348E24543;
	Thu, 22 Oct 2015 13:30:17 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0DDC62453F;
	Thu, 22 Oct 2015 13:30:14 -0400 (EDT)
In-Reply-To: <1445517810-13998-1-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 22 Oct 2015 14:43:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E714C58-78E2-11E5-82A0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280065>

Makes sense; will queue directly on top of the original tempfile
series and merge.
