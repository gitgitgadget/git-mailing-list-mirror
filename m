From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Rescuing repeated merge of
 Documentation/git-merge.txt
Date: Sun, 17 Jan 2010 02:07:04 -0800
Message-ID: <7vaawd82pj.fsf@alter.siamese.dyndns.org>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 11:19:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWSDm-00050o-FE
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 11:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624Ab0AQKHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 05:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753626Ab0AQKHR
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 05:07:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab0AQKHK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 05:07:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A6E915FB;
	Sun, 17 Jan 2010 05:07:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7UaREsIbQcCRSJbdoMfep/dWrD8=; b=cH4eSV
	lDMBoyZo0Aci9G7+bJ5H4lL7Y9bfbu6RK2brfIDG7Rb3XG7qIQ0rG0CYdoZ2IiYx
	ylhnGV+QHQGDGXRLHODXrcuV9H+DTXZ7ZpI6OH+x88MRe3qsm32E+m0bkgv83Srk
	cmjpuiqbH2woE9ReuQzIv8Dw4NKTJz3GL5DQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgxbYNy2qPEk4FA5tyFzMJsts7cNGsPG
	EZBc87u2Vqfl335isVosWh58EGU73k5JHvQBkWQn153IGyCzPxmSmjwgcujBU5dS
	z79y1OHv5jzJQ2cKSd1mR0aX4xX6u9BSgEhyeViqodj8YE5U2Do/Q9CWPDTsdMGG
	CPLmkOmzock=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C64A6915FA;
	Sun, 17 Jan 2010 05:07:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19106915F9; Sun, 17 Jan
 2010 05:07:05 -0500 (EST)
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Sun\, 17 Jan 2010 01\:38\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11F26580-0350-11DF-906B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137291>

7th one of the series has a minor nit; I fixed it up before pushing it out
to 'pu'.
