From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff/status: print submodule path when looking for
 changes fails
Date: Thu, 08 Dec 2011 11:15:39 -0800
Message-ID: <7vobvhebno.fsf@alter.siamese.dyndns.org>
References: <201112061930.pB6JUuDx004171@no.baka.org>
 <4EDFDF96.9030601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:24:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6zj-0001CZ-5o
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab1LIUYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:24:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44627 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab1LIUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:24:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FA266654;
	Fri,  9 Dec 2011 15:24:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FOvtcCxiMwhb8dMW53wh
	TrT77l3ISbzjhAgs65Dp9Zahs5m5O5EGg6AxL6/kFEo4s1JajpYkpK4BVVZMT0ch
	8Q+uSzveyEh6TwSoNyjRzYNt0Y4VuqH92LU+6np5XLU11IiuKcQ62jmOc6fn5ZB5
	3MqHwuQcUvwIwWOtTRE9Zo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=OABlaW6Fu1YR7H/76KuwIzSx5uficZyPsyaTLIkdqwUS9Q
	b9HRSYRAGcUfGyYs9U8qaFnZ0feEHDSd7fHj1ftAPxNv7GyLsXvaijNTI+V0MybR
	i135K2e3yf4Tq+3AklOamXUHskMEav08/fAfAGzxAJBo+VFn9YgI6i+c09B68=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3795D6653;
	Fri,  9 Dec 2011 15:24:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD37F6652; Fri,  9 Dec 2011
 15:24:28 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB8D15CA-22A3-11E1-9398-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186682>

Thanks.
