From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Tue, 17 Nov 2015 22:52:28 -0800
Message-ID: <xmqqa8qbol3n.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de>
	<xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com>
	<20151027012336.GK31271@freya.jamessan.com>
	<xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info>
	<87si4e6c49.fsf@red.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 07:52:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zywbi-00051k-5t
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 07:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbbKRGwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 01:52:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751837AbbKRGwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2015 01:52:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CABE2322F;
	Wed, 18 Nov 2015 01:52:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=brgXGf8Mb63mdVJXJ4twzfXVhig=; b=K05bm1
	8o5lM9AH3OLwJMK3G91ZgOMA4zoGlnHAgDuFynu08xkBdCa2denO+pk24Sb5REzR
	zFs62Dvzqc7wbICLrz3dq0Xlazo1gtr4ovXTvbr0B76A7aUVm0hC9iIwz+A6ssUY
	tf32WgHCzacu+OysqhALsMYtpkFJHTGYS4zLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S0mJ6uuyCDvFnmnoun3fIF6oEciMtuVd
	vrocgKQnBYwLUwcVKD+QxJheDoWagc7byMVM9FJdHMeg+10vDKsNxbGJnlC8PTdS
	aRAtycXdyHkFLoPjyB5tkPDGZnrQliXn1rGrt+/nZgoV2yj1J0NgVMW+JkpB+CBP
	IxT+yjg9t1k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 642C72322E;
	Wed, 18 Nov 2015 01:52:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DDE9B2322D;
	Wed, 18 Nov 2015 01:52:29 -0500 (EST)
In-Reply-To: <87si4e6c49.fsf@red.patthoyts.tk> (Pat Thoyts's message of "Mon,
	09 Nov 2015 22:28:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFB078CA-8DC0-11E5-8C98-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281442>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> A bit late to the party but 'yes'. Frankly by posting something to SO I
> rather consider it public domain ...

Unless otherwise noted, material posted on stackoverflow by default
becomes CC-SA-BY (which may not be the best choice for open source
software).

Thanks for the patch.
