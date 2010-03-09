From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist: git send-email improvement
Date: Tue, 09 Mar 2010 09:30:48 -0800
Message-ID: <7veijtz9kn.fsf@alter.siamese.dyndns.org>
References: <1268155306.4277.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Tue Mar 09 18:31:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np3Gs-0003Pw-4l
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029Ab0CIRa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 12:30:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab0CIRa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 12:30:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 494DEA0E42;
	Tue,  9 Mar 2010 12:30:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+DYXi38Lqu3Tcd13IpYrJf0iCsE=; b=iYWixW
	2MPTsRKu+Z0sfQ8MW7+2ejF6yYD0RESHVlilry8VpAE9hJVno2zmxA9TgIOHrYPG
	rZ/EgPOG7mVel8jthLcXgP1wwiIFmtx6lZcekjlCgWvbWSvDzdii4mtW3zJL25XC
	2xGqzc1Je2ANrlnh8hv4KPPHaJJ4MkkANQtyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xPZyZgFtVz0TvaRoW2zCNBBxKwY2MLxk
	3H0s+k8Ry+aH7e+/YVNmA9Wg13lZuyx7801HkvP7WXysFXRvWzbMmbt/ivKHFQY8
	wmhogiSaJv500dkF7Uj09bQ4z2XB0pftvtUj5O1dU9USSep4QiUY6cUkpvj7/kB6
	fvEGHcfwl+A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 273CEA0E41;
	Tue,  9 Mar 2010 12:30:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 443CCA0E17; Tue,  9 Mar
 2010 12:30:50 -0500 (EST)
In-Reply-To: <1268155306.4277.14.camel@localhost> (Yann Droneaud's message of
 "Tue\, 09 Mar 2010 18\:21\:46 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 82F654C0-2BA1-11DF-8A27-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141836>

Yann Droneaud <yann@droneaud.fr> writes:

> Here's a little wishlist for send-email
>
> - Use From: field extracted from patch:
>   If there's no configuration for user.email and From: field is 
>   different than default auto generated From: address, 
>   git send-email should use the one in the patch as default.

I cannot judge how sensible this change is; please justify the motivation
by adding "it currently does _this_, which is not good for _such and such
reasons_; instead" between the third and the fourth line.

> - Use To: field extracted from patch
>   I've setup format-patch to add a default To: field with
>   format.headers="To: xxx@yyy". But git send-email did not use it and 
>   ask for a To: value.
>   If there's no --to or sendmail.to, send-email should use To: value 
>   extracted from patch and ask for user confirmation.

With the recent addition of format.to that is cooking somewhere, I think
this one is probably sensible.
