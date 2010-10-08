From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5503: fix typo
Date: Fri, 08 Oct 2010 14:11:09 -0700
Message-ID: <7viq1cv18y.fsf@alter.siamese.dyndns.org>
References: <a4b0ff35d302b50fc403a7445134b72931894148.1286571734.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 08 23:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4KDw-00023U-5K
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 23:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914Ab0JHVLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 17:11:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759693Ab0JHVLU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 17:11:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30D8ADC255;
	Fri,  8 Oct 2010 17:11:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lJQwW+TIRRSb2wdBsnxKQxOMz5w=; b=IHWViG
	OLiZbwb1BDmXbmkMJk3+qsysWEblvaXD+eWzNJi0U68f5afLaLTseIy6lMqcDy8t
	gnq3oJbkaDr0RDXCX3RGb3SPCJ77gkOkS1tf5s5x0jN54kV3GB3LsudWnH4suU5n
	Nt1LNka7k9w7YtyiUQ9ulIfcE3pLht0H21u3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CQhlj+WxcQ72yGuaeEM+ijRPR0iGwwkp
	uhyWJ/AIUPg9IPd2XvrMEl/wz2rtI1FiHL3hFkU5ysBakf7e8jZ3SvVxZFwx36PB
	YMVf9zpTcOR+qn8oxQWnKWe6Guis/EPQhadRPqtIK4salbiTJggqjywJTbavjyCm
	X49CF4fE9fk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E74B1DC254;
	Fri,  8 Oct 2010 17:11:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34E54DC241; Fri,  8 Oct
 2010 17:11:11 -0400 (EDT)
In-Reply-To: <a4b0ff35d302b50fc403a7445134b72931894148.1286571734.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\,  8 Oct 2010 23\:03\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95BF9EFA-D320-11DF-957A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158541>

Thanks; I should have been more careful pulling from others.
