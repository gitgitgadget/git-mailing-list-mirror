From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured
 mergetool option
Date: Tue, 16 Aug 2011 10:43:16 -0700
Message-ID: <7v8vqti763.fsf@alter.siamese.dyndns.org>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
 <7vaaxrn10o.fsf@alter.siamese.dyndns.org> <20110816100949.GA10859@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 19:43:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtNff-0002wx-R3
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1HPRnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 13:43:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55322 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab1HPRnS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 13:43:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FF8E4802;
	Tue, 16 Aug 2011 13:43:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n02UGUe90kZwtHeYcLmg8ZNepGA=; b=BDOk7B
	+reUpsVucIkLCeoDxRhhHDkcpbuk7dNanhOaIcOYUHXeSjHlezF3OZ/j1bh/FxQT
	LgBVZtE79Ul1H5Yh1j6qYJNTGss8E/3UgjXByT4fs4XBNpCjjihU6LSIfOGtNS2x
	D5kplZD10sSGTd1UR1PJuF0W8R9KoR+kpptcY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l5Ewss8+JLZclxBE9DcF8u0ewSZOzoqB
	AxCQRfYli1Il/RMuNfVTRA3P6uLVBfNaRfqI9g9+58+1Em19SF4ShyXbjYmIKBR/
	L34ha0+/urMIYc43Dx/h33h9Newmf9mMDpbWp7G56lhZLsBtA3PwwNHkgQ2e0MHr
	DBJJVkM1nU8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D634801;
	Tue, 16 Aug 2011 13:43:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FC8B4800; Tue, 16 Aug 2011
 13:43:17 -0400 (EDT)
In-Reply-To: <20110816100949.GA10859@gmail.com> (David Aguilar's message of
 "Tue, 16 Aug 2011 03:09:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3991FB5A-C82F-11E0-8229-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179462>

David Aguilar <davvid@gmail.com> writes:

> Is it okay if we install the files into
> $(git --exec-path)/mergetools/ instead?

Surely, and thanks.

It is much better than "$(git --exec-path)/mergetools--$backend" ;-).
