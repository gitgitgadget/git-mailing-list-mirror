From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t4038: add tests for "diff --cc --raw <trees>"
Date: Tue, 05 Feb 2013 14:27:13 -0800
Message-ID: <7vehguqtvi.fsf@alter.siamese.dyndns.org>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
 <7vip696i3v.fsf@alter.siamese.dyndns.org>
 <20130205202558.GX1342@serenity.lan>
 <7v8v72sczp.fsf@alter.siamese.dyndns.org>
 <20130205213949.GY1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:28:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2qzb-0007Uv-5R
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 23:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab3BEW1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 17:27:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757324Ab3BEW1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 17:27:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9D091AB;
	Tue,  5 Feb 2013 17:27:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FiPpc+
	NzfPYysPACCVtH9csloDa+tnncA/qxi+sPYF0+QMB8qF0veYsN0wYddyvxBRjPlW
	J+ZQ3Jjq+BPhOWkem2luRlpEV772ZkPgjsJt+R3Hw08N8n6kbYrLps3HVELKeSV2
	XBQRWcvyx3NLaQpnosKavU/dUjaS/dNFlPhT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SD9A4Vefp3T47nPbjnF1aV9grskAsYH7
	WqmdOxAbtk6wsd0JViRaRvypo0H3nlqtHLbpl7+XLmmXuPxlJP++tCd7Lk4D3akI
	a9o/QN/U3n8aXdus4TVaLTe5ujnPLKwruX+nTxSV1i6+ePqUWoC7mMbWjfbH35UQ
	wEN/jUPoddg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 416BF91AA;
	Tue,  5 Feb 2013 17:27:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B04BB91A7; Tue,  5 Feb 2013
 17:27:14 -0500 (EST)
In-Reply-To: <20130205213949.GY1342@serenity.lan> (John Keeping's message of
 "Tue, 5 Feb 2013 21:39:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3124FBFE-6FE3-11E2-AEE9-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215547>

Thanks.
