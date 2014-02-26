From: Junio C Hamano <gitster@pobox.com>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Wed, 26 Feb 2014 11:58:53 -0800
Message-ID: <xmqqzjld3ate.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:59:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkdC-000241-DW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbaBZT66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 14:58:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698AbaBZT65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 14:58:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ABCA6E93E;
	Wed, 26 Feb 2014 14:58:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HF+LR9Ay7eIyuHK7/oOuzQoc1Mo=; b=bBzkBu
	riCgZ9lzX96yQD2r5+1fF2CR1Z8zippvyHDX5KwEDdmNHsFuBMSnetU7aE89mDUy
	VOwJ1owbyAxCBGReMN2AsrO/4OyeEsNLi/zr94ERpUZn6GOVVT4JSfbFVnHyKVjt
	4Ml6J4O6lbcuOnsetTq/eIoLY9nYtC25dQINE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxAlPTlE6oCWyX7tmreBV3vJVj7iFAkN
	Lfw4t5V+ziwdsQjqXkqA3PxlHH7q5ykDr3xHoX02/La6G8dy9SJsK5Rjzf7qu2rb
	cijP4bANxsURF0iLj9vonov4NRXVIzOKm39VaM5pTWQDnhHBYETkYQF3gtZVoQY8
	Ovjc89/L0/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E91E36E93D;
	Wed, 26 Feb 2014 14:58:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1681D6E93B;
	Wed, 26 Feb 2014 14:58:56 -0500 (EST)
In-Reply-To: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com>
	(Jacopo Notarstefano's message of "Wed, 26 Feb 2014 09:28:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6C9939E4-9F20-11E3-AA34-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242753>

Jacopo Notarstefano <jacopo.notarstefano@gmail.com> writes:

> Does this make sense? Did I overlook some details?

How does this solve the labels shown in "git bisect visualize"?
