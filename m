From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct spelling of 'REUC' extension
Date: Tue, 02 Feb 2010 10:13:09 -0800
Message-ID: <7vpr4n5wwa.fsf@alter.siamese.dyndns.org>
References: <20100202153328.GB9687@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNFZ-0001vb-EI
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab0BBSNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:13:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab0BBSNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:13:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B61B396F50;
	Tue,  2 Feb 2010 13:13:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=vn99Q0gf+mEF2YpuNU384vUhnI0=; b=qcSWlZA7+5G5jYf5UP3UUjz
	JeifR6SUEaMtrvHmqBaTkWQ/7TfQ6ocQIN+7QeBMVSv+YG9/7TRwQytiOaVG2Ivb
	BIhF5DR+G/SQVTjRk7886RkMTJynpEqjAyAhMEq2RGYXNBZkdhJ+6FO/3ojrWl2V
	iW2xNlahBXkzrMJe8J6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SpDRW68iLxB7OvlRKcYu69PwNiGzsJ0rNWAxAm2rV4CEyLpby
	ZFyXAWWtkZbqxuxj8koH/jMdt2ka6sfdRBogwIDpc+0Rl9MyNC+grHCUlHkQxNYT
	ZzXqTYo8sdO9aP3ZR1TB8SXd/1a35v98eNLUHRbIPMt5+80LZpP1TP1l3A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 909AD96F4F;
	Tue,  2 Feb 2010 13:13:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB2C996F4A; Tue,  2 Feb
 2010 13:13:10 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0B774E4-1026-11DF-88FD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138734>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> The new dircache extension CACHE_EXT_RESOLVE_UNDO, whose value is
> 0x52455543, is actually the ASCII sequence 'REUC', not the ASCII
> sequence 'REUN'.

Thanks; applied.

It was originally meant to be "resolve undo conflicts" but the symbolic
name got too long with the last word.
