From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: fix build warnings
Date: Sun, 04 Oct 2009 19:41:47 -0700
Message-ID: <7v7hvak1ec.fsf@alter.siamese.dyndns.org>
References: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com>
 <7v7hvd4flb.fsf@alter.siamese.dyndns.org>
 <d2e97e800910021628t13bba313he119ba59babdecee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 04:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mudey-0001iw-T3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 04:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbZJECmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 22:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbZJECmi
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 22:42:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbZJECmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 22:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A36A24CA94;
	Sun,  4 Oct 2009 22:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xCnA83iDXr2msIlO0sNBPwoXjbM=; b=uc2JRt
	0fClHkWabeRMpx9Htbaut+WUtBIai6T8FzMCbWnur9DkuwuagnCctroDs/hVTl0K
	6XOFZWqQYOC9QsEeP+tfXyUQmUfnJJRc28xFREnNeftFYIIfjDO9A9yNEmNKYH55
	HrDuaDy3RLFBWJZJrRoAZWKFYK1W6Cpt+58xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dzsTZfLBc8AHwaWzPsF/jQ2Pi2b7Wvk+
	DQ1ZpUoCHuRqUOKG8VSLKCLZchqypcEORqMxT+9bUdSvlonEfhmseb3tmMLPdQVN
	dc7ONtCeVWYgc+wqCzrNexPFvw9sIN1/YpZ/ES1autCJWH2R85q6Yc3/l4rQADdQ
	SEwdbG/bqvw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 871AE4CA90;
	Sun,  4 Oct 2009 22:41:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8FCA4CA8F; Sun,  4 Oct
 2009 22:41:48 -0400 (EDT)
In-Reply-To: <d2e97e800910021628t13bba313he119ba59babdecee@mail.gmail.com>
 (Michael Wookey's message of "Sat\, 3 Oct 2009 09\:28\:28 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A374E75C-B158-11DE-85CB-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129526>

Michael Wookey <michaelwookey@gmail.com> writes:

> I can't build with -Werror on Ubuntu 9.04 (gcc 4.3.3) because of the following:
>
>   http://article.gmane.org/gmane.comp.version-control.git/127477

I think that has been fixed already while I was away ;-)
