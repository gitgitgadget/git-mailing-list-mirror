From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv14 0/7] Expose submodule parallelism to the user
Date: Tue, 23 Feb 2016 15:33:17 -0800
Message-ID: <xmqq8u2bngsi.fsf@gitster.mtv.corp.google.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
	<xmqqtwl4bedt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	peff@peff.net, sunshine@sunshineco.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 00:33:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYMSK-0004N0-M8
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 00:33:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbcBWXdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 18:33:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752049AbcBWXdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 18:33:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68DE0488B7;
	Tue, 23 Feb 2016 18:33:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s436lRqS9O5ixcWZ+d9asisPuXo=; b=I0RVwU
	9DubfErbg//a+aZHVucRiNQ7Xzt89o3rFgBRo08wxv0y8CAkRI2/y8Eh8PQS/Uy0
	vs+U1rhIAZi6a1sAoWbQGAKOILjETf+vXWq6TQV/wY/0VdNEpCBwJ/4SdIKGmzAK
	u2jW7kWZe1OWKW1EptG5CO1ApOlO3tAT6FLS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhsl8Hvdqy90Cb5lFbJD16sJqqGBAroe
	L+BFMLhzF23E0A+HNzDwyJv6liqWhJjhiLRBACvqDHgbcRa+XRfNx3HvsR0uq6Nq
	3XNuE+vN+RWH7cDblN/R0JxlJSuGpXymTxdlZcsTxm+tm+FhlloJw5DeyokglAQB
	aqJOj5Eda/A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F136488B6;
	Tue, 23 Feb 2016 18:33:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE15F488B5;
	Tue, 23 Feb 2016 18:33:18 -0500 (EST)
In-Reply-To: <xmqqtwl4bedt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 19 Feb 2016 13:04:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1B760A6-DA85-11E5-894E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287143>

Junio C Hamano <gitster@pobox.com> writes:

> Looks good.  I didn't notice these unnecessary blank lines while
> reading the previous rounds, and it is good to see them go.
>
> Let's wait for a few days and merge them to 'next'.  David's ref
> backend topic textually depends on this, and we'd better give it a
> solid foundation to build on soon.

So... it seems that you and Jonathan had a few rounds of back and
forth on 5/7 that didn't sound like it saw a satisfactory end.  Will
we see a reroll to address the issues raised?

Thanks.
