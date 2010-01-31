From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix memory leak in submodule.c
Date: Sun, 31 Jan 2010 11:23:59 -0800
Message-ID: <7vaavudqnk.fsf@alter.siamese.dyndns.org>
References: <4B65B345.1090907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 20:24:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbfPH-0002Gc-NQ
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 20:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab0AaTYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 14:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799Ab0AaTYH
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 14:24:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60539 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab0AaTYG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 14:24:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 949C7953CD;
	Sun, 31 Jan 2010 14:24:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=wulU1m
	aLchvq1tjx9E2fuvURL/Y0ocHL6d5chD3TRvl82hTlZJLVl7fHd/Vyo4uDTD08xd
	dTobkoBnbNlB5AS8kRc0WkJhsFBUyU9+EaqMFO26JcbAzLkXzliJPFmgsv9Byi5M
	8VipyyC4yYVcwl33mJAh6zXW1wC18h68YVkFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hkRsVwwNv+jMpTLtz34LwE+KxGZvYjag
	0iJ8LSjcRPQoPIhOrQc7dmWrx+Gkp0A+qdRUlkPlZDFRuYBaBGcXa+IVlddoF8z1
	r93sq/0oyKzHSGmTPPGKpr0vkWuP7QKqhdQQcHsxPFOaPzP6C65BCH7mE9UOa9Jl
	b28WpEmOiTk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 72F32953CB;
	Sun, 31 Jan 2010 14:24:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD232953CA; Sun, 31 Jan
 2010 14:24:00 -0500 (EST)
In-Reply-To: <4B65B345.1090907@web.de> (Jens Lehmann's message of "Sun\, 31
 Jan 2010 17\:43\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3104C9E6-0E9E-11DF-ACAB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138554>

Thanks.
