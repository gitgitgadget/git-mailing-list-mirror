From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branches & directories
Date: Mon, 03 Oct 2011 00:48:27 -0700
Message-ID: <7v4nzqikhg.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
 <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
 <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
 <4E889813.8070205@gmail.com>
 <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
 <20111003030723.GA24523@sigill.intra.peff.net>
 <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
 <vpqaa9ijzt4.fsf@bauges.imag.fr>
 <20111003073456.GA10054@sigill.intra.peff.net>
 <vpqmxdiikt2.fsf@bauges.imag.fr>
 <20111003074412.GC9455@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAdGM-0004RY-Mo
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717Ab1JCHsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:48:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763Ab1JCHsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:48:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 171683B9A;
	Mon,  3 Oct 2011 03:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+7hKHQ1XMQSq0zdos6VcXar8G4=; b=KqwQBA
	Om+VaF3vhtK10O+CLA6fu1UM+ugc9Pew7PIOirNdKxoHbMUGc7FgpI2wAbfKhI4W
	gzdmGaVM0mt3rqXZ4kVPH+OPI5k/EAfQFfB/ZvuG73oWqMgrINXk4PVAiFwMYoC8
	gJWt1upFss54Ec8JSjHQQ9DghfdnicAWmBiSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hrpCw9BEVpgGFLxODjvim1yn5HJ0UXM3
	IaeD1kOetT1Iwwjrwwfxas9y5d/RUAGAwcsaYSiH7K8sKPafUcT46UndiZuTmsvL
	YBJZjK1tMBOJqOX70YO/IfguHtDa+uR9wbD2DlDHMjIqkBOGjAECYjIdgj3nOTxg
	PcxceHK3MA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CC6F3B99;
	Mon,  3 Oct 2011 03:48:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B20A3B98; Mon,  3 Oct 2011
 03:48:28 -0400 (EDT)
In-Reply-To: <20111003074412.GC9455@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 3 Oct 2011 03:44:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 151A9964-ED94-11E0-A6BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182637>

Jeff King <peff@peff.net> writes:

> Yeah, you'd have to maintain your own dependency tree, then. Which is
> nasty (aside from the work involved), because I don't think you can
> portably get the header dependencies out of the C compiler.

Heh, but doesn't your Makefile know the header dependencies anyway?
