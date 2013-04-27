From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add missiong format-patch options
Date: Sat, 27 Apr 2013 14:36:14 -0700
Message-ID: <7vy5c3slkh.fsf@alter.siamese.dyndns.org>
References: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCn7-0004Sh-8Q
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab3D0VgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:36:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521Ab3D0VgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:36:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BDEA1A9FD;
	Sat, 27 Apr 2013 21:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tjGv1ewVmVjQH5oLEIvZT8abPBU=; b=Xlz/Ay
	8mDd4YzFmKUed8xrAlfOopee1v3JoMnD0+zjH+cyP86/PJu5jzrl9Tztf+mxuQQP
	uC9OLfARvqcfofZBAh30m2vKNWwqNSURDJ95dVfMnX8krMhjbydI+MTsjik+Z4IX
	+Y6vqPdiXQYzI+vs9W532uHmu+c4wd2pQVM10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ibfs0vMiSe0HJpGAbbX/tBjNCSIRevpX
	6B+FU8t1JHlMrFoq7THDSWjHWXXCNdSsgumOiLVwtEFLh/s956ldwJOAg9i+7Lbt
	tXwA+3tFRKYimrzXtKtbu4vfvvgvY861VVwPayVcTkRCXLtuJxG8+XMhS2iGaigJ
	TzdlYsfnrUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70A131A9FC;
	Sat, 27 Apr 2013 21:36:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E78031A9FB;
	Sat, 27 Apr 2013 21:36:15 +0000 (UTC)
In-Reply-To: <1367093864-9362-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 15:17:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D6F3252-AF82-11E2-A935-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222703>

Looks like a no-brainer-safe update that could even go to maint.  I
prefer not to have too many patches in the "trivially correct"
category in flight, so will apply directly on top of 'master'.

Thanks.
