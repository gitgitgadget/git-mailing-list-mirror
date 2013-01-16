From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] contrib/subtree: Use %B for Split Subject/Body
Date: Wed, 16 Jan 2013 07:43:07 -0800
Message-ID: <7va9s9yvzo.fsf@alter.siamese.dyndns.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
 <1357646997-28675-3-git-send-email-greened@obbligato.org>
 <CAPYzjrQ1ngfOwBuzq+Da1Ynd18Vwt8=LCyu2yhE6dX8vivwReg@mail.gmail.com>
 <7vzk0j9oig.fsf@alter.siamese.dyndns.org>
 <87zk09q0i4.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?=E9=83=91=E6=96=87=E8=BE=89=28Techlive_Zheng=29?= 
	<techlivezheng@gmail.com>, git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Wed Jan 16 16:43:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvV9L-0006Rq-0b
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 16:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab3APPnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 10:43:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728Ab3APPnK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 10:43:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01655B18F;
	Wed, 16 Jan 2013 10:43:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lEkcdlq6kqE64tCIii2c9ow8h20=; b=UEkHqV
	usVmpW3z3/YK0zovLb5h62YnO/z6RNsMsl47OQG5YTCBLY+UaGCUaFRU7DpQwLfu
	A5yMGZYuH+ffnyiZJY2ge2wwYRLZO8OxU+I0PlbzDEhwmi4s63xtpoES0yc+HpzL
	pljxY7rZ5vZIOgt3eSc2eBgwQEr06BlLqm1+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I1cOPBypCTdHukvYKCO2u3l9QnRz3QbI
	QhcRz/ppjd4NXDG3a63NPnJ9aezpRfnJOypnVTNf9kZZjSjvsSpZUBPr8YNfCYfV
	94Ttsr7FyAjkJRbW0FmgkXhLEdUWbu029GkdLiUJlezrzWqVwTCKgFjWynMSktAD
	yakS+uLQhhM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA25CB18B;
	Wed, 16 Jan 2013 10:43:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CA4AB187; Wed, 16 Jan 2013
 10:43:09 -0500 (EST)
In-Reply-To: <87zk09q0i4.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Tue, 15 Jan 2013 21:18:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D921950-5FF3-11E2-B1FE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213760>

greened@obbligato.org writes:

> Are you incorporating the other patches?  Should I drop them
> from my list?

I actually was planning to accept patches to this subdirectory only
through you, hopefully as messages that forward others' changes with
your Acked-by: tagline.  That frees me from having to keeping track
of what goes on there ;-)
