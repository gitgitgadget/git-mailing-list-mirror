From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] transport-helper: updates
Date: Thu, 29 Aug 2013 12:22:12 -0700
Message-ID: <xmqqwqn42tgb.fsf@gitster.dls.corp.google.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 21:22:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7nQ-0006bR-Fj
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 21:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756907Ab3H2TWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 15:22:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756218Ab3H2TWP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 15:22:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A689A3D391;
	Thu, 29 Aug 2013 19:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vgXJ22kkOnVFap4eNwpnsDrj7j8=; b=YE1CyK
	833cDr+KCN+nEngTJ41tgJe57f4XNqFXaHpohBT7pI2Lu1KcIt2UJuY2dpZzf61d
	oGHlb84qeAtZUSnOahb1NYHzYwjOt4zeG9RjUF2mERuNeeUNeQsOByiKh/TJ5rf1
	HuJPeh7Ot5IjcJefe1k0blpHRPa0LHyOTFHNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikK1erwUMzZ621tUVDIgM5Ethx1uxpDt
	UrwiZprPiUgDm7f5XJ7BR9Yz+rI6WSp6E/U0GWK4CfNIgHyW1jH7a5IwZF90VdYV
	Wa+V/9ZDxyzBadGBxg+hJQng08A1ltQ++nFYzH/AIB0f0/WGpyUZAZzmllKMIJjD
	V1Ajzv0HBvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4B93D38F;
	Thu, 29 Aug 2013 19:22:14 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFD133D38E;
	Thu, 29 Aug 2013 19:22:13 +0000 (UTC)
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 29 Aug 2013 10:23:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4F3B7D0E-10E0-11E3-95C2-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233347>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some of these were were sent before and rejected without a
> reason,...

Earlier, you were asked to leave because many constructive criticism
or suggestion for improvement to your patches in reviews led to
stubborn resistance, ended up wasting everybody's time and left a
bad atmosphere on the list.

It seems that Matthew is trying to see if you can work better with
others than before after a break, but I personally am not hopeful
yet and do not want to waste my/our time on flamewars like we saw in
the past.

So I'll look at these and may pick patches that are obviously and
trivially good, but will refrain from asking clarifications and
suggesting improvements, etc. on other patches that I suspect will
end up wasting the time of people again.  Do not take silence from
me as a silent agreement.
