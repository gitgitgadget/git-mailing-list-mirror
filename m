From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fix reword when using a terminal editor
Date: Mon, 19 Oct 2009 01:05:46 -0700
Message-ID: <7v4opv6c6d.fsf@alter.siamese.dyndns.org>
References: <1255674753-13949-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 10:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MznFk-0006Ns-3L
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634AbZJSIFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 04:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754572AbZJSIFw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 04:05:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbZJSIFw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 04:05:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 167BA5E985;
	Mon, 19 Oct 2009 04:05:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=44zXNQSDctEP6RwxaD6gxidinTs=; b=q68pe8KYXX2cekR3DUtCLfm
	2MOmF3QvwfT/QWcNvckkojh2NeTAYMJvreSp/GnCD6x8V5w0Nw8oFFGBi/QpkD1y
	HWM4zmcYJqR7AL0u7W5OqomLvyCmBBT7C5RY1q4hBo5iQ6bplfsjkkdmJfyBVHTr
	haOngUtiuHhnkJrgVDtg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MMXaOFfBnxiCauuVx2a35rD5IB+98MWIV1KclKqLUNvxt1NxK
	gIxb//gK9xCuGpG3DT6lAVmGmqtMX4c1XNCPxadr0w4+G3VNJq/IerCFKW7dU4SU
	hxWqH3mV8pGSkx/HIBs1weV+6KIsITAyUCWdsMmyxUfDr6VpC5sVO6wvjI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCF8B5E981;
	Mon, 19 Oct 2009 04:05:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50AE65E980; Mon, 19 Oct
 2009 04:05:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 37666CBE-BC86-11DE-82C2-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130673>

Thanks, applied.
