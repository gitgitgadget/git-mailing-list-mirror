From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure $PERL_PATH is defined when the test suite is
 run.
Date: Tue, 17 Nov 2009 10:25:01 -0800
Message-ID: <7v6399f1qa.fsf@alter.siamese.dyndns.org>
References: <7v1vjym2oq.fsf@alter.siamese.dyndns.org>
 <1258417206-5406-1-git-send-email-book@cpan.org>
 <4B025F19.1050809@viscovery.net> <20091117083557.GC3608@plop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Philippe Bruhat \(BooK\)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 19:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NASjw-0005iU-1p
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 19:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbZKQSZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 13:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbZKQSZG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 13:25:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbZKQSZF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 13:25:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 281D88089D;
	Tue, 17 Nov 2009 13:25:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZE75Nx+I89sqvfd4iZNYV0/D/A0=; b=KYBGe1O57RaGIvHAZKussCM
	vrgZwTVbYsdrMkeh3379xe2Z7k2FS6EtMP++LBhNGIUdsu9AF5QKLRxsX8GxlV4x
	X6UEH89ZrnF86X7g97OCuRqpiatwke2b5vh9Rw10hfOjwyib/GfJvgpHLub5RBx3
	mRJLM94RXeUOoF8qsA40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KvlpxDcOUbzd6k/EAM6o5Jq8Fh2x83YYkRvCgZClKk8ZN5WsA
	u6lXovYmxOrSwdc6ucSqVOaLOSJCK1D3xy8CscVI9Lqfe0xLvxqk08gNW9nTPAvR
	3FRWpgV2tyb4b0l9RthE8W7Ue7J4/soNzDMuS/cpUUdagQSzfWR0Gib4ko=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D3280899;
	Tue, 17 Nov 2009 13:25:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 098B480897; Tue, 17 Nov
 2009 13:25:02 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 881BADC2-D3A6-11DE-83FA-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133096>

"Philippe Bruhat (BooK)" <book@cpan.org> writes:

>> Make it: ... >>$@
>
> This proves late commits needs many extra pair of eyes. :-)
> ...
>> This one needs the double-quotes as well.
>
> Thanks. Sending again. (sorry for the noise)

Thanks, I also missed them. Will re-queue.
