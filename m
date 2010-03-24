From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] gitweb: fill in missing parts of minify support
Date: Wed, 24 Mar 2010 10:11:47 -0700
Message-ID: <7vy6hhskz0.fsf@alter.siamese.dyndns.org>
References: <4BA5133E.6050901@mailservices.uwaterloo.ca>
 <4BAA3FF7.9040100@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Wed Mar 24 18:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuU7j-0006qj-G8
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 18:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab0CXRMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 13:12:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0CXRL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 13:11:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 75602A4E22;
	Wed, 24 Mar 2010 13:11:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9nS2eZF6xWnFdyInjjiI8AMKdxI=; b=pmjk6/
	w9us23hk8tDrTwtLaSdT+hOKGnvZaxoYISORWzjpNV9TImxe+/WMwW0Bl1aXtufD
	Rwo+Qx2lA9Qber4wUXdvy9hU05HmNMsbBhc9PnYOIReRYkl5/fZHQwpnipB5p9Ki
	dDdCBj7jMAuFp2cpiyGDOfFL+Oc2CiLTHbelc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xLbO1kzFILp64e+e45iZG/WpbP112tUC
	waM4sII50EMCmhAlclTndIIBWTW1Wd2VFUcYB6KCwgumrIQRzjdBRk+h5wo9c1Fj
	Jl+NTtUWoXYBywE6TZ15InD8knLt0yWj4AU7Nva69yUBZNhdfsDI5/j0vy+NSF0N
	d/nENGIet1g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 084EEA4E13;
	Wed, 24 Mar 2010 13:11:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E6D9A4E0B; Wed, 24 Mar
 2010 13:11:49 -0400 (EDT)
In-Reply-To: <4BAA3FF7.9040100@mailservices.uwaterloo.ca> (Mark Rada's
 message of "Wed\, 24 Mar 2010 12\:38\:15 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 58127130-3768-11DF-B141-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143094>

Mark Rada <marada@uwaterloo.ca> writes:

> Hi,
>
> Has this been dropped? Does it need to be modified in some way?

Thanks for a reminder.

I didn't look, but I still have it in my inbox, waiting for gitweb people
(if Jakub is busy perhaps Pasky or Giuseppe) to comment or say "all the
issues raised in the previous round is now clear and it is ready to go".
