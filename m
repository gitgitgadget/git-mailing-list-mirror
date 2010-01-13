From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGFIX] Unbork remote helper execution
Date: Tue, 12 Jan 2010 22:56:00 -0800
Message-ID: <7v1vhutrwf.fsf@alter.siamese.dyndns.org>
References: <1263321344-21237-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001122053.29568.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 13 07:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUx9N-0000wA-27
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 07:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab0AMG4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 01:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754944Ab0AMG4K
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 01:56:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942Ab0AMG4I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 01:56:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B5B89001C;
	Wed, 13 Jan 2010 01:56:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=zxI6zPyekfwDOyoN6xReJB55mzs=; b=oT9iemTx4sH1swFxr0uZVoH
	LOdv1JqPcGIp5T0AQmNaM857rofpPNR64xuom9IQUDekZAD3yMY/s9fJosWVfLSY
	8E53lvhYwmOAeCFt9d5gdZc8UNs6ueG7mg3bBzRGzSiNYcu0aiqgmmsEBMsat1P1
	fw/zcoxkC3JxaQJEwb2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OVYKlfkTfT6UNcmSB3nS9up7GoUjk3g4WDkHQ49p0zhnQ3Ul1
	iX2Hz7s2a0IAwWgQMWSslq7PfRZgOfdNMid+5b2s0eSXSBNxOd/Vpmso3mCsyIDK
	G8GNwxaEYVYrbsXIuQFKhyRBcUh39VR2sU2RUY9KOsxmxEDIjlrWbnl2cQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 02FB59001A;
	Wed, 13 Jan 2010 01:56:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B0E090018; Wed, 13 Jan
 2010 01:56:01 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B7EFE31A-0010-11DF-9B93-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136778>

Thanks, both of you.
