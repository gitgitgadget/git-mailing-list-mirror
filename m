From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] gitweb: add project_filter to limit project list
 to a subdirectory
Date: Wed, 01 Feb 2012 12:55:50 -0800
Message-ID: <7vpqdy2rzd.fsf@alter.siamese.dyndns.org>
References: <20120128165606.GA6770@server.brlink.eu>
 <20120130095252.GA6183@server.brlink.eu>
 <20120130114557.GB9267@server.brlink.eu>
 <201201301657.12944.jnareb@gmail.com>
 <20120130200355.GA2584@server.brlink.eu>
 <7v39axaq0v.fsf@alter.siamese.dyndns.org>
 <20120201165902.GA14706@server.brlink.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Bernhard R. Link" <brl+git@mail.brlink.eu>
X-From: git-owner@vger.kernel.org Wed Feb 01 21:56:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RshDi-0000TU-KL
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 21:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab2BAUzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 15:55:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab2BAUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 15:55:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 473F554F9;
	Wed,  1 Feb 2012 15:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S77kU+gK73K6ogqw11JsEME4H0U=; b=qFfLQi
	PWS320zFrK0t/au/4+qYOXUBsQ8SaEMe+cr+yCMdV3Nc5diDFcQmWNeB0iVOsY3L
	s9x2pO0y9ftiUVYopHogusjCcJYx8fCJuwCvSLaZO/wC/eQtUZMh/wuS6Ab9JBNH
	tGPfc1AmFhJq7F2FRsEAsslia3Pkl/CLzF/qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jrw/YHR94iKWElTTPwuKEI+Up9NiW6cO
	JtJVbmmxZTwt3f2dDczPi/3/lT85EzpY0St7LKZutYDcByp7yhdZq7mMw/Gb1x2T
	um0123PeFym2TsTe4rco88p4TWggJlVH4lBCCTT56WkczwEoqD3f7KiDMk0/eus7
	AFFwki5JqBI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F19754F7;
	Wed,  1 Feb 2012 15:55:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C73DE54F6; Wed,  1 Feb 2012
 15:55:51 -0500 (EST)
In-Reply-To: <20120201165902.GA14706@server.brlink.eu> (Bernhard R. Link's
 message of "Wed, 1 Feb 2012 17:59:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 203CEC74-4D17-11E1-8D2C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189536>

"Bernhard R. Link" <brl+git@mail.brlink.eu> writes:

> Look liks a change like that is actually needed...
> ... So it looks for forks in a directory named '1'

Yeah, that was exactly what was causing failures in 9502.  Fixed locally
so no further action is required.

Thanks.
