From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 00:03:10 -0800
Message-ID: <7v8wbeg0qp.fsf@alter.siamese.dyndns.org>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
 <20100131073208.GA15268@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 31 09:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbUpA-0007rc-F5
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 09:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390Ab0AaIDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 03:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858Ab0AaIDT
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 03:03:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0AaIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 03:03:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AE76C94DDE;
	Sun, 31 Jan 2010 03:03:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G1/qBtEtbeBAGJzoiG3p2amZSzE=; b=QaYSYd
	xR2eRHfnKUkM6ciFJ6QHvg+Rt+eI6cVbCCiYu/NseEGjLCTyfDmje1DE26g0HuF0
	vgLv8/8wviShTsaK2nIaXr+LQv19hOLkw0SHYAk+Eq835OQDVj49wEJMaRm9hWah
	2vN7QYUDjCE1XKSr+BPlIRAMuDw8zLdN4G3eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jX0RMZjVaGbv9M6STmr2bG+kgzK79DeW
	O+UA1uh9M1SSCPE9i3JS8v7za/mFbx4tdcvMvTSj+Y+DsI57cYlsqJWm4Kcp9IhV
	h8vDkadkTNyv+/CSfrPHgWiIHkVe5p+yR673kXY2Lk1miwtdnzjWrRkNzoiTaAkP
	oVeq7CqSQrA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8669294DDB;
	Sun, 31 Jan 2010 03:03:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7C4094DD8; Sun, 31 Jan
 2010 03:03:11 -0500 (EST)
In-Reply-To: <20100131073208.GA15268@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 31 Jan 2010 02\:32\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 152511C2-0E3F-11DF-8524-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138533>

Jeff King <peff@peff.net> writes:

> On Sat, Jan 30, 2010 at 02:53:34PM -0800, Junio C Hamano wrote:
>
>>  * Various commands given by the end user (e.g. diff.type.textconv,
>>    and GIT_EDITOR) can be specified with command line arguments.  E.g. it
>>    is now possible to say "[diff "utf8doc"] textconv = nkf -w".
>
> Does this deserve a mention in the "behavior changes" section, too, as
> it may be breaking certain configs (most likely those with full paths to
> filters which have spaces in them)?

Perhaps.  A patch with nice description, please?
