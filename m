From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help creating git alias
Date: Thu, 31 Oct 2013 11:07:19 -0700
Message-ID: <xmqqd2ml8gbs.fsf@gitster.dls.corp.google.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
	<CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
	<xmqq61sebhh3.fsf@gitster.dls.corp.google.com>
	<CAPZPVFarK_jKpM2f62mErAmL+mck6EN1QPfHDHqqfJbJ2AfzXg@mail.gmail.com>
	<xmqqk3gu9jst.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYFSBRHThO08LmuN_0fc55gYX-A+Y3=yA_MESko1t6fXQ@mail.gmail.com>
	<20131031174008.GA39079@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>,
	Andrew Ardill <andrew.ardill@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:07:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbweW-0003Ay-T3
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab3JaSHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:07:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435Ab3JaSHY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:07:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11644E2A5;
	Thu, 31 Oct 2013 14:07:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Df/6GYwTEgid5mvKqsrl721TOc=; b=moFB7M
	9YAFgHu+WuJLDYZJ3CHX5QS+q5ffO9SPTcGHVMo6MqurYi4dmm+Sjx65OHRkOHA+
	S2UbCmzX1w4wj9TybkQHm/ylE2wsOIi4WhC3/7vz81RBocHbV+PS/pI9qcMQBFX1
	RtaBOwC7ddexcacK36hl7PKjzEBuz18oCF6P0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OULwQ8fNlbvDBijk0kUSZF/Yy/5nsoh9
	aV6cvhy5+RWaKf3ZjF7fFuBlIPFig6j+MP3AdltVUdX4ky2RjnIxfHbISyOPcF2S
	4uOKsjX2erOVQ+C8+/1cp+1FtxzWawwhqV7CO4go+qZg+0/TNbRJodZm/wpE7zYi
	kAoQ4+v+UGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CECA04E2A3;
	Thu, 31 Oct 2013 14:07:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F3C44E29E;
	Thu, 31 Oct 2013 14:07:23 -0400 (EDT)
In-Reply-To: <20131031174008.GA39079@gmail.com> (David Aguilar's message of
	"Thu, 31 Oct 2013 10:40:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4A89B106-4257-11E3-B2D4-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237137>

David Aguilar <davvid@gmail.com> writes:

> A-ha.. I think adding the chdir to alias is possible using a function.

You do not have to use a function to do so, no?
