From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Sun, 02 Sep 2012 11:44:56 -0700
Message-ID: <7vtxvggnnz.fsf@alter.siamese.dyndns.org>
References: <5040C59A.6090303@gmail.com>
 <7v3933oupe.fsf@alter.siamese.dyndns.org> <5041BED7.201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>
To: Marco Stornelli <marco.stornelli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8H2C-0008NO-7c
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 22:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740Ab2IBUof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 16:44:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598Ab2IBUoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 16:44:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E33868311;
	Sun,  2 Sep 2012 16:44:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=niK0kb+PvBaZlrc8+N8G8z8sND4=; b=LxlFac3OSLwGSdUZy6n2
	vinhpl7+wxeISnWqSUd8VYmRdyuyMevycOSMnxsSAWZLviIpLlxIDiJI6cdni+t4
	NuUgE6sVZqg0L9r72AmYV41mPqYu/LjktSGRYSHgZi1MNFton2SPaBJuSjv/2zAW
	NJYdyr3m1lSYh82LXRw81OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=nZSWs+Ho2r0pqYHgbtuO+qAkpfnvkN5VbrUtPLKtwCopz4
	w80/eeXitptCgMn6akUDovPw0XmjodQXLu1rbZ7axJKM6krPz28TR7MSDK6RxfFu
	I05j3G0oESrAvy9IzZCt1nR5ghZ16aQDCtz8LT2JykMSB3bFFHH/lcXRaGN1o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE66D8310;
	Sun,  2 Sep 2012 16:44:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46DE6830F; Sun,  2 Sep 2012
 16:44:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0033FE88-F53F-11E1-B6FD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204668>

Marco Stornelli <marco.stornelli@gmail.com> writes:

>> I also wonder what would happen if To: and Cc: in the input were
>> split into continuation lines, but that was already present in the
>
> Do you mean To: <mail1>,.....<mailN>\nCc: <mail1>,.....<mailN>?

No, I meant "To: <mail1>,...\n <mailN>\n".

But see my response to J6t's message.
