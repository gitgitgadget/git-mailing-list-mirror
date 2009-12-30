From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 1/2] Smart-http tests: Break test t5560-http-backend
 into pieces
Date: Wed, 30 Dec 2009 09:54:47 -0800
Message-ID: <7veimc2vq0.fsf@alter.siamese.dyndns.org>
References: <1262037899-16786-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 18:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQ2lG-0008Pt-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 18:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZL3RzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 12:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbZL3Ry7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 12:54:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZL3Ry7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 12:54:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4453FAB62C;
	Wed, 30 Dec 2009 12:54:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1kpqr5+89+zMV3ziNXsArtAsDv0=; b=JrKTNt3167VMmpMxlTxFvwd
	gJ0LN/rcdh+GWxiD17Kj0isp7S/JBITMkcL49/cZEZat1JZnM4ZuPXKRQqhrdUQc
	mF909Sq8mnyMbphpd1B6+mej6a8uv1ab7dMcsjEWMbKC0WeBsrWxGQ9cgZxhUFs4
	PjXsVihV7t2VQeL3Mbws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=mEAwy3Bq4c3YL6+EmyYUt2BJITQL5YBSosFD6vGQ38yJJ/+fX
	w5DKwHeL0y2RHCJ8z7YKQ9YYVF/lr/c/AZibiB+gtsLIPhbMnk5VZwXUQO91y/9V
	qemwDqBMK19rffH6p0lixE+90lTAX37hWaZ63ZmQwLDXSt84/wAIJnH9QE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DC3FAB624;
	Wed, 30 Dec 2009 12:54:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E72DDAB623; Wed, 30 Dec 2009
 12:54:49 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6F4B4B62-F56C-11DE-B00E-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135909>

Tarmigan Casebolt <tarmigan+git@gmail.com> writes:

> This should introduce no functional change in the tests or the amount
> of test coverage.
>
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>

This seems to crash rather badly with your own "Smart-http: check if
repository is OK to export before serving it".
