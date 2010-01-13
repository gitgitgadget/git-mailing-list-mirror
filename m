From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filenames and prefixes in extended diffs
Date: Wed, 13 Jan 2010 11:49:11 -0800
Message-ID: <7v4ompn5u0.fsf@alter.siamese.dyndns.org>
References: <201001131713.05505.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:49:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9Dj-0003BH-8j
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0AMTtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754792Ab0AMTtT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:49:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667Ab0AMTtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:49:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DCC1909FF;
	Wed, 13 Jan 2010 14:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UgO7gILWWSdZy/6dPqvp/th5cHQ=; b=YmIyBnlfakvxBkEZ4xKqfN/
	aFdOSAGuh9DxURSPOgVpL6dWH+HYNn1eFG7qFbvrA7pi6L1WvTfXIYdbe9hd13nI
	QrKnRHoKm5YsFhQUNd0BKc56je/CU+MiC0CPbGtVbFW1QgpPSS3hPy2Cax9oPFXb
	Z9Sm2ggeFLblj52Q3Uuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=E1kPRWrqJ3mYeyYfUtUNwLSMBgGMfsBtvY257q+qE5+se/OZY
	RdUZkNy9vs6uqyKH96oqYjb70czRfqNPmS2qxPIyNOcd2dAEd+qLTqJwj61VqjDO
	wWg2VNY9B1ks6RUEs1eNOzO2ONT0MEnIFGr+PLeFqaEhSQDrWRsbxKXpO0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78453909FE;
	Wed, 13 Jan 2010 14:49:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D818B909FA; Wed, 13 Jan
 2010 14:49:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BAD18F40-007C-11DF-86FB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136867>

Andreas Gruenbacher <agruen@suse.de> writes:

> Any ideas?

How about studying what "git-apply" does?
