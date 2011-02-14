From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] push: describe --porcelain just like commit and
 status
Date: Mon, 14 Feb 2011 11:53:02 -0800
Message-ID: <7vmxlys89t.fsf@alter.siamese.dyndns.org>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 20:53:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp4U1-00016e-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 20:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab1BNTxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 14:53:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab1BNTxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 14:53:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0CFB45AB;
	Mon, 14 Feb 2011 14:54:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QtSevo9exP40KSwG5fdb3PR5I0c=; b=La5rPe
	7eHZ0IXpQ94eyaKJY6PN7JjruQRqeHHT8WuzaE8kwt6xbkwu1ZECCpHJm/vdYtp/
	9GoaPnq2JwIPcBTz0QyR8qInYVSmaOAHi6jojjB3Lj4jSPwWddTIwMksghSrTicZ
	KG3XvxyJkXgjLHkmdbfEinQbmPlxD7X1mElO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qC+pCuuLVc7TPXCEBkaKMo3n9YWK3O5g
	bCpXuvxpZBQmdMPQozlodtgLZEo/MxlX8fM7pWQW8pl/x1OveRLml16JH4IfIX5c
	rwq1wEGznHWGVq4HYpQDQGchHu9d4W0Yo8FmhWR/bGdojnh9SlqqDFUpRINTWKSE
	7UbG6VssoEc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEEFF45A8;
	Mon, 14 Feb 2011 14:54:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35C3245A4; Mon, 14 Feb 2011
 14:54:08 -0500 (EST)
In-Reply-To: <3b6a87b585eea1722bd31bc9cf5ba2c80e37aefa.1297695910.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 14 Feb 2011 16\:10\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31F73216-3874-11E0-8E2A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166760>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
> +		OPT_BIT( 0,  "porcelain", &flags, "show porcelain output format", TRANSPORT_PUSH_PORCELAIN),

Thanks, but I wonder if machine-readable is more descriptive than
"porcelain output format", iow, updating commit/status may be better.

The option was meant to mean "output format for Porcelain script writers
to stay machine readable" but it can be misunderstood as "output format
a Porcelain command would produce with chromes and glitters".
