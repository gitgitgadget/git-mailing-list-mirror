From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message
 friendlier
Date: Thu, 23 Feb 2012 12:28:54 -0800
Message-ID: <7vhayh2t15.fsf@alter.siamese.dyndns.org>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 23 21:29:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0fHj-0003vD-TL
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 21:29:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab2BWU26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 15:28:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60064 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab2BWU25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 15:28:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56BCC65C8;
	Thu, 23 Feb 2012 15:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tdbVnuBKgjdS
	NRokmyOqGaz2lAo=; b=KtFJ22yadsWGf4nnSJGqDx0roScgfGpnKd+KNP9/N2CV
	ODPnYkGN2wkV+rx+b5qNnavh0riySL/kP1hSRokHRqhEin6ZfBeIsVcU9YFKqPHG
	stGnhg8ldZToevtpzMpSkwpD0/sgOr+8240XvYJiRCBO60z4QQ+9o35DDR8mYFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bjuZWK
	8Ch9h5jtvikJIRNx4GSZtDfp9OfkMx3XPaklyfWmeLp04PTiSROckCsyqwbv+ggp
	0XxDuS/HeKA0bskf6Q7KHRsTukiKWKdZbh6ErXhjuyXfOBZF2z75jw8mxj9gVsMr
	pY3zCyO4/9KUGcErGTmh45F5rudnSxNowVJB8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DF6C65C7;
	Thu, 23 Feb 2012 15:28:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE39165C5; Thu, 23 Feb 2012
 15:28:56 -0500 (EST)
In-Reply-To: <1330013115-26355-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Thu, 23 Feb 2012 17:05:15
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 02B027A0-5E5D-11E1-8603-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191396>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The current message is too long and at too low a level for anybody to
> understand it if they don't know about the configuration format
> already.
>
> Reformat it to show the commands a user would be expected to use,
> instead of the contents of the configuration file.
> ---

Sounds like a change going in the right direction.  I am unsure if it i=
s a
good idea to remove "See git-config...", but otherwise I like the updat=
ed
text much better.

But of course I am not the target audience, so let's see what we hear f=
rom
others.

Thanks.
