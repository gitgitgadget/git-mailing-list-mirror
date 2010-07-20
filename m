From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/{t5541,lib-httpd}: replace problematic '!()' notation
 with test_must_fail
Date: Tue, 20 Jul 2010 11:38:16 -0700
Message-ID: <7vwrsqknhj.fsf@alter.siamese.dyndns.org>
References: <a6Z8194aVj9d_uiPj0QZaVCfPhZWVDzj2NuBws8RYnYVr4pe9tF4BSy7a4J8g7UAxPIvHfvIwT8@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rctay89@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:38:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHi6-0007Fh-2W
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761429Ab0GTSi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:38:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761243Ab0GTSi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:38:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC4D7C6347;
	Tue, 20 Jul 2010 14:38:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yMJX0qmL49yIT8sBDXuZ5ViO23c=; b=BUWyl7
	S+YhPzSnXTwIkceI5nTxnb1989QK7TqkZZyYoaJpF3GIlFxXEqyPq/ovfI84BCbR
	z74aZkcFeF+vn7y1YDZqevVDzth/bTHafFjctLVJWVxhVN0f1dCuQ8ElKEseloDj
	i9ezN4+2KlwoZdBgOVJ9FmoKDSEKtBvvfdb34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XDCO8qHe9A0ysuI1A/WtRpkuvMB1PVFi
	mOklArFyAftWbdw6TScroEHfRbXbNXDNwlhaQ8PK8rDWclH/8Q8JbcRkuKzsSGIn
	+GOQdHIDw7uPzk/G1BW/QsJ7AOkn94omhbhQTnQw6N/aTtrxmJQBB0F5+Soi/CGO
	C6urc68cmnI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F2CEC6344;
	Tue, 20 Jul 2010 14:38:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B5DDC633E; Tue, 20 Jul
 2010 14:38:17 -0400 (EDT)
In-Reply-To: <a6Z8194aVj9d_uiPj0QZaVCfPhZWVDzj2NuBws8RYnYVr4pe9tF4BSy7a4J8g7UAxPIvHfvIwT8@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 20 Jul 2010 13\:27\:55 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9774F74-942D-11DF-82D6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151347>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> The '!()' notation is interpreted as a pattern-list on Ksh.

Thanks.
