From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: shorten glob error message
Date: Wed, 27 Jan 2016 12:26:36 -0800
Message-ID: <xmqqr3h27oqr.fsf@gitster.mtv.corp.google.com>
References: <1452522358-16943-1-git-send-email-vleschuk@accesssoftek.com>
	<20160113031601.GA28224@dcvr.yhbt.net>
	<20160114040759.GA7671@dcvr.yhbt.net>
	<xmqqvb6wjacq.fsf@gitster.mtv.corp.google.com>
	<20160127025408.GA17600@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com,
	Victor Leschuk <vleschuk@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 21:26:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOWfz-0006md-Kl
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965594AbcA0U0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 15:26:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965535AbcA0U0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 15:26:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AE433E18C;
	Wed, 27 Jan 2016 15:26:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/HeerT8rZXabERWyvE39Ys56C0g=; b=lMV1CO
	eYIgo4tROdkvF+Bcz9AdRJRxvPPzClbtZSn4XhCKYwNdgjawXWENzY02U/FPhPDd
	5J3VfFpBor8HOAVOv4TMtdqIoPPVX4KP2x+xk+Plz9YqxrXh2mTuhQIopTbNgpBz
	XtsbluXe0Y8qkt0UxNHcBdRmT8XnTSIDav8W0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T5vtg6y6JMZYLL/WmDhoaPiCmbaHDQfc
	EkRmOIOo13sOD58K+3Ld6bdakxr/YuCKkLTAjpw1A8YGqCWhf6AtusNl8nLhmOoG
	iiroJt+DAJJFnVCUbg2LDh5mJPsjHWIybrwzAINqHetSIlfqgEmLDhtOZSf8QIh1
	EpVh9IFVQzE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42D713E18A;
	Wed, 27 Jan 2016 15:26:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8940A3E187;
	Wed, 27 Jan 2016 15:26:37 -0500 (EST)
In-Reply-To: <20160127025408.GA17600@dcvr.yhbt.net> (Eric Wong's message of
	"Wed, 27 Jan 2016 02:54:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44138D9E-C534-11E5-95A1-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> I am not sure if it is a good idea to show */*/* as an example in
>> the message (that is an anti-example of 'one set of wildcard' by
>> having three stars, isn't it?), but that is not a new issue this
>> change introduces.
>
> Actually, going back to commit 570d35c26dfbc40757da6032cdc96afb58cc0037
> ("git-svn: Allow deep branch names by supporting multi-globs"),
> having equal '*' on both sides is all that is required.
>
> Not sure how to improve the wording, though...

I dunno, either, and that is why "not a new issue", iow, the patch
is good as-is.  The wording might be an area with possible future
improvement, but that does not have to block the improvement the
patch under discussion brings us.

Thanks.
