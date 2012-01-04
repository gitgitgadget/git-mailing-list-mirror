From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Catch invalid --depth option passed to clone or fetch
Date: Wed, 04 Jan 2012 09:43:39 -0800
Message-ID: <7v8vlnqs6s.fsf@alter.siamese.dyndns.org>
References: <1325671315-24931-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 18:43:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiUsN-0001YR-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 18:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558Ab2ADRnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 12:43:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33395 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2ADRnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 12:43:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EE3356DA;
	Wed,  4 Jan 2012 12:43:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=EAJxX0
	hRxP69yy9wW7pcsxhGmc0HVhNfVLbp2+Kj4sUkwIeQY0O7A6xi3zW5s7NMyFqkS8
	YXahYh9+T2YWa2yTWFYA0hMG7BDZv0bzIZj021z6OrS+tiOXlCSweIwkKxCWy2I7
	CMiZi1jMrcvG5GBUvL2u3nmnc2VrZ+ZaJgHcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=home/Qk9VTjcgePhWuG1vas0dDqCOHIN
	VF+RUdvNzjBT+9IztbY/kfgYa6Oid1U5HOF565I2CNbG9U8h+1DvTf8c42fJSNZc
	SyqP4g21wEfYof0r1VJQvqNXLM6v2jZ946XJFqRa+EcfPvCFRYERf8t6AtWRKmAr
	wMOYUPd0Aa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5766B56D9;
	Wed,  4 Jan 2012 12:43:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3CEC56D7; Wed,  4 Jan 2012
 12:43:40 -0500 (EST)
In-Reply-To: <1325671315-24931-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 4 Jan
 2012 17:01:55 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3A6977C-36FB-11E1-A6EB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187934>

Thanks.
