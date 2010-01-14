From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Gitweb caching v4
Date: Thu, 14 Jan 2010 00:40:44 -0800
Message-ID: <7vmy0hhyer.fsf@alter.siamese.dyndns.org>
References: <1263375282-15508-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 09:41:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVLGD-0006zA-Ib
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 09:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756512Ab0ANIkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 03:40:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528Ab0ANIkw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 03:40:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44854 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab0ANIkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 03:40:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B94B90AE8;
	Thu, 14 Jan 2010 03:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=o6RTIIGTLbiC3ob+hBcXF9hc8us=; b=rr3qmP+IXQ2RI/l+6mtEZ7V
	HJxMRHPhydPBvnLj52ORLIdda9+u+IrJxLmwyBzZzxY3la4ekjuF0U374Qgrdchi
	IMxn5fRfhtz+GM1FenPkDSsRzSuSEhnohMQd+nY4CJP+OrU5hZcuz1RiQXdExTvp
	IqlNG0YLpRANkvMtPnoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=I1axczGjCPxktP3rOGCiuqad1bjU+yzj4+uPUsUk5gCDlaaPY
	begRDx3/ra+cBXtUXIND0Kc5FPnz/mO5pf4lxAM75QX+Gp/1Bo5eBIT1NSQk0bKy
	Dh78ZYWrtJ7PHAMS1D32WRxKNgKh9l4z2Wm+BbiLxZVHHWsfUKoG2ksSwM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE8FC90AE7;
	Thu, 14 Jan 2010 03:40:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59CB290AE6; Thu, 14 Jan
 2010 03:40:45 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83494894-00E8-11DF-A956-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136966>

Will replace what was queued on 'pu'.

For [3/7], I had to resolve conflicts in Makefile as it seemt to have been
based on a bit older one.  When I push the result out, please verify.

The result merged to 'pu' seems to break t9500 but I didn't look very
carefully.
