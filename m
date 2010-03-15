From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] xdl_merge(): add optional ancestor label to
 diff3-style output
Date: Mon, 15 Mar 2010 01:10:50 -0700
Message-ID: <7vzl2a0zud.fsf@alter.siamese.dyndns.org>
References: <20100305215253.364.63583.reportbug@localhost>
 <20100305221950.GB5083@progeny.tock> <20100315074748.GA28827@progeny.tock>
 <20100315074909.GA8824@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 09:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr5OJ-0005Eo-AX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 09:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759818Ab0COILG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 04:11:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759808Ab0COILE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 04:11:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 91741A1DC0;
	Mon, 15 Mar 2010 04:10:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJFPZL502r2N7rKsmLsylhtA2Us=; b=EujQYi
	yqCE4oBH6t+0iH0KvhxadXJ6j6zAPys5wwRE8nlrR9hizkag8/oQhT9LItwmWGYW
	rV1SHPhQeIVfEgMcm2m1XRFWFx9WJXr/wqT3mphe/HU8RtPKg//Me4Cc4ywZaWZT
	99cEg78zIO623IbFdGuT7nEg5VZpHnycjySRg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hKNgBN1GMetwH1ICL5iW73cte+wIgREQ
	SOBk6g9ZhJ6M6eiuWlGZ90HqfAaqaJdE3/77zA3ho3wMiPS33JmGEEWhI9k8JVUv
	DV1Y0HWPT9eB4BLPQ7A8TGCyMdqA/zsm4PFA8U/EtCw3tQ2pHwm5aMPmZcGjtfYM
	XEvsJ12G7W0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 59878A1DBF;
	Mon, 15 Mar 2010 04:10:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA5F1A1DBE; Mon, 15 Mar
 2010 04:10:51 -0400 (EDT)
In-Reply-To: <20100315074909.GA8824@progeny.tock> (Jonathan Nieder's message
 of "Mon\, 15 Mar 2010 02\:49\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 47979BA6-300A-11DF-A3A3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142187>

I think this patch itself makes sense, but if you were to add one name to
xmparam structure, wouldn't it make sense to store all three names in
there?
