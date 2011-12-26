From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FETCH_HEAD documentation vs reality
Date: Mon, 26 Dec 2011 00:16:04 -0800
Message-ID: <7vd3bb929n.fsf@alter.siamese.dyndns.org>
References: <20111225173901.GA668@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Dec 26 09:16:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rf5jC-0007OQ-VD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 09:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab1LZIQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 03:16:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab1LZIQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 03:16:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A86C245B7;
	Mon, 26 Dec 2011 03:16:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Up5pDaEBbPvvQpe44wMXo+bH3s=; b=StT9RY
	DgUKfP9y7J9ZqdyjnCpZibpnOktc1jbgqWdakTrt2Iwe4sShfvsg+R84xOL9t7/V
	vhq3kNO4Xo7zggMV40LXIz6UKeQ7GZ9GfVznnYYorLp++YE4uTEygy9iO+/5+iBp
	AUXJPnHr5xp22l2hxEkN9+7pvblLqtL+0CHp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D9m3K37F0vwrrzScT7ieQfFyng9ooz0B
	fq9G3qU5zkFZVoxHoM/vFw4jnj45grIt+ty62PMggwH6Ksl3c4ZyG/mvCO1pJYtf
	QWgpPMVR3crKf7lTnIfAHuAzLP4mS/APUMm6+qL2zuBAlFJFrMMXnWBGYppvrzax
	Jy9QOQTczG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A042945B6;
	Mon, 26 Dec 2011 03:16:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38B6545B5; Mon, 26 Dec 2011
 03:16:06 -0500 (EST)
In-Reply-To: <20111225173901.GA668@gnu.kitenet.net> (Joey Hess's message of
 "Sun, 25 Dec 2011 13:39:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DBD3E320-2F99-11E1-84CA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187694>

Joey Hess <joey@kitenet.net> writes:

> Or yet another way to fix it would be to make git fetch always write the
> intended FETCH_HEAD first into .git/FETCH_HEAD. (When not in --append mode.)
> This seems like perhaps the best fix,...

Sounds good, if you mean "the first one that is marked as for-merge" by
"intended FETCH_HEAD".

Thanks. Please make it so.
