From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] revert: Don't create invalid replay_opts in
 parse_args
Date: Mon, 11 Jul 2011 13:44:42 -0700
Message-ID: <7vk4bobjjk.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 11 23:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgNuw-0004Gx-QL
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 23:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab1GKVVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 17:21:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab1GKVVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 17:21:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4311F6A07;
	Mon, 11 Jul 2011 17:21:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=o1w/ottRXbbReamb+Jq8vXNVnjI=; b=ncbAzxLqnsSIbfo47fdX
	lIIrexlaC3mvfsOrTzN7JK0wrVEj9EAUfoQv+p3ODkNliIdbOS7p2oW+UfDtHoNo
	JQDGd6VJD2XFwuz3I8/IXW1IEMLQaPE8WT11/tWNHQmPnUPNZWPFHyCERZCx98WK
	3ADwwCP+QIRxFiq/qLO1d6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=e/s851NcS8PsS/J7Ys5Pbt9sF7swLAOJB8ZOxRFRxWTFGU
	VlR3Nj7ueSD6aUuVYSr4Xc90J+tQIqv8PkWpBZiIju8wu2L186lvDukdeSmQSljO
	QgKjjZAg6GV48WO0oSbD6dI+vi0clMzQ7X8mc+2CC/LdAuGSOqXZ6ZwEIxY08=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B9FD6A06;
	Mon, 11 Jul 2011 17:21:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B9086A04; Mon, 11 Jul 2011
 17:21:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8CD2EB4-AC03-11E0-ACAD-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176898>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> structure before before starting its operation, there will be multiple

before before
