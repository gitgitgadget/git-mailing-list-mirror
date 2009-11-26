From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] status -s: obey color.status
Date: Thu, 26 Nov 2009 11:00:56 -0800
Message-ID: <7vy6lt6rh3.fsf@alter.siamese.dyndns.org>
References: <cover.1259248243.git.git@drmicha.warpmail.net>
 <26d0a2022638ad7b75268ca291b8d02a22f1f66c.1259248243.git.git@drmicha.warpmail.net> <4B0EA06A.1050101@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 20:01:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDjac-00033M-SZ
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 20:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZKZTBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 14:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbZKZTBC
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 14:01:02 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZKZTBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 14:01:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4337A1861;
	Thu, 26 Nov 2009 14:01:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/uAcVh2lSogUCiCNo8LWX4kLJMM=; b=mW0TMd
	7mM87BLz2iv+rhBPnN1QvZo4ARqctNEMrM1eA1G7RnSGkJ3FiYI/lOmfiz6YD0IZ
	e0qjHG/XLEI5MRHEbSy5OWDNsnrdFQZDdkcE538Zc3Clw6507+3fH2xNUHM2dEzO
	+xHW2I2wWnqJBIFqTlPb094LoEszjgFewP8mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kW34aLB3Hx//UjBe3fOhYyYZthfDc8NP
	YrrzYUoQ+hHJaX/lEIz+B9ac/6YGD7z82dfDRu81FgfRZ/LUggADrl9MbwM2VigZ
	Wnv62ngcddOtlOCCVCrXZxCXYsfGjRZ/+hPSBDpKIPbbNCz2G7BfT4zdrcNal910
	QG7zshTqx/8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75D69A185F;
	Thu, 26 Nov 2009 14:01:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED2BEA185D; Thu, 26 Nov 2009
 14:00:57 -0500 (EST)
In-Reply-To: <4B0EA06A.1050101@viscovery.net> (Johannes Sixt's message of
 "Thu\, 26 Nov 2009 16\:36\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0B356978-DABE-11DE-8A37-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133820>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Michael J Gruber schrieb:
>> * Is there any policy regarding use of putchar/puts vs. printf?
>
> If the printed string contains color escapes that should be obeyed, you
> can use only fputs, printf, and fprintf. You should not use puts or putchar.

This msysgit-imposed restriction is something even I do not remember
offhand.  Could you please document it somewhere in a file any developer
would get by checking out the 'master' branch of git.git?
