From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-push: squelch advice message if in --porcelain
 mode
Date: Fri, 26 Feb 2010 12:04:27 -0800
Message-ID: <7vtyt3sr04.fsf@alter.siamese.dyndns.org>
References: <cover.1267211537.git.larry@elder-gods.org>
 <75b6d65f8028407cc1e8244a57823b3d87c520f1.1267211537.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6QU-00010s-JM
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 21:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965946Ab0BZUEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 15:04:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41233 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965876Ab0BZUEh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 15:04:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E7809DD4E;
	Fri, 26 Feb 2010 15:04:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QFulaHIW/i/OpNCZ4xvFRfx55k8=; b=XMAOpWrHlmiQL2VqECbrDTB
	TW47l3T+EZSStAs1C9qkg/Ks4sEErGY4P4xBicw44ksOUhayh/uZeLB/nuQPB3Zy
	Mb6s+wfESh/XdXz5o4gcD1vTi/cMa4TmdC6rnlWZ3gUhQ/u36UtGbxF4Xg1uGJhx
	/Bl4m55gFxe3YqpQQL0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OQGoSmRGJtkrhg9fXcnnON3M6do33DAPywKur+4wbZnQmMQ4e
	FTR50Pkn+unfJkto8Qr3Mz8G+glw9KjHtTXnAt6K5uGkR5n0ac9ZoAkvteq4jCQg
	DWQCIoJ3N5bmYNEPNhTffzUK+lAkQ9s7ULzfsKwhOp3ZkLy7F/RVYQIeUo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 399C29DD4A;
	Fri, 26 Feb 2010 15:04:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A331D9DD44; Fri, 26 Feb
 2010 15:04:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 26D18832-2312-11DF-B68A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141144>

I thought that the previous discussion thread establish that [PATCH 2/4]
is no longer wanted, as long as we send the advice message to the standard
error output (which is done by [PATCH 1/4]---by the way, do not call that
"an error message").
