From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] '"succeeded" was misspelled in the code, which
 propagated throughout the translations. Fix all of them"
Date: Sat, 10 Mar 2012 14:14:57 -0800
Message-ID: <7vwr6syufy.fsf@alter.siamese.dyndns.org>
References: <CAGOdq5mZdyYcKVaBb1=-8gQAxwwgGNs98HCZb-3JYc=8wHY9qg@mail.gmail.com>
 <CAGOdq5k1uF9oiBbjjdybCpBOQuzRe-hmX-g0Eimzkh+1c4ru2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: patthoyts@users.sourceforge.net,
	Benjamin Kerensa <bkerensa@ubuntu.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 23:15:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6UZ8-0006tN-9Q
	for gcvg-git-2@plane.gmane.org; Sat, 10 Mar 2012 23:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab2CJWPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Mar 2012 17:15:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab2CJWPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2012 17:15:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EC027A3A;
	Sat, 10 Mar 2012 17:14:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=byRxuVtR7tx/uK2xBJwjsK6ltrs=; b=cXhdM5
	bdxEeuiBXXr1HasIJdW4G9qqJHLzEPBwudHrVl9lsWNCUzTHi95UeWXG9EMS5x7i
	WVCw10H9Y4U1vVphaqum+aaEa74t6GOqSUMzN7k3phrpNw4M1ls+z5oDHrhkPCzQ
	ssiRo6MAu1ykkYcKnkSiv/rqlo3EZGSubravs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+fO9PbIDPsqYBP47/rZVA90/3d/qQG3
	2ZCrK7yqcdoLGhBjzWGE7xj3vHJv4Sc80Ta7WZEwyZ0ibGao6BFzGKtdcaTrpBSO
	BhExC09cwA7g3PczdyoP3HxnRKBN5s9nfo0NoK/OLkgMmvlItGjajx2qHzvtejFD
	PA0x5AqT2zo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2447B7A39;
	Sat, 10 Mar 2012 17:14:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A60C37A35; Sat, 10 Mar 2012
 17:14:58 -0500 (EST)
In-Reply-To: <CAGOdq5k1uF9oiBbjjdybCpBOQuzRe-hmX-g0Eimzkh+1c4ru2g@mail.gmail.com>
 (Benjamin Kerensa's message of "Sat, 10 Mar 2012 13:40:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79498354-6AFE-11E1-AA11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192791>

Benjamin Kerensa <bkerensa@ubuntu.com> writes:

> "succeeded" was misspelled in the code, which propagated throughout the
>  translations.
>
> Fixed all of them.
>
> Signed-off-by: Benjamin Kerensa <bkerensa <at> ubuntu.com>
>
> ---

Benjamin, thanks for re-sending the patch to the current subsystem
maintainer.

Pat, when you apply this (I quickly looked at it and the patch
looked sane, but if you eyeball it to double check the sanity of the
patch it would be appreciated), please fix two things in the above:

 - s/Fixed all/Fix all/; we write what we did as if we are giving
   orders to a person who is applying the patch;

 - The mangled e-mail address on the S-o-b: line.

Thanks.
