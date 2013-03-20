From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: don't redefine test_config() in various places
Date: Wed, 20 Mar 2013 11:51:22 -0700
Message-ID: <7vsj3pewgl.fsf@alter.siamese.dyndns.org>
References: <7vk3p3jrrw.fsf@alter.siamese.dyndns.org>
 <1363767703-12936-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:51:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIO76-00086J-QT
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab3CTSvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:51:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755643Ab3CTSvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:51:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21F43A5C6;
	Wed, 20 Mar 2013 14:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YP6gjAO4xJGb+hK2Sgtqf++fG6E=; b=pnYtjO
	hMIFs4iwNbV/8H+Of5WPq2GuTADBDm9noNbJsfdxTLUHJkB7+SrC8eUPR1gFar4g
	H7OrlIWCH2gP4GugkMtfujvDSaSpbPViJHiNjw/sfYv2XNMu710bAfkd7vaaVP6V
	uU072z6DLyc+rO6a+/iK7/zJuH8cPrLUoHLpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DANjWAydJvHmuD0JfKNOgbbeuGDN5/zI
	Xl11GNPcj+2htNncjU61fp1rw2WHPy7WpNxxq0SHlv1AtrN201Z9mIBYjpdfyC64
	VjMiF7WroliqBj7xEvgd+9jvHn7/B7ib6O6pfsYFPiY/QIbhiXdbb/QGX1Epm8Rb
	I4g6f9PD/io=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 15EE0A5C5;
	Wed, 20 Mar 2013 14:51:24 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80617A5C3; Wed, 20 Mar 2013
 14:51:23 -0400 (EDT)
In-Reply-To: <1363767703-12936-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 20 Mar 2013 13:51:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29648772-918F-11E2-8524-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218652>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> test_config() is already a well-defined function in
> test-lib-functions.sh.  Don't duplicate it unnecessarily in:
>
>   t4018-diff-funcname.sh
>   t7810-grep.sh
>   t7811-grep-open.sh
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Thanks, Junio.

Heh, I've pushed out the original one after fixing them up myself
last night.
