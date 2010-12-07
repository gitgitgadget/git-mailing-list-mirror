From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rm.txt: Fix quoting
Date: Tue, 07 Dec 2010 11:12:18 -0800
Message-ID: <7vbp4xqtwt.fsf@alter.siamese.dyndns.org>
References: <4CFDF388.6060907@drmicha.warpmail.net>
 <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:12:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2xo-00061C-Du
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0LGTMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 14:12:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab0LGTMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 14:12:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BD562E36;
	Tue,  7 Dec 2010 14:12:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rxXZv+5ZOI+u9HEk2TnIho00gkE=; b=Y/3k3K
	qbucudCcL45ocMoWGUqueFECUOlrulAfa4nPr+/OGWqMkS1GUGGurYpiSPz3EvLt
	J4CfgMPtm94yW8WgR+QadMLkvLTvBM/E+w3dIbZqqMZEXwIi9wsUE1wVtEZdAOin
	VE3kIvE2PFRTbORtIuVQmCvLy7W3pHK8uRBL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JaozIHNDTLUTE4Yfo3+ghlrkSsvoXv4k
	8LAVnxGyhWT02VIJE4ILBStLJkg/Mlnfd+BJvLw9I2s9pP3eXNNmUBLK6auXvNQf
	qHFXSbcOml5r5veCmQ/deuIpdY5Oemap+iGpNnbd7pzSLMAyYyXQJ9EwWRrfJT+u
	LNXoqJBVX6c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 397A22E34;
	Tue,  7 Dec 2010 14:12:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DCA12E31; Tue,  7 Dec 2010
 14:12:42 -0500 (EST)
In-Reply-To: <73d13b752212b557c0dc157edea9a62122840e93.1291712241.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue\,  7 Dec 2010 10\:07\:11 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA002C56-0235-11E0-9474-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163115>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> -Using "git commit -a"
> +Using ``git commit -a''
>  ~~~~~~~~~~~~~~~~~~~~~

Can you keep the length of the underline the same here, or do you need to
extend it?
