From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4055 failure: see error
Date: Tue, 02 Oct 2012 11:45:34 -0700
Message-ID: <7v7gr890hd.fsf@alter.siamese.dyndns.org>
References: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
X-From: git-owner@vger.kernel.org Tue Oct 02 20:46:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7TY-00053g-3I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 20:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab2JBSpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 14:45:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab2JBSph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 14:45:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E75CB9A85;
	Tue,  2 Oct 2012 14:45:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IgdwI83Tq56h5mOz2yRAF77kThU=; b=lvOH3n
	hMqsSWIPDLDzbQlPqaULFGaUpkbPldtcv7iw0sPEN5Avr/5voKp8h8mfBiqLjZlW
	hYZraGK3dLoXq0CbHH/czMKPx5tFBT29kxAizU95bqQ5LAzIdhjAxXPDdQrV0GWH
	yn22zKSajZ6tzvyYjTfXVWCbyEEfAll7DS/Ss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM09cMb3FD7OJWNBBPgiGKDn/2Zju4Bz
	RXD4mW7AVQKyx1ygLMa6Z36YAUwMwAXXKD6RYCN/v7YxDSEZsBBS4OJPZDDV5Hzv
	XmdgPXeUH7xL7X2rfUjNLM4OQ1XFcytusESkExysCg4nKh4SqqSDs9TNPNRDKinN
	FO7D+cd3nKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4B379A84;
	Tue,  2 Oct 2012 14:45:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4570B9A82; Tue,  2 Oct 2012
 14:45:36 -0400 (EDT)
In-Reply-To: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu> (Brian
 Charles Gernhardt's message of "Tue, 2 Oct 2012 08:18:22 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A9BD514-0CC1-11E2-9208-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206831>

Brian Charles Gernhardt <gernhard@cs.rochester.edu> writes:

> Another problem caused by BSD v GNU sed, I think.

Oh, that again X-<.

Will patch up in a stupid-but-trivial way, unless somebody knows a
reliable workaround.

Thanks.
