From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: rev-list: fix synopsys for --tags and and
 --remotes
Date: Sat, 23 Jan 2010 12:04:08 -0800
Message-ID: <7vr5pgbnbb.fsf@alter.siamese.dyndns.org>
References: <20100123072627.6509.86297.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j6t@kdbg.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:04:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmDh-0004EG-QU
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0AWUEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303Ab0AWUEW
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:04:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0AWUET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3207D939DD;
	Sat, 23 Jan 2010 15:04:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=dxlAuGYGzHpyAh937qKYBum3HJQ=; b=C2rgXvxFYR1y0tI0zoV0++F
	U3d9LTdeWKHohE0/adBBPGz1Ykinx919Z5Dt9tRwAqyp/YBgY2QUc5xaWFfLCXbS
	ZzQ6MLsWXOnfQvfpEaQPDn9oSQ9AJWGUhB0dficXtN8Nim1UOHz5aNNWoSxwOL7k
	/DwySEXlsOQtt0jbcwXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Zc+CvR2nCOQty/hhKSGFu3v3/qc9lLSvCazVazsB45tCXUFEK
	ay/ugf0cFl/imeYwy5wZChr/pFNxVITMFOUHxkn294yCmLxE3d5jiFsq9PSqKLkI
	9jGxIVW9T9evOzFfQTCbhDNZ/wxHCYyGFgBfgBm2qGj61Azv9HvZ6oez38=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E39DC939DC;
	Sat, 23 Jan 2010 15:04:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10EAD939DA; Sat, 23 Jan
 2010 15:04:09 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B0DEDF0-085A-11DF-BE27-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137858>

I had to stare at lines before and after the change for two minutes to
notice what is being fixed ;-).

Good eyes; thanks.
