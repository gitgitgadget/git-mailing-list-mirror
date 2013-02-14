From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.txt: update description of the configuration
 mechanism
Date: Thu, 14 Feb 2013 10:03:01 -0800
Message-ID: <7vvc9u22p6.fsf@alter.siamese.dyndns.org>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
 <511D0D88.6010302@drmicha.warpmail.net> <vpqzjz6ampm.fsf@grenoble-inp.fr>
 <7v4nhe3joq.fsf@alter.siamese.dyndns.org> <vpqy5eq94rq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:03:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U639f-00031y-5O
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 19:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761503Ab3BNSDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 13:03:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758326Ab3BNSDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 13:03:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFC10C2BF;
	Thu, 14 Feb 2013 13:03:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NWZVE0EWim/H1CzY9ROtTy+N57Y=; b=YTsOW7
	aGCKZ7nx08cW6FLIc1wWEj7C4wY0uwOFicreLjPykr++23b23tJ3AOLAWdEXFVVB
	fByUGaubYXNDqZp5/ZBZz8Qum3vH4MO+2K3OfGqnFREKo4gu2+LY4LVmAaienE9w
	7RU1PruzRRZn4aMoCICUXEB09Rg6gujYzxN5E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IKCJTQFURwuHDWn2EleSCpB7d3XxUeXX
	nKampBID9big9T54JyJqbMIg+0SaUG+UUhaMDUvxUupDawTptegKWO8dYUVU4LpH
	pjjuwGg+OuzaA7A2f8cCEU3Ow5W+oITjODzRaSNBCYx4RFPkpLjpK7DMukh/TfZT
	nHn5OCGKc4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3F33C2BE;
	Thu, 14 Feb 2013 13:03:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59FD4C2BD; Thu, 14 Feb 2013
 13:03:03 -0500 (EST)
In-Reply-To: <vpqy5eq94rq.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 14 Feb 2013 18:36:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6B819A0-76D0-11E2-BF7D-ACA62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216328>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But the exact location of per-user and per-repository configuration
>> files does not matter in this context and is best left to the
>> git-config documentation.
>
> I'm OK with your version.

I already queued your original with one s/not/now/; perhaps I will
redo it then.
