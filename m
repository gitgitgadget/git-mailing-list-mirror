From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 14:31:46 -0700
Message-ID: <7v1ujacwcd.fsf@alter.siamese.dyndns.org>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
 <50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
 <7vhas7fefs.fsf@alter.siamese.dyndns.org>
 <CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com>
 <7vzk5yen99.fsf@alter.siamese.dyndns.org>
 <CAOeW2eF67Tj0Mq+g+-3UFyh_Xvt=ZcKDc9LjCKGwu9y2G39NBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:32:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T12FE-0007op-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 23:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761Ab2HMVcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 17:32:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301Ab2HMVbu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 17:31:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E95308FA2;
	Mon, 13 Aug 2012 17:31:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7VHHlKN9so+tFYGmtX33/gT84UQ=; b=lZL9po
	Q9TCSqeu+80e/TsLGQyC4g62UBDwxTMy+q0Hnbg3A1RjJBKEiLUzJHYK1Q6F/ekD
	0kpeLKlsem+UEiuzhCb63iAmYGc7SLu7kFtSyOZO9mWmQHJnYm5+RVqCcpGM0F1X
	tu1wEdbCAoU31FBIPeJea6fI/TWNDS49PdmAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w5uK4w1cKbUKCMhrL5nPTAeRgIB41FHL
	FcaTROF/b8VDwYF84UnnVlPamMP9VHlMYTwVo2SW54Nib1MQjSe+9zrXpGU90NIA
	sVLCdVmt5IYvr/RCccNjVkw1BTlfvKGaDmJS45aBB5iSehAlkGTFjT1B6wBT5YLD
	IXHwc69mhUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D73898FA1;
	Mon, 13 Aug 2012 17:31:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60B3D8FA0; Mon, 13 Aug 2012
 17:31:48 -0400 (EDT)
In-Reply-To: <CAOeW2eF67Tj0Mq+g+-3UFyh_Xvt=ZcKDc9LjCKGwu9y2G39NBQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 11:28:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49CBE698-E58E-11E1-8361-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203369>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Makes sense. The shortlog example is a good example of sorting that
> completely reorders the commit graph sometimes even making sense for
> ranges. Thanks!

By the way, does this topic relate to the long stalled "rebase"
topic from you, and if so how?
