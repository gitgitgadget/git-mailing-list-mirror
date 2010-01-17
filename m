From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Add push --set-upstream
Date: Sun, 17 Jan 2010 14:30:54 -0800
Message-ID: <7vwrzgweht.fsf@alter.siamese.dyndns.org>
References: <1263678331-9794-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:31:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWded-0002Q8-KM
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 23:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0AQWbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536Ab0AQWbK
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 17:31:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab0AQWbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 17:31:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D7895910EF;
	Sun, 17 Jan 2010 17:31:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AmKOcEaNk6zyoZfX/TqGLzAAeYQ=; b=mEKh2d8qZKLElMJCqN7Zxov
	Yy23T9X9jWQ19F09UIVsjOzYN0Ft4RtfEbAmRHS0xvVtOnH1tAR8JSnmmv28L+SF
	IRgtISzRVAdDqiTohQNk5ORmqgyN8mHjgwqnj2bhlkDPXusy9hpSNIoY6bImnLvi
	Q8aWUHQrpYlv8tbRU5Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=hDxZiFa9yVpTFvKeFX7BYBKQ214d33LcGU6gGvdehR2gPUvfW
	OcZC/SzwhLVEgmu/LXhpykB6yUA/aZIvFiREMyyZ3chnHEktHgiIgogDISJvmA6a
	Rg3bFcplfFDQXpqnBhcstqDgHxoHFwSy+itmLSeOkbCNHeCPtoki82wMwc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2E16910EE;
	Sun, 17 Jan 2010 17:30:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F399910ED; Sun, 17 Jan
 2010 17:30:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC0C1622-03B7-11DF-96E5-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137347>

Looks good; thanks.  Will queue on 'next'.
