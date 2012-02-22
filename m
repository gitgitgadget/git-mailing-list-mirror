From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] remote: reorganize check_pattern_match()
Date: Wed, 22 Feb 2012 13:02:07 -0800
Message-ID: <7v4nuia8fk.fsf@alter.siamese.dyndns.org>
References: <1329505957-24595-1-git-send-email-felipe.contreras@gmail.com>
 <1329505957-24595-3-git-send-email-felipe.contreras@gmail.com>
 <7vvcn5qecl.fsf@alter.siamese.dyndns.org>
 <CAMP44s2HUG_ocHBaVpcsZHWMf2Tww+=bVun5H9+S5EGkoiJHRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 22:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0JKK-0007FB-1E
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 22:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab2BVVCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 16:02:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab2BVVCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 16:02:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D67F26E79;
	Wed, 22 Feb 2012 16:02:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zFmgHd25j1a0dcMsuscXmeV2Wxc=; b=VCI8wk
	nfvV3KW2Dsix0UKao5f5VfF5LDP5fimmzmw6AI4gfRfrZ0eaPHKt1tktShYQzvUh
	zo8H3r1Fyr8SGxepidyPAyzmXCJXmp92QBYFQtbDZ+5W+6OosGxrrXMgiPYAxouf
	PwltzU1p9Ciic8iF2f7As1Zdv5nAGS2BnY4D8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o6iiz+4ozRi87K9kBmg93JZwjxeAUHMZ
	uJ0iV8GG/jAFNRoeUtVXDB82kt2023Fdfha4sWdhKKyQHAJHksXzn3xqNvIWsOx7
	InQ12uz5Fios1TE9TDDbXRQYQgvDGLre6EIS2fYq5PTmAieLTxxDcVpYzdxWiprw
	JDXzwNACd/I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE4C46E78;
	Wed, 22 Feb 2012 16:02:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 659CA6E77; Wed, 22 Feb 2012
 16:02:08 -0500 (EST)
In-Reply-To: <CAMP44s2HUG_ocHBaVpcsZHWMf2Tww+=bVun5H9+S5EGkoiJHRQ@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 22 Feb 2012 22:15:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B622D58-5D98-11E1-9635-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191290>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> For a change that not just adds parameters but removes an existing one,
>> this is way under-described with neither in-code comment nor log message.
>
> But it doesn't. src is renamed to ref.

That is exactly why I mentioned that this is a "chance" in the part of my
message you did not quote ;-).

It was a chance for you to learn how the thought process of others may
work or not work well, depending on how well the log message at the top
prepares their mind before they start to read the patch, by looking at how
one reader (me) tried to figure your patch out.

Anything that I said in the message you are responding to that tempts you
to say "No you are reading wrong" is an indication that the patch did not
do a good job to help the reader understand what you wanted to do.
