From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove doubled words, e.g., s/to to/to/, and fix related
 typos
Date: Wed, 13 Apr 2011 11:47:56 -0700
Message-ID: <7vd3kqm1ib.fsf@alter.siamese.dyndns.org>
References: <87d3kq6tz7.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA56t-0005uV-4O
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 20:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209Ab1DMSsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 14:48:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab1DMSsI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 14:48:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BB1524640;
	Wed, 13 Apr 2011 14:50:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O1st6L5vK5bHT6k2hGF6OXDtNig=; b=hO8XoB
	m8A3KyTyh/zKdhNwaCUBwBOozow1NaH1Zkz1kf0aVsmSJ4O9rzluxjjwLTq3iCfq
	YlONeC0BTyxfFmok1dZ23JBBuO3CT3pAocHvwp+5qB+Yb4SZUzDiIlMWLHmEi2Pd
	FbQvCPL5xaYuck6usZNnZ/tooOjyLNhmicfrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MQugdMpWwV0GYm7CxFgakutVOWMLc6Fg
	AG8+czU3vNRr8vbg5bmqPNKdpkBC5C7QfQWWnnkAQRAdeWoeujW1+LQ/nYyp8tpZ
	tQgG0YxKlq5CYoM15pld5xsGuG8c/rcmV74zwDxkO6kAx2XeQlIIE6vRqsBrQwbk
	kG/STAmD1Bc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95FCF463C;
	Wed, 13 Apr 2011 14:50:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 10C4B4637; Wed, 13 Apr 2011
 14:49:57 -0400 (EDT)
In-Reply-To: <87d3kq6tz7.fsf@rho.meyering.net> (Jim Meyering's message of
 "Wed, 13 Apr 2011 17:39:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D675908C-65FE-11E0-ABF1-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171470>

Jim Meyering <jim@meyering.net> writes:

> I found that some doubled words had snuck back into projects from
> which I'd already removed them, so now there's a "syntax-check" makefile
> rule in gnulib to help prevent recurrence.

Thanks.
