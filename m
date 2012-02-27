From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] contrib: added git-diffall
Date: Mon, 27 Feb 2012 10:17:17 -0800
Message-ID: <7vipis9m4y.fsf@alter.siamese.dyndns.org>
References: <1330112937-7134-1-git-send-email-tim.henigan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com, stefano.lattarini@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:17:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S258X-0003a5-Ez
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296Ab2B0SRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 13:17:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006Ab2B0SRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 13:17:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB5777DA;
	Mon, 27 Feb 2012 13:17:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8ZvXuD7SPRtGWZho4MCD5/Fk9Jc=; b=GuKOMa
	fRw5FgXWTmxPFQZrGxT49DehsribQkSFbRC7lfwahtaHC5hHkhSBo4+rPLC/L4Sp
	2k5aqp7YOtdGu3PEI4Epc1kZ0dm8PdYWsKfiHO9SKeqLLFm56VU1NMg75+w5mFGb
	+VdVvczRF9ue7O36YKviE4vAoLp5Jbv7UjV7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d03OTozSYLqhA8IKTog9ZbMQtH1P+GtV
	z9fv9LUWgIu7dtRv4XqOo+a0HpfUxf6V2C4PP586OPDYSWqgeNIUjjPor0AhWFDp
	jitleJmT39EfkCCkEjIEU81pYJA8i+8Kb9XVE3LzD3/4JSDpY/sURY+PmPl2mfvF
	VrQ7+YkTJQ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3ADD77D8;
	Mon, 27 Feb 2012 13:17:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53AA177D7; Mon, 27 Feb 2012
 13:17:19 -0500 (EST)
In-Reply-To: <1330112937-7134-1-git-send-email-tim.henigan@gmail.com> (Tim
 Henigan's message of "Fri, 24 Feb 2012 14:48:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 491A161E-616F-11E1-A39A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191642>

Tim Henigan <tim.henigan@gmail.com> writes:

> +	-x|--e|--ex|--ext|--extc|--extcm|--extcmd)
> +		if test $# == 1

That is not POSIX.

	if test $# = 1

No need to resend; I'll fix it up locally.
