From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: auth plain/login fix
Date: Thu, 29 Sep 2011 11:12:32 -0700
Message-ID: <7vipobtdyn.fsf@alter.siamese.dyndns.org>
References: <1317308474.1854.8.camel@Joe-Laptop>
 <1317315765-5471-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: joe@perches.com, git@vger.kernel.org, peff@peff.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Sep 29 20:12:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9L69-0007Ob-5v
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 20:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab1I2SMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 14:12:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab1I2SMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 14:12:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 147F34DF4;
	Thu, 29 Sep 2011 14:12:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=BBLZyq
	kstEJPTongyT1iVbCD6VkHzUfd4LSJ4VZ8ejOyTgkVj4kBWMqvyacXBkEtI1ef9z
	Uj5zCvxOiX/kxCCmPl8SDx+8R7eLojdu7US4C91MRSETQtdmo12hiWX4xHDWOgKx
	EMndgFPMEXSXB4D0BqFE2g1Hq5dRuR1dBuvNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NW2bwDXlECFyX66Ykb0t+/WIofqsaiBG
	C+n3y+0xxsjQfpT+0KKbEDUmkfMsxeJW2/4P5JD91gfetSIf/F7tyu0s/cMySbB8
	BnhJi5jy5LsJCv/pMd/cF9Wap9RlCJFb8/9BsZInRf7bRQjprBCu+Ltj3kk9lrm5
	83gHn/jBjek=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B5E14DF3;
	Thu, 29 Sep 2011 14:12:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB584DF2; Thu, 29 Sep 2011
 14:12:34 -0400 (EDT)
In-Reply-To: <1317315765-5471-1-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Thu, 29 Sep 2011
 19:02:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AC3BD96-EAC6-11E0-9EF2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182419>

Thanks.
