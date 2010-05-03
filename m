From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
 non-copies
Date: Mon, 03 May 2010 09:29:24 -0700
Message-ID: <7v1vdtt0d7.fsf@alter.siamese.dyndns.org>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
 <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 03 18:29:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8yWc-0007Eg-RA
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 18:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933215Ab0ECQ3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 12:29:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933091Ab0ECQ3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 12:29:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC8B0B059B;
	Mon,  3 May 2010 12:29:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B1VuZDOQBWDinvRWocT0MwKLmg0=; b=PWNBJZ
	WN+aeBUaRwyRuG96+rJvgyMzjjQkIuYa6XZt/E8ylwstpYzcRN81CvwWqhfl7eGF
	x1Ikl6ocjEwJoTtoyOFEtq6uoVmYuGDFndIKBv7CuVQW3kdqsg8Zxo5oEmWhMbcQ
	LgsIeBrWhc/B07y9e2GB9oj/UBKuOGF29YTXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AqpdjBLNrB4g+EAfCCldjO60FtsIl1mq
	4v5eF6xvrHkL2KXUgXRzGcfbC62jd6oDSZ2ekGdUV5CN8waM69YxHWja8FiWYsRd
	M+okdFqY+cIbQdrHNmgUVpQNiHE3vrFXicwY5UPO4jMxTMIIObySZ3lKlEpvrv+O
	An5xJIyAg+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B76EAB0599;
	Mon,  3 May 2010 12:29:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 146BDB0592; Mon,  3 May
 2010 12:29:25 -0400 (EDT)
In-Reply-To: <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
 (Bert Wesarg's message of "Mon\, 3 May 2010 09\:37\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C32F892-56D1-11DF-B84D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146242>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> As far as I understand git_diff_ui_config() applies only for "git
> diff" not for any of the plumping "git diff-*" tools.

Ah, I missed that the patch was to the diff_ui parser.  Sorry for
confusion and thanks for straightening me up.
