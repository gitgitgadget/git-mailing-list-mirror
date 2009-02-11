From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
 test.
Date: Wed, 11 Feb 2009 10:26:29 -0800
Message-ID: <7v1vu4g78q.fsf@gitster.siamese.dyndns.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com>
 <1234375406-27099-2-git-send-email-ted@tedpavlic.com>
 <1234375406-27099-3-git-send-email-ted@tedpavlic.com>
 <20090211180705.GL30949@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJoc-000087-9i
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbZBKS0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbZBKS0i
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:26:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755524AbZBKS0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:26:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AC12D2AEC1;
	Wed, 11 Feb 2009 13:26:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E173A2AEB5; Wed,
 11 Feb 2009 13:26:30 -0500 (EST)
In-Reply-To: <20090211180705.GL30949@spearce.org> (Shawn O. Pearce's message
 of "Wed, 11 Feb 2009 10:07:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 845C7FD6-F869-11DD-A4A9-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109474>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> -			elif test -f "$g/rebase-apply/applying"
>> -			then
>> +            elif [ -f "$g/rebase-apply/applying" ]; then
>
> There is some sort of whitespace damage right here, the elif doesn't
> seem to line up correctly.

If that is the only gripe and otherwise if you are Ok with the patch, I'll
queue the entire series with a fix-up here myself.
