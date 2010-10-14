From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Wed, 13 Oct 2010 18:55:40 -0700
Message-ID: <7vfww9fsgz.fsf@alter.siamese.dyndns.org>
References: <201010061823.47475.agruen@suse.de>
 <7vk4lv44os.fsf@alter.siamese.dyndns.org> <201010070103.17689.agruen@suse.de>
 <201010111514.29305.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Oct 14 03:55:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6D2z-00077S-2x
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 03:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068Ab0JNBzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 21:55:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab0JNBzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 21:55:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46A0BDE6B2;
	Wed, 13 Oct 2010 21:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Rnfh0PrNobJlU8NyLlo6UWQGnYQ=; b=G66z582B3sZ6d23uZdTrjAb
	ogfGZQpkrOSBvzauD9YP28eC3MTqHhCWY5aNPaH55YOtz6mBHG6D3SSO9eJ0zX+n
	gRzZLrduOT63AKXlYkZbGPDqVCMzFwhxdiyPCvdCXNHdVdt3QMLRVm8g+1PR782o
	izJgqnCnRleTR+X+v8Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HBXzRgUKMSnTnw7EVJ5OjwHV2wov+3VE0YvScvYOBmISIDcjD
	UaWIlXEbp/aDHIHC9FKO8vWPHV0idcMwjhivwXlKu/rWOyUim3hk3R2KtE/342ms
	3rrSwt4aSDC4QNriX/FhaxScPSuVaY670fTMeD3/qnyTzapJ9JvTqWTAhc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18992DE6B1;
	Wed, 13 Oct 2010 21:55:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75750DE6B0; Wed, 13 Oct
 2010 21:55:42 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 286B5398-D736-11DF-A295-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159013>

Andreas Gruenbacher <agruen@suse.de> writes:

> what's the verdict on my second attempt?

Sorry, but I didn't notice the "second attempt" that was buried in a
response message.
