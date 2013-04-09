From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Mon, 08 Apr 2013 21:54:50 -0700
Message-ID: <7vk3octiat.fsf@alter.siamese.dyndns.org>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
 <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
 <20130409043938.GA31447@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 06:54:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPQa9-0005HC-TV
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 06:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab3DIEyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 00:54:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab3DIEyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 00:54:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD6BEA72;
	Tue,  9 Apr 2013 04:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jLp+r+TTtfLqGiGZKwVBZs8TeTc=; b=Tq1PQx
	BwEWDhsszPVir29c/pZaEYxaGV8NA294SN+EQ4ee9K4bMLfU/YUIV9JnQ1Qz2ChL
	boVdZf2AD4OQW+ZppkOZlz36b4i2cqTqSLLefWZqbzjz2kyMlfduy58b2kBc4Z6Q
	WfJxMaFeGQQCELOme/ZNCdczA9NakHyhfhiwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cP6EHY1bFPwNuanVl8DKWRmpfNH5e00x
	/AxwMTft6p4uEZzd8ESSylU6s7GXtLB47r/cvWJDPNOlAb5EQohiLAH7PghkmRyq
	W3jK/Bt2iV5e2oZtGF6r21MZiW+rvpXtSFlzpjanJXvVLDdvDfEm/yzxAiPiW041
	ENQdmdr3Frc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A75D0EA71;
	Tue,  9 Apr 2013 04:54:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2A04EA70; Tue,  9 Apr 2013
 04:54:51 +0000 (UTC)
In-Reply-To: <20130409043938.GA31447@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 9 Apr 2013 00:39:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D219136-A0D1-11E2-8A96-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220550>

Jeff King <peff@peff.net> writes:

> The tricky part is how to store the index for each commit (or object). I
> don't see a way around adding a new field to "struct commit" to do so.

We could reuse the space "indegree" used to live at; that is a
one-word space already, and I really do not need "encoding".  It was
no more than "while we are at it, we could add different things
here" demonstration.
