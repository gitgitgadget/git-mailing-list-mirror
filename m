From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Makefile fixes
Date: Tue, 05 Jan 2010 17:07:26 -0800
Message-ID: <7vpr5onir5.fsf@alter.siamese.dyndns.org>
References: <20091128112546.GA10059@progeny.tock>
 <20100101090556.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:07:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKNB-00073n-If
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755199Ab0AFBHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191Ab0AFBHi
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:07:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59113 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab0AFBHh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:07:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DF88E26A;
	Tue,  5 Jan 2010 20:07:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NZCeu8G+abKcPo2xxbK+ZLEI8lc=; b=tHovYlCMeWhO49H7dF4N/Bm
	7X0P18DcR+AajKydDSYXGfd3wnrBKVoYrchwj8KiE8z34y9GMHpt0p4iy2Uo3zBT
	+ABdmqUzM+N4XgljM5doaWMcNKLGX/pa1PuTpCExswPxMo8/3RuQgYSpFLALNzrQ
	z0/Bq1J94ialbj8O5rcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=T+B3PowBHex/ueylLTxMzlWpbBVnF4E8+DrBtxAHskE87L/kF
	gARDAJeIOOM++19SU6X661+xQav5/t7dCK+8+Gfz53R/tpjYm3wIle6r+a9qDNSR
	srCD+sWrJqP23zRlfuR+i1qwTDyhCCOLGAMso+NuCgpreZoBNoay13UruY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4D88E269;
	Tue,  5 Jan 2010 20:07:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 232DD8E268; Tue,  5 Jan
 2010 20:07:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0E8058-FA5F-11DE-976F-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136231>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?
>
> Makefile improvements.  No discussion.

I took 4/4, and after looking at them again, I think 2/4 looks sensible,
too.

I was puzzled by 3/4 and I still am; the dependency rules are the same for
%.o and %.s yet the patch changes only %.s.  Either it leaves the same
breakage for %.o (which is much more important in practice), or the
problem Jonathan has with %.s may have other causes, but it was unclear to
me.
