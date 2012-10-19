From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Fri, 19 Oct 2012 15:24:47 -0700
Message-ID: <7va9vihzgw.fsf@alter.siamese.dyndns.org>
References: <7vtxu4io7o.fsf@alter.siamese.dyndns.org>
 <1349927643-7195-1-git-send-email-andrew.kw.w@gmail.com>
 <CAGAhT3nNdPxtDKtVCnPAa4OWOhGygzoq6DqHVEckQ60XWAAKZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Alexander Kostikov <alex.kostikov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 00:25:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPL03-0000Y3-7c
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 00:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab2JSWYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 18:24:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753166Ab2JSWYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 18:24:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D48268A4B;
	Fri, 19 Oct 2012 18:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEQ9K63T9v2R1umLlOlFcop4OBY=; b=eYtNYa
	EvzevKitesbsgBHRxOCgs3rK79ysDqvxC90bHaKGBmgkX0L+YkEGwW1QVfsMV1t6
	UAZISsC58cM+tTrFcatxNbHunbo/7inDFOb4mOGG9RFIIcc4VAy77MdJFH6e0hpl
	2wO4J5ASwseKdHWfSm+hBmijQ59sEGgxU7kLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aLfk9cjnSdjx2Cm3i3Vhg/AnhOF1/Vdi
	c94a+fGBvm14TlStXDulY94oZEv9I+AjAd9oKnehRzBEgDqBGrXNtyq7NJVnrfKC
	eXXo6g+ng8uO6EgxL9zc3DPY6wbsHlJz7FxXlTGItkz6L43EsbJN0t6J17Az4ak+
	X0n1fxjNIQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C15398A48;
	Fri, 19 Oct 2012 18:24:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469F18A45; Fri, 19 Oct 2012
 18:24:49 -0400 (EDT)
In-Reply-To: <CAGAhT3nNdPxtDKtVCnPAa4OWOhGygzoq6DqHVEckQ60XWAAKZA@mail.gmail.com>
 (Alexander Kostikov's message of "Fri, 19 Oct 2012 14:49:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB6EF2A8-1A3B-11E2-83E7-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208074>

Alexander Kostikov <alex.kostikov@gmail.com> writes:

> Sorry to bother but I was wondering what would be the release version
> that would have this patch.

That depends on how well the people who are interested in this
change test it to smoke out potential issues (if any) in it.

It currently is on the 'pu' branch.
