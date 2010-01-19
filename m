From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix errors in t6018
Date: Tue, 19 Jan 2010 12:25:22 -0800
Message-ID: <7vtyuh970t.fsf@alter.siamese.dyndns.org>
References: <20100119065609.GB3946@coredump.intra.peff.net>
 <1263893748-23327-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 21:25:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXKdu-00063C-ML
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 21:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab0ASUZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 15:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360Ab0ASUZe
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 15:25:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0ASUZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 15:25:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A938925E8;
	Tue, 19 Jan 2010 15:25:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MnFIbgOzHGW4pI5g5Kaz47PjZwQ=; b=SHqd9Z
	T0yUvQyJ+5JNjA8aEsTSxFrSWCTHbirZkSVh1c3PcxPmsjNYwLyOZThvrWIQBG4v
	W0x/1zMhhWlEno1ngVl7UL9C84n6yUX01KeXYwJwlEAITzqG1RpWQZHbCrVerIdf
	A99YwTlUTfWntg69GC+Mt5GxuNITsY9Wsx6hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBpR+y6ZzbHtLEXAT7TI4d8go6ZxzsoS
	LUOnF7BnfLGXKBcZcb15qOCFTniM2BqBerfpM0IX5ZuyTqsK+dTNzDsb5QKbxlSV
	gp8nm5xff0QtoRJvIC58rTNPQzAipZUEjPQ6cCPpNJYFTcetGcIONewetO1k3VXX
	SZo+FeRUSBg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3209B925DE;
	Tue, 19 Jan 2010 15:25:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71695925DD; Tue, 19 Jan
 2010 15:25:24 -0500 (EST)
In-Reply-To: <1263893748-23327-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Tue\, 19 Jan 2010 11\:35\:48 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8551590-0538-11DF-9A57-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137493>

Thanks, both of you, for being careful.
