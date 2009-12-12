From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Update advice in commit/status output
Date: Sat, 12 Dec 2009 10:27:01 -0800
Message-ID: <7vws0st5e2.fsf@alter.siamese.dyndns.org>
References: <7vk4wtysyu.fsf@alter.siamese.dyndns.org>
 <1260608523-15579-1-git-send-email-gitster@pobox.com>
 <fabb9a1e0912120813h1c41b7bfg4525f8f01e04ddb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdGV-0005De-Po
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933443AbZLMB2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbZLMB2q
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33249 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933424AbZLMB2n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A1544876A4;
	Sat, 12 Dec 2009 13:27:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWLOYV7Ns3QOqi0osPZK/Aq101k=; b=PPHsWg
	+WMm1mgaii7q9YpkkWXXTq4eqjrABB/rB9QVw3OMZnJy9uW/iZZbCZfFXvtBrpL3
	rvuN9rI2dQccaLnm95qTgWK7evNOAV+wNlnhPxugNGVNqX4QXv58cs0j7USbGQTc
	BQOzyBvsxtOWVQSss+jBYZu/G+I01tTQB39hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMtGe+HXG7L8v5CBGxH/n9N7DnkQU7J6
	dXMzMozNLQbgn4fajSrmL/E+MqSyeS1oBPfHPnXDvk+rJePRxVpKqKEXofMt71Ai
	gIlrf8zA1BBE7He0sSqeJFr2kBlWlbIVU/3BHvgt8TE+C3nONZv/SiyFUzxFe2Bi
	tF7AT9KNZRE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C3C5876A3;
	Sat, 12 Dec 2009 13:27:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C06FD876A2; Sat, 12 Dec
 2009 13:27:02 -0500 (EST)
In-Reply-To: <fabb9a1e0912120813h1c41b7bfg4525f8f01e04ddb1@mail.gmail.com>
 (Sverre Rabbelier's message of "Sat\, 12 Dec 2009 17\:13\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3B197F0-E74B-11DE-BE29-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135138>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Sat, Dec 12, 2009 at 10:02, Junio C Hamano <gitster@pobox.com> wrote:
>> In neither case, "git reset HEAD <path>" is absolutely a wrong thing to do
>> while merging.
>
>>From the patches I'm guessing you mean "In either case" instead?

Correct.
